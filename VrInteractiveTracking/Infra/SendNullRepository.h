//
//  SendNullRepository.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/08.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SendRepository.h"
#import "BeaconEvent.h"
#import "Response.h"

/**
 ビーコン非送信クラス
 */
@interface SendNullRepository : NSObject <SendRepository>

/**
 非送信処理
 
 @param event BeaconEvent
 @param callback コールバック
 */
+ (Response*) send:(BeaconEvent*) event callback:(BeaconCallback) callback;

/**
 処理の成否
 
 @return true:success false:failed
 */
+ (BOOL) ensure;

@end
