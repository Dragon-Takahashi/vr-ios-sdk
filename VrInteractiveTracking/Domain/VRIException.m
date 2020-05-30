//
//  VRIException.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/12/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "VRIException.h"

@implementation VRIException

+ (NSException *)exceptionWithMessage:(NSString *)msg {
    return [NSException exceptionWithName:@"VRInteractiveTrackingException" reason:msg userInfo:nil];
}

@end
