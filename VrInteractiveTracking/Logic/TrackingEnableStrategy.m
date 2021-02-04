//
//  TrackingEnableStrategy.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/17/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "TrackingEnableStrategy.h"

NSString *const VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY = @"default";
NSString *const VR_LIB_DEFAULT_LOCAL_V_FILE_IDENTITY = @"default-v";
NSString *const VR_LIB_DEFAULT_FILE_NAME = @"vrTrackingConfig";
NSString *const VR_LIB_DEFAULT_V_FILE_NAME = @"vrTrackingVConfig";

@interface TrackingEnableStrategy()

@property (nonatomic, copy) NSString *appName;
@property (nonatomic, copy) NSString *eventName;
@property (nonatomic, copy) NSString *monitorId;
@property (nonatomic, copy) NSString *outsideConfigURL;
@property (nonatomic) BOOL optFlg;

@property (nonatomic, copy) VrInteractiveTrackingSpec *trackingSpec;
@property (nonatomic, copy) VrInteractiveBeaconSpec * beaconSpec;
@property (nonatomic) QuerySpec *vrQuerySpec;
@property (nonatomic) QuerySpec *vQuerySpec;
@property (nonatomic) ConfigFileProvider *configFileProvider;
@property (nonatomic) BeaconProvider *beaconProvider;
@property (nonatomic) SendAcceptor *acceptor;
@property (nonatomic) NSMutableArray *replaceConfigQueue;
@property (nonatomic) ConfigMediator *loadBlockManager;
@property (nonatomic) VrQueryParameter *vrParameter;
@property (nonatomic) VQueryParameter *vParameter;

@property (nonatomic) SessionID *sessionID;

@property (nonatomic, copy) FinishInitBlock finishInitBlock;
@property (nonatomic, copy) FinishLoadBlock finishLoadBlock;

@end

@implementation TrackingEnableStrategy


/**
 イニシャライザ

 
 @param trackingSpec spec
 @return self
 */
- (instancetype)initWithAppName:(VrInteractiveTrackingSpec *)trackingSpec {
    
    self = [super init];
    if (self) {
        _trackingSpec = trackingSpec;
        _appName = trackingSpec.appName;
        _eventName = trackingSpec.eventName;
        _monitorId = trackingSpec.monitorId;
        _optFlg = trackingSpec.optFlg;
        _outsideConfigURL = trackingSpec.outsideConfigURL;
        _finishInitBlock = trackingSpec.finishInitBlock;
        [trackingSpec setFinishInitBlock:nil];
        _replaceConfigQueue = [NSMutableArray array];
        _acceptor = [SendAcceptor new];
        [_acceptor updateWithIdentity:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY state:NO];
        [_acceptor updateWithIdentity:VR_LIB_DEFAULT_LOCAL_V_FILE_IDENTITY state:NO];
        _loadBlockManager = [ConfigMediator new];
        _vrParameter = [VrQueryParameter new];
        _vParameter = [VQueryParameter new];
        _sessionID = SessionID.new;
        
        NSLog(@"initWithAppName start 1");
        
        _configFileProvider = [[ConfigFileProvider alloc] initWithOutsideConfigURL:_outsideConfigURL callback:^(BOOL isRunning, NSString *identity) {
              NSLog(@"config file provider callback : identity = %@, status = %@", identity, isRunning?@"RUNNING":@"STAND_BY");
              if (!isRunning) {
                  
                  [_acceptor updateWithIdentity:identity state:YES];
                  
                  if ([_replaceConfigQueue count] != 0) {
                      NSLog(@"Entry replace config queue");
                      NSMutableArray *discards = [NSMutableArray array];
                      int i =0;
                      for (ReplaceConfig *replaceConfig in _replaceConfigQueue) {
                          NSLog(@"identity=%@", identity);
                          if ([[replaceConfig getIdentity] isEqualToString:identity]) {
                              NSLog(@"%@", [replaceConfig.configParams description]);
                              [_configFileProvider setConfig:[replaceConfig getConfigParams] identity:[replaceConfig getIdentity]];
                              [discards insertObject:[NSNumber numberWithInt:i] atIndex:0];
                          }
                          i++;
                      }
                      
                      for (NSNumber *i in discards) {
                          [_replaceConfigQueue removeObjectAtIndex:[i integerValue]];
                      }
                  }
                  
                  // コールバック
                  if ([_acceptor isOkWithIdentity:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY] && [_acceptor isOkWithIdentity:VR_LIB_DEFAULT_LOCAL_V_FILE_IDENTITY] && _finishInitBlock) {
                      NSLog(@"default callback");
                      _finishInitBlock(YES);
                      _finishInitBlock = nil;
                  }
                  
                  [_loadBlockManager callback:identity result:[[_configFileProvider loadConfig:identity] isNormal]];
                  
                  // 設定が完了したので、該当のidentityのビーコン送信処理を実行
                  [_beaconProvider sendQueue:[_configFileProvider loadConfig:identity]];
              }
          }];
        _beaconProvider = [BeaconProvider new];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
            NSLog(@"initWithAppName start 2");
            
            @try {
                NSLog(@"initWithAppName start 3");
                [HouseKeeper drop];
                
                // ローカルファイルをパース
                [_configFileProvider addConfigWithIdentity:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY fileName:VR_LIB_DEFAULT_FILE_NAME];
                [_configFileProvider addConfigWithIdentity:VR_LIB_DEFAULT_LOCAL_V_FILE_IDENTITY fileName:VR_LIB_DEFAULT_V_FILE_NAME];
                
                
                NSLog(@"initWithAppName end 3");
            } @catch (NSException *exception) {
                NSLog(@"%@", [exception reason]);
                if (_finishInitBlock) {
                    _finishInitBlock(NO);
                }
            }
            NSLog(@"initWithAppName end 2");
        });
        
        NSLog(@"initWithAppName end 1");
        
        NSLog(@"TrackingEnableStrategy class is finished");
    }
    return self;
}


