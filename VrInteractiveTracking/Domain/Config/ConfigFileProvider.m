//
//  ConfigFileProvider.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/20.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "ConfigFileProvider.h"

#import "ConfigValidator.h"
#import "ConfigSetterValidator.h"
#import "ConfigQueParams.h"
#import "ConfigValueAdapter.h"
#import "../../Logic/TrackingEnableStrategy.h"
#import "../../Common/XMLParser.h"
#import "../../Common/XMLPull.h"
#import "../VRIException.h"
#import "../Internet.h"

//NSString *const VR_LIB_DEFAULT_FILE_NAME = @"vrTrackingConfig";
//NSString *const VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY = @"default";

@interface ConfigFileProvider()

// 設定ファイルのリスト（キー：identity）
@property (nonatomic) __block NSMutableDictionary *configFileList;
// 設定ファイルの更新待ちリスト
@property (nonatomic) __block NSMutableArray *configQue;
// パース作業中かどうかのフラグ
@property (nonatomic) __block BOOL isRunning;

@property (nonatomic, copy) NSString *outsideConfigURL;

@property (nonatomic) __block XMLPull *xmlPull;
@property (nonatomic) __block XMLParser *xmlParser;

@end

@implementation ConfigFileProvider

/**
 * コンストラクタ
 */
-(id) initWithOutsideConfigURL:(NSString *)outsideConfigURL callback:(ConfigStatusCallback) callback {
    if((self = [super init])){
        _listener = callback;
        _configFileList = [NSMutableDictionary dictionary];
        _configQue = [NSMutableArray array];
        _isRunning = NO;
        _outsideConfigURL = [outsideConfigURL copy];
        
    }
    return self;
}

/**
 パスをもとにコンフィグファイルを初期化
 
 複数のコンフィグファイルを保持し、インデックス名をキーとして返す

 @param param パースに必要な情報群
 */
-(void) initConfig:(ConfigQueParams *)param {

//    @synchronized(self) {
    
        NSLog(@"Start initConfig");
        
        _xmlParser = nil;
        
        // イニシャライズで設定されているURLが有効か判断
        if (param.filePath.length != 0 && [self isHTTP:param.filePath]) {
            // 有効なURLなので外部から取得
            [self getXMLFile:param.filePath identity:param.identity configTimeout:[[_configFileList objectForKey:param.identity] getConfig_timeout]];
        }
        else {
            // アプリ内のファイルを取得
            [self parseXMLWithFilePath:param.filePath identity:param.identity date:nil remoteFile:NO];
        }
        
        NSLog(@"End initConfig");
        
//    }
}

/**
 * 外部と通信をするかを判断し返す
 * 「http://」「https://」で開始されているかを判定する.
 *
 * @return 結果(YES = 通信, NO = ローカルパス)
 */
-(BOOL) isHTTP:(NSString*) url {
    if ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) {
        return YES;
    }else {
        return NO;
    }
}

/**
 * 設定ファイルの処理をキューに登録
 *
 * @param identity アイデンティティ
 * @param fileName サーバーパスと内部パスを含む
 *
 */
- (void) addConfigWithIdentity:(NSString*) identity fileName:(NSString *)fileName{
    NSLog(@"wait...");
    @synchronized (self) {
        NSLog(@"addConfigWithIdentity identity = %@, file name = %@",identity, fileName);
        
        // 設定ファイルのキューに追加
        ConfigQueParams *param = [ConfigQueParams new];
        param.identity = identity;
        NSLog(@"%@", fileName);
        param.filePath = [self getLocalConfigFilePath:fileName];

        [_configQue addObject:param];
        
        // 設定ファイルを解析
        [self pop];
    }
}

/**
 * キューに入っている一番上の設定ファイルをパース
 *
 */
- (void) pop {
//    @synchronized (self) {
        NSLog(@"pop start");
        
        // リストチェック
        if ([_configQue count] == 0) {
            NSLog(@"Config que is empty");
            return;
        }
        
        // 実行ファイルを取得
        ConfigQueParams *params = [_configQue firstObject];
        
        // 他の設定ファイルを設定中か判断
        if (_isRunning) {
            NSLog(@"Config is running. return.");
            return;
        };
        
        // 作業フラグ
        _isRunning = YES;
        
        // コールバック
        _listener(YES, params.identity);
        
        NSLog(@"before initConfig");
        
        // 実行
        [self initConfig:params];
        
        NSLog(@"pop end");
//    }b
    
    
}

#pragma mark - XML Parser
/**
 * 設定ファイルをパースして配列に保持
 *
 * @param filePath 設定ファイルまでのパス
 *
 */
