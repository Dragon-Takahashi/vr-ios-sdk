//
//  SendType.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/08.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BeaconStrategy.h"
#import "BeaconEvent.h"
#import "Response.h"

/**
 送信タイプクラス
 */
@interface SendType : NSObject

typedef void (^BeaconCallback) (NSString *url);

@property (nonatomic, readonly) BeaconStrategy *strategy;
@property (nonatomic, copy) BeaconCallback listener;
@property (nonatomic, readonly) NSString *RUNNING;
@property (nonatomic, readonly) NSString *STAND_BY;

/**
 送信タイプ設定

 @param name 送信タイプ
 */
- (void) sendTypeOf:(NSString*) name;

/**
 送信

 @param event BeaconEvent
 @param callback コールバック
 */
- (void) send:(BeaconEvent*) event callback:(BeaconCallback) callback;

@end
