//
//  ConfigValidator.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/11/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "ConfigValidator.h"

/**
 設定ファイル検証クラス
 */
@interface VrConfigValidator : ConfigValidator

@property (nonatomic, copy, readonly, getter=handler)ConfigValidationHandler *vrhandler;

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
