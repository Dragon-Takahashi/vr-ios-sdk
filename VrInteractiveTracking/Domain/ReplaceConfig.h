//
//  ReplaceConfig.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/14/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 ConfigQue用格納クラス
 */
@interface ReplaceConfig : NSObject
@property (nonatomic, copy, getter=getIdentity, setter=setIdentity:) NSString *identity;
@property (nonatomic, copy, getter=getConfigParams, setter=setConfigParams:) NSDictionary *configParams;

/**
 イニシャライザ

 @param identity Identity
 @param configParams 設定値
 @return self
 */
- (instancetype)initWithIdentity:(NSString *)identity configParams:(NSDictionary *)configParams;

@end
