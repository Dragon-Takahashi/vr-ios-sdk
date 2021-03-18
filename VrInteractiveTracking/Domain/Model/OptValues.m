//
//  OptValues.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/11.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "OptValues.h"

@implementation OptValues

- (instancetype)init
{
    self = [super init];
    if (self) {
        _vr_opt1 = [NSString string];
        _vr_opt2 = [NSString string];
        _vr_opt3 = [NSString string];
        _vr_opt4 = [NSString string];
        _vr_opt5 = [NSString string];
        _vr_opt6 = [NSString string];
        _vr_opt7 = [NSString string];
        _vr_opt8 = [NSString string];
        _vr_opt9 = [NSString string];
//        _vr_opt10 = [NSString string];
//        _vr_opt11 = [NSString string];
//        _vr_opt12 = [NSString string];
//        _vr_opt13 = [NSString string];
        _vr_opt14 = [NSString string];
        _vr_opt15 = [NSString string];
        _vr_opt16 = [NSString string];
        _vr_opt17 = [NSString string];
        _vr_opt18 = [NSString string];
        _vr_opt19 = [NSString string];
        _vr_opt20 = [NSString string];
    }
    return self;
}

- (NSMutableDictionary*) getParams {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    NSArray *optList = @[_vr_opt1,
                         _vr_opt2,
                         _vr_opt3,
                         _vr_opt4,
                         _vr_opt5,
                         _vr_opt6,
                         _vr_opt7,
                         _vr_opt8,
                         _vr_opt9,
                         _vr_opt14,
                         _vr_opt15,
                         _vr_opt16,
                         _vr_opt17,
                         _vr_opt18,
                         _vr_opt19,
                         _vr_opt20
    ];
    
    NSArray *keyList = @[@1,
                         @2,
                         @3,
                         @4,
                         @5,
                         @6,
                         @7,
                         @8,
                         @9,
                         @14,
                         @15,
                         @16,
                         @17,
                         @18,
                         @19,
                         @20
    ];
    
    for (int i = 0; i < [optList count]; i++) {
        if (optList[i] != nil) {
            [result setObject:optList[i] forKey:[NSString stringWithFormat:@"vr_opt%@",keyList[i]]];
        }
    }
    
    return result;
}

@end