-(void) parseXMLWithFilePath:(NSString*) filePath identity:(NSString*) identity date:(NSString*) date remoteFile:(BOOL)isRemoteFile {
    NSLog(@"parseXMLWithFilePath");

    XMLParser *xmlParser = [[XMLParser alloc] init];
    [xmlParser parseXML:filePath identity:identity date:date isRemoteFile:isRemoteFile callback:^(NSMutableArray *configFileArray, BOOL isRemoteFile) {
        
        BOOL hasRemote = NO;
        @try {
            
            for (ConfigFile *configFile in configFileArray) {

                @try {
                    // 正常ファイルか判断
                    ConfigValidator *validator = [[ConfigValidator alloc] initWithValidationHandler:[ConfigValidationHandler new] config:configFile];
                    configFile.isNormal = ![[validator handler] errors];
                    NSLog(@"Validate result = %@", configFile.isNormal?@"YES":@"NO");
                    
                    if (![[validator handler] errors]) {
                        // リストに存在しなければリストに追加、あれば上書き
                        [_configFileList setObject:configFile forKey:[configFile getIdentity]];
                    }else {
                        //            NSLog(@"XML parse error in parseXMLWithFilePath %@",[[validator handler] toString]);
                        @throw [VRIException exceptionWithMessage:[[validator handler] toString]];
                    }
                    
                    
                    // ローカル
                    if (!isRemoteFile) {
                        NSLog(@"End Local file");
                        // config_urlの値に値があれば取得する
                        if (![self isCheckedConfigUrl:configFile] || !configFile.isNormal) {
                        } else {
                            hasRemote = YES;
                            // リモート設定ファイルを取得
                            ConfigQueParams *param = [ConfigQueParams new];
                            param.identity = identity;
                            if ([identity isEqualToString:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY] && [_outsideConfigURL length] != 0) {
                                param.filePath = _outsideConfigURL;
                            }else {
                                param.filePath = configFile.getConfig_Url;
                            }
                            
                            [_configFileList setObject:configFile forKey:[configFile getIdentity]];
                            
                            [self initConfig:param];
                        }
                    }
                    // リモート
                    else {
                        [_configFileList setObject:configFile forKey:[configFile getIdentity]];
                    }
                } @catch (NSException *exception) {
                    DLog(@"%@", [exception reason]);
                    // 何もないと困るので、最低限isNormalがFalseの設定ファイルをセット
                    if (![_configFileList objectForKey:[configFile getIdentity]]) {
                        configFile.isNormal = NO;
                        [_configFileList setObject:configFile forKey:[configFile getIdentity]];
                    }
                }
            }
        } @catch (NSException *exception) {
            DLog(@"%@", [exception reason]);
        }
        if (!hasRemote) {
            [self finish:identity];
        }
    }];
}

- (void)finish:(NSString *)identity {
    @try {
        // 実行したキューを削除
        if (_configQue && _configQue.count > 0) {
            [_configQue removeObjectAtIndex:0];
        }
        // コールバック
        if (_listener) {
            _listener(NO, identity);
        }
    } @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
    }
    // 作業フラグを下ろす
    _isRunning = NO;
    @try {
        // 処理が終了したので、次のキューを実行
        [self pop];
        
    } @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
    }
}

/**
 * ローカルファイルにサーバーの設定ファイルがあれば parseXM を改めて呼び出す
 *
 * @param configFile ローカルの設定ファイル
 *
 */
- (BOOL) isCheckedConfigUrl:(ConfigFile *) configFile {
    
    // config_urlが空文字か判断
    if ([configFile.getConfig_Url length] == 0) {
        NSLog(@"config_url is empty");
        return NO;
    }
    
    
    NSLog(@"Move Remote file");
    
    return YES;
}


#pragma mark - Get XML File From Cloud

/**
 * サーバーの設定ファイルを取得するために
 * XMLPullクラスを呼び出し
 *
 * @param url サーバーパス
 *
 */
-(void) getXMLFile:(NSString*) url identity:(NSString*) identity configTimeout:(NSString *)configTimeout {
    
    // 通信接続可能ならサーバから設定ファイルを取得
    if (![Internet isOnline]) {
        // 通信不可の場合、何もしない
        @throw [VRIException exceptionWithMessage:@"Network is not connected."];
        return;
    }
    
    _xmlPull = [[XMLPull alloc] init];
    [_xmlPull getXml:url identity:identity configTimeout:configTimeout callback:^ (NSString *configFilePath, NSString *date, NSString *identity, NSString *filePath) {
        @try {
            
            NSString *dateCpy = [date copy];
            NSString *cacheFilePath = [configFilePath copy];
            
            if ([configFilePath length] == 0) {
                NSLog(@"Cloud config file is nil");
                [self finish:identity];
                return;
            }else {
                
                NSLog(@"Cloud config file is not nil");
            }
            
            
            // パース
            [self parseXMLWithFilePath:cacheFilePath identity:identity date:dateCpy remoteFile:YES];
        } @catch (NSException *exception) {
            DLog(@"%@", [exception reason]);
        }
        
    }];    
}

/**
 設定ファイルの定義値を上書き

 @param configFileValue 設定ファイルの定義値
 */
