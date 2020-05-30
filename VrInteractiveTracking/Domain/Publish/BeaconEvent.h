//
//  BeaconEvent.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/04.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"
#import "EventIdentity.h"
#import "URI.h"

/**
 ビーコン送信イベントクラス
 */
@interface BeaconEvent : NSObject <Event>

@property (nonatomic, copy) EventIdentity *eventId;
@property (nonatomic) NSDate *date;
@property (nonatomic, copy) URI *uri;
@property (nonatomic, copy) NSString *eventName;

/**
 イニシャライザ

 @param eventId 識別子
 @param uri URI
 @param eventName BeaconStatus
 @return self
 */
- (instancetype) initWithParam:(EventIdentity*) eventId uri:(URI*) uri eventName:(NSString *)eventName;

/**
 識別子取得

 @return 識別子
 */
- (NSString*) getEventIdentity;

/**
 日付取得

 @return 日付
 */
- (NSDate*) occurredOn;

/**
 URI取得

 @return URI
 */
- (URI*) getURI;

@end
