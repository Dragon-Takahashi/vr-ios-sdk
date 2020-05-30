//
//  Internet.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/17/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "Internet.h"

#import "Reachability.h"

@implementation Internet

+ (BOOL)isOnline {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reachability currentReachabilityStatus];
    return status != NotReachable;
}

@end
