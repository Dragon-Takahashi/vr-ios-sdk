//
//  SendType.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/08.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "SendType.h"

#import "../../Infra/SendHttpRepository.h"
#import "../../Infra/SendNullRepository.h"

@interface SendType()
@property (nonatomic, readwrite) BeaconStrategy *strategy;
@property (nonatomic, readwrite) NSString *RUNNING;
@property (nonatomic, readwrite) NSString *STAND_BY;
@end

@implementation SendType

- (instancetype)init
{
    self = [super init];
    if (self) {
        _STAND_BY = @"STAND_BY";
        _RUNNING = @"RUNNING";
        _strategy = [BeaconStrategy new];
        _strategy.type = _RUNNING;
    }
    return self;
}

- (void) sendTypeOf:(NSString*) name {
    // Strategy typeを変更
    _strategy.type = name;
}

- (void) send:(BeaconEvent*) event callback:(BeaconCallback) callback; {
    if ([_strategy.type isEqualToString:_RUNNING]) {
        NSLog(@"Use SendHttpRepository");
        [SendHttpRepository send:event callback:callback];
    }else {
        NSLog(@"Use SendNullRepository");
        [SendNullRepository send:event callback:callback];
    }
}

@end
