//
//  VRIException.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/12/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 VRI用Exception
 */
@interface VRIException : NSException


/**
 例外

 @param msg メッセージ
 @return NSException
 */
+ (NSException *)exceptionWithMessage:(NSString *)msg;

@end
