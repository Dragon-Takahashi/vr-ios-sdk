//
//  Identity.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/05.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "EventIdentity.h"

@interface EventIdentity()
@property(nonatomic, readwrite, getter=getEventIdentity) NSString* eventIdentity;
@end


@implementation EventIdentity

/**
 * イニシャライズ
 *
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createIdentity];
    }
    return self;
}

/**
 * 変数identityにユニークなIDを付与する
 *
 */
- (void) createIdentity {
    // ユニークなIDを付与
    _eventIdentity = [NSUUID UUID].UUIDString;
}

@end
