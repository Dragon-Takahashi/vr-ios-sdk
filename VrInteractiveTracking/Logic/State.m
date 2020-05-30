//
//  State.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/13/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "State.h"

@interface State()
@end

@implementation State

/**
 イニシャライザ

 @return self
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        _symbol = [State STAND_BY];
        NSLog(@"init symbol = %@",_symbol);
    }
    return self;
}


/**
 状態を更新

 @param symbol 状態
 */
- (void)state:(NSString *)symbol {
    _symbol = symbol;
}


+ (NSString *)IN_PROGRESS {
    return @"IN_PROGRESS";
}
+ (NSString *)STAND_BY {
    return @"STAND_BY";
}

@end
