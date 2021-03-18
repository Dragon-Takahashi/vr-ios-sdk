//
//  VrInteractiveBeaconSpec.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/18/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "VrInteractiveBeaconSpec.h"

@implementation VrInteractiveBeaconSpecBuilder
- (instancetype)init
{
    self = [super init];
    if (self) {
        _eventName = nil;
        _monitorId = nil;
        _url = nil;
        _identity = nil;
        _finishSendBeaconBlock = nil;
    }
    return self;
}
@end


@interface VrInteractiveBeaconSpec()
@property (nonatomic, copy, readwrite) NSString *eventName;
@property (nonatomic, copy, readwrite) NSString *monitorId;
@property (nonatomic, copy, readwrite) NSString *url;
@property (nonatomic, copy, readwrite) NSString *identity;
@property (nonatomic, weak, readwrite) FinishSendBeaconBlock finishSendBeaconBlock;
@end

@implementation VrInteractiveBeaconSpec

- (id)copyWithZone:(NSZone *)zone {
    VrInteractiveBeaconSpec *copiedObject = [[[self class] allocWithZone:zone] init];
    copiedObject.eventName = _eventName;
    copiedObject.monitorId = _monitorId;
    copiedObject.url = _url;
    copiedObject.identity = _identity;
    copiedObject.finishSendBeaconBlock = _finishSendBeaconBlock;
    return copiedObject;
}

- (instancetype)initWithBuilder:(VrInteractiveBeaconSpecBuilder *)builder {
    if (self = [super init]) {
        _eventName = builder.eventName;
        _monitorId = builder.monitorId;
        _url = builder.url;
        _identity = builder.identity;
        _finishSendBeaconBlock = builder.finishSendBeaconBlock;
    }
    return self;
}

+ (instancetype)makeWithBuilder:(void (^)(VrInteractiveBeaconSpecBuilder *))updateBlock {
    VrInteractiveBeaconSpecBuilder *builder = [VrInteractiveBeaconSpecBuilder new];
    updateBlock(builder);
    return [[VrInteractiveBeaconSpec alloc] initWithBuilder:builder];
}

@end
