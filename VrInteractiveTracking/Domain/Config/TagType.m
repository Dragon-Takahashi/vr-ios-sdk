//
//  TagType.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 1/28/21.
//  Copyright © 2021 VideoResearch. All rights reserved.
//

#import "TagType.h"

NSString *const kVR = @"vr";
NSString *const kV = @"v";
//static NSString *const kVR = @"vr";
//static NSString *const kV = @"v";

@implementation TagType

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#define CASE(str) if ([__c__ isEqualToString:(str)])
#define SWITCH(c) for (NSString *__c__=(c);__c__;__c__ = nil)
#define DEFAULT
- (TagType *) of:(NSString *)symbol {
    if ([kVR isEqual:symbol]) {
        self.symbol = symbol;
        return self;
    }else if ([kV isEqual:symbol]) {
        self.symbol = symbol;
        return self;
    }
    @throw [VRIException exceptionWithMessage:[NSString stringWithFormat:@"No enum %@",symbol]];
}


- (void) validate:(id<Config>) config handler:(ConfigValidationHandler *)handler {
    ConfigValidator *validator;
    if ([kVR isEqual:self.symbol]) {
        validator = [[VrConfigValidator alloc] initWithValidationHandler:handler config:config];
    }else if ([kV isEqual:self.symbol]) {
        validator = [[VConfigValidator alloc] initWithValidationHandler:handler config:config];
    }
    [validator validate];
    config.isNormal = ![[validator handler] errors];
    
    if ([[validator handler] errors]) {
        @throw [VRIException exceptionWithMessage:[[validator handler] toString]];
    }
}

@end
