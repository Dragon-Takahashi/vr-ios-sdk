//
//  SendHttpRepository.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/08.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SendRepository.h"
#import "BeaconEvent.h"
#import "Response.h"

typedef void (^BeaconCallback) (NSString *url);

/**
 ビーコン送信処理クラス

 */
@interface SendHttpRepository : NSObject <SendRepository>

/**
 送信処理

 @param event BeaconEvent
 @param callback コールバック
 */
+ (void) send:(BeaconEvent*) event callback:(BeaconCallback) callback;

/**
 処理の成否

 @return true:success false:failed
 */
+ (BOOL) ensure;

@end
