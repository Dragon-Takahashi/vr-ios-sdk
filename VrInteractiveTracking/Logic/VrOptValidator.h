//
//  VrOptValidator.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/14/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Validator.h"
#import "VrOptValidatoionHandler.h"

/**
 Opt番号検証クラス
 */
@interface VrOptValidator : NSObject <Validator>

@property (nonatomic, copy, readonly, getter=handler)VrOptValidatoionHandler *handler;

/**
 イニシャライザ

 @param optId OptID
 @param handler ハンドラー
 @return self
 */
- (instancetype)initWithOptId:(int)optId handler:(VrOptValidatoionHandler *)handler;
/**
 チェック
 */
- (void)validate;

@end
