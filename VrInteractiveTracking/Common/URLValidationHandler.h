//
//  URLValidationHandler.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/24/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ValidationHandler.h"

/**
 URL検証クラスのハンドラークラス
 */
@interface URLValidationHandler : NSObject <ValidationHandler>

/**
 ハンドラー
 
 @param msg メッセージ
 */
- (void)handleError:(NSString *)msg;

/**
 エラー判定
 
 @return true:エラーあり false:エラーなし
 */
- (BOOL)errors;

/**
 エラー返却
 
 @return エラー
 */
- (NSString *)toString;

@end