- (void) setConfig:(NSDictionary*) configFileValue identity:(NSString *)identity {
    
    
    NSMutableDictionary *original = [[[_configFileList objectForKey:identity] getElements] mutableCopy];
    
    // cast all value
    NSDictionary *configFileAdaptedValues = [ConfigValueAdapter castAllValue:configFileValue];
    
    [original setDictionary:configFileAdaptedValues];
//    [original setValuesForKeysWithDictionary:configFileAdaptedValues];
//    for (NSString *key in configFileAdaptedValues) {
//        [original setObject:[configFileAdaptedValues objectForKey:key] forKey:key];
//    }
    
    ConfigFile *configFile = [[ConfigFile alloc] initWithParams:original];;
    
    
    // 正常ファイルか判断
    ConfigSetterValidator *validator = [[ConfigSetterValidator alloc] initWithValidationHandler:[ConfigValidationHandler new] config:configFile];
    configFile.isNormal = ![[validator handler] errors];
    NSLog(@"Validate result = %@", configFile.isNormal?@"YES":@"NO");
    
    if ([[validator handler] errors]) {
        @throw [VRIException exceptionWithMessage:[[validator handler] toString]];
    }
    
    // 上書き処理
    NSMutableDictionary *configElements = [[[_configFileList objectForKey:identity] getElements] mutableCopy];
    for (NSString *key in configFileAdaptedValues) {
        [configElements setObject:[configFileAdaptedValues objectForKey:key] forKey:key];
    }
    ConfigFile *newOne = [[ConfigFile alloc] initWithParams:configElements];
    ConfigFile *oldOne = [_configFileList objectForKey:identity];
    newOne.isNormal = oldOne.isNormal;
    newOne.filePath = oldOne.filePath;
    newOne.date = oldOne.date;
    newOne.identity = oldOne.identity;
    
    // 該当の設定ファイルに上書きする
    [_configFileList setObject:newOne forKey:identity];

}

- (void)setElement:(ConfigFile *)con key:(NSString *)key value:(NSString *)value {
    if ([key isEqualToString:@"vr_tagid1"]) {
        [con setVr_TagId1:value];
    }else if ([key isEqualToString:@"vr_tagid2"]) {
        [con setVr_TagId2:value];
    }else if ([key isEqualToString:@"config_url"]) {
        [con setConfig_Url:value];
    }else if ([key isEqualToString:@"disabled"]) {
        [con setDisableWithString:value];
    }else if ([key isEqualToString:@"config_timeout"]) {
        [con setConfig_timeout:value];
    }else if ([key isEqualToString:@"beacon_timeout"]) {
        [con setBeacon_timeout:value];
    }else if ([key isEqualToString:@"beacon_url"]) {
        [con setBeacon_url:value];
    }
}


/**
 * デフォルトの設定ファイルを返す。
 *
 * @return 設定ファイル
 */
-(ConfigFile*)loadConfig{
    return [self loadConfig:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY];
}

/**
 * 指定のファイルがあれば取得
 *
 * @param identity 指定する設定ファイルのタイトル（初期化時に指定したもの）
 * 一つも設定ファイルがない場合、nilを返す
 *
 * @return 指定の設定ファイル（異常ファイルの場合ローカルファイル）
 */
-(ConfigFile*) loadConfig:(NSString*) identity {
    NSString *fixedIdentity = identity;
    if (!identity) {
        fixedIdentity = VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY;
    }
    
    // 対象の設定ファイルがあるか判断
    if (![_configFileList objectForKey:fixedIdentity]) {
        @throw [NSException exceptionWithName:@"ConfigFileNotFoundException" reason:@"There is no config file." userInfo:nil];
    }
    
    NSLog(@"loadConfig : identity = %@, dic = %@",fixedIdentity, [_configFileList description]);
    
    // 対象の設定ファイルが正常か判断
    if ([[_configFileList objectForKey:fixedIdentity] isNormal]) {
        return [_configFileList objectForKey:fixedIdentity];
    }else {
        @throw [NSException exceptionWithName:@"ConfigFileNotFoundException" reason:@"This config file has error. Please check ConfigXML." userInfo:nil];
    }
}

- (BOOL)hasConfigFileWithIdentity:(NSString *)identity {
    NSString *fixedIdentity = identity;
    if (!identity) {
        fixedIdentity = VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY;
    }
    return [_configFileList objectForKey:fixedIdentity];
}

/**
 ローカル設定ファイルを取得
 
 @param fileName ファイル名
 @return ファイルパス
 */
- (NSString *)getLocalConfigFilePath:(NSString *)fileName {
    // Documentsディレクトリパス
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirPath = [path objectAtIndex:0];
    NSString *configPath = [[documentsDirPath stringByAppendingPathComponent:@"Config"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml",fileName]];
    // Documents配下に設定ファイルがあるかを判定
    if ([[NSFileManager defaultManager] fileExistsAtPath:configPath] == NO) {
        configPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
    }
    NSLog(@"Local config6 file path = %@", configPath);
    return configPath;
}


@end

