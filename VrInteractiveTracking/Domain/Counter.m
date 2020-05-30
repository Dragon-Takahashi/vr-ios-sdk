//
//  Counter.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/18/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "Counter.h"

@interface Counter()
@property (readwrite) long long value;
@end

@implementation Counter
- (instancetype)init
{
    self = [super init];
    if (self) {
        _value = 0;
    }
    return self;
}

- (void)increment {
    @synchronized (self)
    {
        _value++;
    }
}
- (void)decrement {
    @synchronized (self)
    {
        _value--;
    }
}
@end
