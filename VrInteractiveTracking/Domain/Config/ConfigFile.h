//
//  ConfigFile.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/20.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Config.h"

/**
 設定ファイル情報格納クラス
 */
@interface ConfigFile : NSObject <Config>

@property (nonatomic) BOOL isNormal;
@property (nonatomic, copy, getter=getIdentity) NSString *identity;
@property (nonatomic, copy, getter=getDate, setter=setDate:) NSDate *date;
@property (nonatomic, copy, getter=getFilePath, setter=setFilePath:) NSString *filePath;

@property (nonatomic, copy, getter=getVr_TagId1, setter=setVr_TagId1:) NSString *vr_TagId1;
@property (nonatomic, copy, getter=getVr_TagId2, setter=setVr_TagId2:) NSString *vr_TagId2;
@property (nonatomic, copy, getter=getTag_Url, setter=setTag_Url:) NSString *tag_Url;
@property (nonatomic, copy, getter=getConfig_Url, setter=setConfig_Url:) NSString *config_Url;
@property (nonatomic, copy, setter=setDisableWithString:) NSString *disable;
@property (nonatomic, copy, getter=getConfig_timeout, setter=setConfig_timeout:) NSString *config_timeout;
@property (nonatomic, copy, getter=getBeacon_timeout, setter=setBeacon_timeout:) NSString *beacon_timeout;
@property (nonatomic, copy, getter=getBeacon_url, setter=setBeacon_url:) NSString *beacon_url;

/**
 イニシャライザ

 @param params 要素
 @return self
 */
- (instancetype) initWithParams:(NSMutableDictionary*) params;

/**
 要素取得

 @return 要素
 */
- (NSMutableDictionary *)getElements;

/**
 要素設定

 @param params 要素
 */
- (void)setParams:(NSMutableDictionary *)params;

/**
 インスタンス生成フラグ設定

 @param disabled インスタンス生成フラグ
 */
- (void)setDisabled:(BOOL)disabled;
/**
 インスタンス生成フラグ取得

 @return インスタンス生成フラグ
 */
- (BOOL)getDisabled;

/**
 IdentityのSetter
 @param identity Identity
 */
- (void)setIdentity:(NSString *)identity;

@end
