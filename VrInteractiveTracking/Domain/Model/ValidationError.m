//
//  ValidationError.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/10/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "ValidationError.h"

@implementation ValidationError

+ (NSException *)ValidationError:(NSString *)msg {
    return [super exceptionWithName:@"VRInteractiveTrackingException" reason:msg userInfo:nil];
}

@end
