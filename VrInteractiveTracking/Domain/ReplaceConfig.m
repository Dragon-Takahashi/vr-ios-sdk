//
//  ReplaceConfig.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/14/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "ReplaceConfig.h"

@implementation ReplaceConfig

- (instancetype)initWithIdentity:(NSString *)identity configParams:(NSDictionary *)configParams
{
    self = [super init];
    if (self) {
        _identity = identity;
        _configParams = configParams;
    }
    return self;
}

@end