#pragma mark - UUID

/**
 UUIDを取得する

 
 @return UUID
 */
- (NSString *)uuId {
    NSString *uuid = [UUID load];
    if (uuid == nil) {
        [UUID save];
        uuid = [UUID load];
    }
    return uuid;
}

/**
 UUIDを強制的に上書き
 追加メソッド
 
 @param uuid UUID
 */
- (void) updateUUID:(NSString*) uuid {
    
    if (![Opt isOptout]) {
        // 上書き
        [UUID update:uuid];
    }
}

/**
 * 新しいUUIDを割り当て
 *
 */
- (void)replaceUUID {
    
    if (![Opt isOptout]) {
        // 新しいUUIDを生成
        [UUID replace];
    }
}


/**
 拡張フィールド用変数の初期化
 */
- (void)clearAllVrOptValueWithAppName {
    [_vrQuerySpec clearAllParameters];
}

/**
 拡張フィールド用変数を設定する
 
 @param optValue 拡張フィールド用の値
 @param optKey 拡張フィールド用のキー
 @return 結果(YES = 成功, NO = 失敗)
 */
- (BOOL)setVrOptValue:(NSString *)optValue forOptKey:(NSString *)optKey {
    [self vrQuerySpecInit];
    // デフォルトの拡張フィールドに設定する
    NSLog(@"setVrOptValue_1 key=%@, value=%@", optKey, optValue);
    [[_vrQuerySpec getQueryParameters] add:optKey value:optValue];
    NSLog(@"setVrOptValue_2 key=%@, value=%@", optKey, optValue);
    // 結果を返却
//    return [[[[_querySpec getQueryParameters] getValue:optKey] value] isEqualToString:optValue];
    return true;
}

/**
 拡張フィールド用変数を直感的に設定する
 追加メソッド
 
 @param builder 拡張フィールド用の変数番号1〜9を設定できるビルダー
 */
- (void)setVrOptValue:(void (^)(OptValues *)) builder {
    [self vrQuerySpecInit];
    
    // ビルダー生成
    OptValues *optValues = [OptValues new];
    builder(optValues);
    
    // 追加
    [_vrQuerySpec addParametersWithBuilder:optValues];
}

/**
 拡張フィールド用変数を取得する

 @param optValue 拡張フィールド用の変数
 @return 拡張フィールド用の値
 */
- (NSString *)optValueByString:(NSString *)optValue {
    QueryParameter *qp = [[_vrQuerySpec getQueryParameters] getValue:optValue];
    NSLog(@"optValueByString key=%@, value=%@", optValue, qp.value);
    if (qp) {
        return qp.value;
    }else {
        return nil;
    }
}

/**
 Vタグ拡張フィールド初期化
 */
- (void)clearAllVValue{
    [_vQuerySpec clearAllParameters];
}

/**
 Vタグ拡張フィールド一括設定
 
 @param vValues 拡張フィールド用のビルダー
 */
- (void)setVValue:(void (^)(VValues *))vValues {
    [self vQuerySpecInit];
    VValues *builder = [VValues new];
    vValues(builder);
    [[_vQuerySpec getQueryParameters] addAll:[builder build]];
}

/**
 Vタグ拡張フィールド取得
 
 @param fieldName 拡張フィールド名
 @return 拡張フィールドの値
 */
- (NSString *)getVValue:(NSString *)fieldName {
    QueryParameter *qp = [[_vQuerySpec getQueryParameters] getValue:fieldName];
    DLog(@"getVValue key=%@, value=%@", fieldName, qp.value);
    if (qp) {
        return qp.value;
    }else {
        return nil;
    }
}


#pragma mark - SendBeacon

/**
 ビーコンを送信する（Identity有）（コールバック有）
 既存＋追加メソッド

 @param beaconSpec BeaconSpec
 */
