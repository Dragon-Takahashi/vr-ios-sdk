//
//  BeaconPublisher.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/08.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "URI.h"
#import "Response.h"
#import "SendType.h"

/**
 ビーコン送信制御クラス
 */
@interface BeaconPublisher : NSObject

typedef void (^BeaconCallback) (NSString *url);

@property (nonatomic, copy) BeaconCallback listener;
@property (nonatomic) SendType *sendType;

/**
 ビーコン追加

 @param uri URI
 @param eventName BeaconStatus
 */
- (void)add:(URI*) uri eventName:(NSString *)eventName;

/**
 送信
 */
- (void) publish;

@end
