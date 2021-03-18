//
//  URI.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/08.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "URI.h"

#import "../../Common/Encoder.h"
#import "../UUID.h"
#import "../../Logic/VrInteractiveTrackingAdapter.h"
#import "../../Logic/VrQueryParameter.h"

@interface URI()
@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, copy) QuerySpec *spec;
@property (nonatomic, copy) ConfigFile *configFile;
@property (nonatomic, copy) NSString *directUrl;
@property (nonatomic, copy) QueryParameters *forceValue;
@property (nonatomic, copy) FinishSendBeaconBlock finishBlock;
@end

@implementation URI

/**
 コンストラクタ

 @param baseUrl ベースURL
 @param spec パラメータ群
 @param configFile 設定ファイル情報
 @param forceValue 強制適用パラメータ群
 @return self
 */
- (instancetype) initWithQuerySpec:(NSString *)baseUrl spec:(QuerySpec *)spec configFile:(ConfigFile *)configFile forceValue:(QueryParameters *)forceValue finishBlock:(FinishSendBeaconBlock )finishBlock {
    if((self = [super init])){
        _baseUrl = baseUrl;
        _spec = spec;
        _configFile = configFile;
        _forceValue = forceValue;
        _finishBlock = finishBlock;
        NSLog(@"URI paramList init = %lu", (unsigned long)[[[spec getQueryParameters] getParameters] count]);
    }
    return self;
}


/**
 コンストラクタ

 @param directUrl 加工せず送信するURL
 @return self
 */
- (instancetype) initWithDirectURL:(NSString*) directUrl configFile:(ConfigFile *)config finishBlock:(FinishSendBeaconBlock )finishBlock {
    if((self = [super init])){
        _directUrl = directUrl;
        _configFile = config;
        _configFile.isNormal = YES;
        _finishBlock = finishBlock;
    }
    return self;
}

- (id)copyWithZone:(NSZone*)zone
{
    // 複製用のインスタンスを生成
    URI* uri = [[[self class] allocWithZone:zone] init];
    if (uri) {
        uri.baseUrl = self.baseUrl;
        uri.spec = self.spec ;
        uri.configFile = self.configFile;
        uri.forceValue = self.forceValue;
        uri.directUrl = self.directUrl;
        uri.finishBlock = self.finishBlock;
    }
    return uri;
}


/**
 無効化されているかを返却

 @return 無効化フラグ
 */
-(BOOL) getDisabled {
    return [_configFile getDisabled];
}


/**
 設定ファイルを上書き

 @param configFile 設定ファイル
 */
-(void) setConfigFile:(ConfigFile *)configFile {
    _configFile = configFile;
}


/**
 URLを取得

 @return 送信ビーコンURL
 */
- (NSURL*) toURI {
    if ([_directUrl length] == 0) {
        return [self buildURL];
    }else {
        return [NSURL URLWithString:_directUrl];
    }
}


/**
 送信ビーコンをビルド

 @return 送信ビーコンURL
 */
- (NSURL*) buildURL {
    NSString *url = [NSString stringWithFormat:@"%@?%@",[self getBaseURL],[self getQuery]];
    NSLog(@"URI built url = %@",url);
    return [NSURL URLWithString:url];
}


/**
 ベースURLを取得

 @return ベースURL
 */
- (NSString *)getBaseURL {
    // 強制値に値が入っているか判断
    if (_forceValue && [_forceValue containKey:@"beacon_url"]) {
        return [_forceValue getValue:@"beacon_url"].value;
    }
    // sendBeaconの引数に値が入っているか判断
    if ([_baseUrl length] != 0) {
        return _baseUrl;
    }
    // 何もなければ設定ファイルの定義値を使用
    return [_configFile getBeacon_url];
}

/**
 パラメータ群を返却
 
 @return 送信パラメータ群
 */
- (NSString*) getQuery {
    VrQueryParameter *vrParameter = [VrQueryParameter new];
    [[_spec getQueryParameters] addAllWithQueryParameters:[vrParameter toQueryParametersWithConfigFile:_configFile]];
    
    // 強制パラメータで上書き
    NSMutableDictionary *fv = [NSMutableDictionary dictionary];
    for (QueryParameter *param in [_forceValue getParameters]) {
        [fv setObject:param.value forKey:param.key];
    }
    [[_spec getQueryParameters] addAll:fv];
    
    NSString *result = [NSString string];
    
    // 定義値を追加
    NSMutableArray *paramList = [[_spec getQueryParameters] getParameters];
    NSLog(@"URI paramList = %@", [paramList description]);
    for (QueryParameter *param in paramList) {
        if ([result length] != 0) {
            result = [result stringByAppendingString:@"&"];
        }
        result = [result stringByAppendingFormat:@"%@=%@", [Encoder urlEncode:[param key]], [Encoder urlEncode:[param value]]];
    }
    
    return result;
}

/**
 設定ファイルの指定されているIdentityを取得

 @return Identity
 */
- (NSString *)getIdentity {
    return [_configFile getIdentity];
}


/**
 ビーコン送信タイムアウトを取得

 @return ビーコン送信用のタイムアウト
 */
- (NSString *)getBeaconTimeout {
    return [_configFile getBeacon_timeout];
}


/**
 コールバックを取得

 @return コールバック
 */
- (FinishSendBeaconBlock)getFinishBlock {
    return _finishBlock;
}

@end
