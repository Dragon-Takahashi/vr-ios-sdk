//
//  TrackingFactory.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/17/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "TrackingFactory.h"

#import "TrackingDisableStrategy.h"
#import "TrackingEnableStrategy.h"


@implementation TrackingFactory

+ (id)of:(VrInteractiveTrackingSpec *)spec {
    if (!spec.getEnabled) {
        NSLog(@"tracking strategy is TrackingDisableStrategy");
        return [[TrackingDisableStrategy alloc] initWithAppName:spec];
    }
    NSLog(@"tracking strategy is TrackingEnableStrategy");
    return [[TrackingEnableStrategy alloc] initWithAppName:spec];
}

+ (id)update:(id)strategy spec:(VrInteractiveTrackingSpec *)spec {
    if ([strategy isKindOfClass:[TrackingDisableStrategy class]] && spec.getEnabled) {
        return [self of:spec];
    }else if ([strategy isKindOfClass:[TrackingEnableStrategy class]] && !spec.getEnabled) {
        return [self of:spec];
    }
    return strategy;
}

@end
