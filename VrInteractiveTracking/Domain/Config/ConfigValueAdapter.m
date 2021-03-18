//
//  ConfigValueAdapter.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/22/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "ConfigValueAdapter.h"

@implementation ConfigValueAdapter


+ (NSDictionary *)castAllValue:(NSDictionary *)values {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for (NSString *key in values) {
        [result setValue:[self castValue:values key:key] forKey:key];
    }
    
    return [result copy];
}

//
//+ (BOOL)isBOOL:(NSString *)key {
//    if ([key isEqualToString:@"debug_log"]
//        ||[key isEqualToString:@"disabled"]
//        ||[key isEqualToString:@"polling"]
//        ||[key isEqualToString:@"polling_start"]) {
//        return YES;
//    }
//    return NO;
//}


+ (NSString *)castValue:(NSDictionary *)value key:(NSString *)key {
    NSString *result = @"";
    if ([[value objectForKey:key] isKindOfClass:[NSNumber class]]) {
        if ([self isBoolNumber:[value objectForKey:key]]) {
            result = [[value objectForKey:key] boolValue]?@"YES":@"NO";
        }else {
            result = [NSString stringWithFormat:@"%@",[value objectForKey:key]];
        }
    }else {
        result = [value objectForKey:key];
    }
    return result;
}

//+ (NSString *)castValueForBool:(id)value {
//    NSString *result = @"";
//    if ([value isKindOfClass:[NSNumber class]]) {
//        result = (int)value==1?@"YES":@"NO";
//    }else {
//        result = [value lowercaseString];
//    }
//    return result;
//}

+ (BOOL) isBoolNumber:(NSNumber *)num {
    CFTypeID boolID = CFBooleanGetTypeID();
    CFTypeID numID = CFGetTypeID((__bridge CFTypeRef)(num));
    return numID == boolID;
}

@end
