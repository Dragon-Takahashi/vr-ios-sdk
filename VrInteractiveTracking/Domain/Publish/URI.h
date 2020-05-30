//
//  URI.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/08.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QuerySpec.h"
#import "ConfigFileProvider.h"

/**
 URIクラス
 */
@interface URI : NSObject

typedef void (^FinishSendBeaconBlock) (BOOL result);

/**
 イニシャライザ

 @param baseUrl 上書き用URL
 @param spec QuerySpec
 @param configFile 設定ファイル
 @param forceValue 強制上書き情報
 @param finishBlock コールバック
 @return self
 */
- (instancetype) initWithQuerySpec:(NSString *)baseUrl spec:(QuerySpec *)spec configFile:(ConfigFile *)configFile forceValue:(QueryParameters *)forceValue finishBlock:(FinishSendBeaconBlock )finishBlock;

/**
 イニシャライザ

 @param directUrl ダイレクトURL
 @param config 設定ファイル
 @param finishBlock コールバック
 @return self
 */
- (instancetype) initWithDirectURL:(NSString *)directUrl configFile:(ConfigFile *)config finishBlock:(FinishSendBeaconBlock )finishBlock;

/**
 インスタンス生成フラグ取得

 @return インスタンスし生成フラグ
 */
-(BOOL) getDisabled;

/**
 設定ファイル取得

 @param configFile 設定ファイル
 */
-(void) setConfigFile:(ConfigFile *)configFile;

/**
 URL取得

 @return URL
 */
- (NSURL *)toURI;

/**
 Identity取得

 @return Identity
 */
- (NSString *)getIdentity;

/**
 BeaconTimeout取得

 @return BeaconTimeout
 */
- (NSString *)getBeaconTimeout;

/**
 コールバック取得

 @return コールバック
 */
- (FinishSendBeaconBlock)getFinishBlock;

@end
