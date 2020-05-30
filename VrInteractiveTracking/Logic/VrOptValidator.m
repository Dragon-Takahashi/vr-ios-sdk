//
//  VrOptValidator.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/14/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "VrOptValidator.h"

#import "../Domain/Range.h"

@interface VrOptValidator()
@property (nonatomic)int optId;
@property (nonatomic, copy, readwrite, getter=handler)VrOptValidatoionHandler *handler;
@end

@implementation VrOptValidator

- (instancetype)initWithOptId:(int)optId handler:(VrOptValidatoionHandler *)handler
{
    self = [super init];
    if (self) {
        _optId = optId;
        _handler = handler;
    }
    return self;
}

- (void)validate {
    [self checkOptRange];
    [self checkReservedRange];
}

- (void)checkOptRange {
    Range *range = [[Range alloc] initWithLesserEqual:1 greater_equal:20];
    if (![range includes: (long)_optId]) {
        [_handler handleError:@"Not in the range 1 through 20"];
    }
}

- (void)checkReservedRange {
    Range *range = [[Range alloc] initWithLesserEqual:10 greater_equal:13];
    if ([range includes:_optId]) {
        [_handler handleError:@"The range 10 through 13 is reserved"];
    }
}

@end
