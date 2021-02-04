//
//  VConfigValidator.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 1/29/21.
//  Copyright © 2021 VideoResearch. All rights reserved.
//

#import "ConfigValidator.h"

/**
 設定ファイル検証クラス
 */
@interface VConfigValidator : ConfigValidator

@property (nonatomic, copy, readonly, getter=handler)ConfigValidationHandler *vhandler;

/**
 イニシャライザ

 @param handler ハンドラー
 @param config 設定ファイル
 @return self
 */
- (instancetype)initWithValidationHandler:(ConfigValidationHandler *)handler config:(ConfigFile *)config;

/**
 バリデーション
 */
- (void)validate;

@end
