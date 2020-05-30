//
//  TrackingParams.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/13/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "VrInteractiveTrackingSpec.h"

@implementation VrInteractiveTrackingSpecBuilder

- (instancetype)init
{
    self = [super init];
    if (self) {
        _appName = nil;
        _eventName = nil;
        _monitorId = nil;
        _outsideConfigURL = nil;
        _optFlg = NO;
        _finishInitBlock = nil;
    }
    return self;
}


@end

@interface VrInteractiveTrackingSpec()

@property (nonatomic, copy, readwrite) NSString *appName;
@property (nonatomic, copy, readwrite) NSString *eventName;
@property (nonatomic, copy, readwrite) NSString *monitorId;
@property (nonatomic, copy, readwrite) NSString *outsideConfigURL;
@property (nonatomic, readwrite) BOOL optFlg;
//@property (nonatomic, copy, readwrite) FinishInitBlock finishInitBlock;

@end

@implementation VrInteractiveTrackingSpec

- (instancetype)initWithBuilder:(VrInteractiveTrackingSpecBuilder *)builder {
    if (self = [super init]) {
        _appName = builder.appName;
        _eventName = builder.eventName;
        _monitorId = builder.monitorId;
        _outsideConfigURL = builder.outsideConfigURL;
        _optFlg = builder.optFlg;
        _finishInitBlock = builder.finishInitBlock;
    }
    return self;
}

+ (instancetype)makeWithBuilder:(void (^)(VrInteractiveTrackingSpecBuilder *))updateBlock {
    VrInteractiveTrackingSpecBuilder *builder = [VrInteractiveTrackingSpecBuilder new];
    updateBlock(builder);
    return [[VrInteractiveTrackingSpec alloc] initWithBuilder:builder];
}
- (BOOL)getEnabled {
    return _optFlg;
}

@end
