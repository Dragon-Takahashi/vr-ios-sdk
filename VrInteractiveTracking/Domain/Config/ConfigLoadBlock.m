//
//  ConfigLoadBlock.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/29/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "ConfigLoadBlock.h"

@implementation ConfigLoadBlock

- (instancetype)initWithIdentity:(NSString *)identity finishBlock:(FinishLoadBlock)finishBlock
{
    self = [super init];
    if (self) {
        _identity = identity;
        _finishBlock = finishBlock;
        NSLog(@"in ConfigLoadBlock instance is %@", _finishBlock);
    }
    return self;
}


- (void)callback:(BOOL)result {
    if (_finishBlock) {
        _finishBlock(result);
    }
}

@end