- (void)sendBeaconWithEventName:(VrInteractiveBeaconSpec *)beaconSpec {
    
    @try {
        _beaconSpec = beaconSpec;
        id<Config> config = [_configFileProvider loadConfig:beaconSpec.identity];
        if ([kVR isEqual:[config getTagType]]) {
            
            // QuerySpecクラスのインスタンスを作成
            [self vrQuerySpecInit];
            
            // 引数群をQuerySpecに格納
            [[_vrQuerySpec getQueryParameters] addAllWithQueryParameters:[_vrParameter toQueryParametersWithVrInteractiveTrackingSpec:_trackingSpec beaconSpec:_beaconSpec]];
            
            // キューに登録
            if ([_configFileProvider hasConfigFileWithIdentity:beaconSpec.identity]) {
                [_beaconProvider addWithQuerySpec:beaconSpec.url
                       spec:_vrQuerySpec
                 configFile:[_configFileProvider loadConfig:beaconSpec.identity]
                      state:[_acceptor isOkWithIdentity:beaconSpec.identity]
                finishBlock:beaconSpec.finishSendBeaconBlock];
            }else if(beaconSpec.finishSendBeaconBlock){
                beaconSpec.finishSendBeaconBlock(NO);
            }
        }else {
            // QuerySpecクラスのインスタンスを作成
            [self vQuerySpecInit];
            
            // 引数群をQuerySpecに格納
            [[_vQuerySpec getQueryParameters] addAllWithQueryParameters:[_vParameter toQueryParametersWithVrInteractiveTrackingSpec:_trackingSpec beaconSpec:_beaconSpec sessionID:_sessionID]];
            
            // キューに登録
            if ([_configFileProvider hasConfigFileWithIdentity:beaconSpec.identity]) {
                [_beaconProvider addWithQuerySpec:beaconSpec.url
                       spec:_vQuerySpec
                 configFile:[_configFileProvider loadConfig:beaconSpec.identity]
                      state:[_acceptor isOkWithIdentity:beaconSpec.identity]
                finishBlock:beaconSpec.finishSendBeaconBlock];
            }else if(beaconSpec.finishSendBeaconBlock){
                beaconSpec.finishSendBeaconBlock(NO);
            }
        }
        

    } @catch (NSException *exception) {
        @throw exception;
    } @finally {
        // 一時データの削除
        _vrQuerySpec = nil;
        _vQuerySpec = nil;
    }
}


#pragma mark - Opt

/**
 オプトイン（コールバックなし）
 
 */
- (BOOL)setOptIn{
    return [Opt in];
}

/**
 オプトアウト（コールバックなし）
 
 */
- (BOOL)setOptOut{
    // オプトアウト
    return [Opt out:_vrQuerySpec beaconQue:[_beaconProvider getBeaconQue]];
    
}

/**
 オプトアウト状態を返却

 
 @return オプトアウト状態
 */
- (BOOL)isOptOut {
    return [Opt isOptout];
}



#pragma mark - ConfigFile

/**
 デフォルト以外の設定ファイルを読み込む
 追加メソッド
 
 @param identity Identity
 @param fileName ファイル名
 */
- (void)loadConfig:(NSString *)identity fileName:(NSString *)fileName finishBlock:(FinishLoadBlock)finishBlock {
    NSLog(@"loadConfig is start %@, instance is %@",identity, finishBlock);
    if ([identity length] == 0 || [fileName length] == 0) {
        @throw [[NSException alloc] initWithName:@"NullException" reason:@"Invalid argument value." userInfo:nil];
    }
    [_loadBlockManager addBlock:identity finishBlock:finishBlock];
    [_acceptor updateWithIdentity:identity state:NO];
    [_configFileProvider addConfigWithIdentity:identity fileName:fileName];
    NSLog(@"loadConfig is end %@",identity);
}

/**
 設定ファイルの読み込み状態を返す
 
 @param identity Identity
 @return 結果（YES = 読み込み中, NO = 設定完了）
 */
- (BOOL)isCheckedLoadConfigRunning:(NSString *)identity {
    return ![_acceptor isOkWithIdentity:identity];
}

/**
 設定ファイルの定義値を返す（Identity有）
 追加メソッド
 
 @param identity Identity
 @return 設定ファイルの定義値
 */
- (NSDictionary *)configParams:(NSString *)identity {
    // リストのコピーを渡す
    return [[_configFileProvider loadConfig:identity] getElements];
}

/**
 設定ファイルを書き込む

 @param config 設定ファイルの定義値
 */
- (void)setConfig:(NSDictionary *)config identity:(NSString *)identity {
    if ([_acceptor isOkWithIdentity:identity]) {
        NSLog(@"Set Config");
        [_configFileProvider setConfig:config identity:identity];
    }else {
        NSLog(@"Add Config Queue");
        [_replaceConfigQueue addObject:[[ReplaceConfig alloc] initWithIdentity:identity configParams:config]];
    }
}

- (NSString *)getSessionID {
    return _sessionID.newSessionID.getSessionID;
}


#pragma mark - private methods

/**
 VrQuerySpecが無ければ新規生成する
 */
- (void)vrQuerySpecInit {
    if (_vrQuerySpec.parameters.params.count == 0) {
        _vrQuerySpec = [QuerySpec new];
    }
}

/**
 VQuerySpecが無ければ新規生成する
 */
- (void)vQuerySpecInit {
    if (_vQuerySpec.parameters.params.count == 0) {
        _vQuerySpec = [QuerySpec new];
    }
}

@end
