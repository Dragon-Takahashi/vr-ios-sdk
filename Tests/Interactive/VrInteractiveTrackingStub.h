//
//  VrInteractiveTrackingStub.h
//  Tests
//
//  Created by 髙橋和成 on 11/25/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "../../VrInteractiveTracking/VrInteractiveTracking.h"
#import "../../VrInteractiveTracking/Domain/Opt.h"

@interface VrInteractiveTrackingStub : VrInteractiveTracking
+ (void)initConfig;
+ (void)forceOptOut;
+ (void)forceOptIn;
@end
