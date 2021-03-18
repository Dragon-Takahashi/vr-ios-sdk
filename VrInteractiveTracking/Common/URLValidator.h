//
//  URLValidator.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/24/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Validator.h"
#import "URLValidationHandler.h"

/**
 URL検証クラス
 */
@interface URLValidator : NSObject <Validator>

@property (nonatomic, copy, readonly, getter=handler)URLValidationHandler *handler;

/**
 イニシャライザ

 @param url チェック値
 @param handler ハンドラー
 @return self
 */
- (instancetype)initWithURL:(NSString *)url handler:(URLValidationHandler *)handler;

/**
 チェック
 */
- (void)validate;

@end
