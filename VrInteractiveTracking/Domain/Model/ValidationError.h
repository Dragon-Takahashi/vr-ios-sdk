//
//  ValidationError.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/10/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 検証例外クラス
 */
@interface ValidationError : NSException

/**
 Custom Exception

 @param msg メッセージ
 @return NSException
 */
+ (NSException *)ValidationError:(NSString *)msg;

@end
