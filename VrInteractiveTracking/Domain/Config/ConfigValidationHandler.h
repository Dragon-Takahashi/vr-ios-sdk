//
//  ConfigValidationHandler.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/11/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ValidationHandler.h"

/**
 設定ファイル検証ハンドラークラス
 */
@interface ConfigValidationHandler : NSObject <ValidationHandler>

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
