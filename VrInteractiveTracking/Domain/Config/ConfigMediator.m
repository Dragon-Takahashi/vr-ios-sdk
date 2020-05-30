//
//  ConfigMediator.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/29/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "ConfigMediator.h"

#import "ConfigLoadBlock.h"

@interface ConfigMediator()
@property (nonatomic) NSMutableDictionary *blockList;
@end

@implementation ConfigMediator

- (instancetype)init
{
    self = [super init];
    if (self) {
        _blockList = [NSMutableDictionary dictionary];
    }
    return self;
}


- (void)addBlock:(NSString *)identity finishBlock:(FinishLoadBlock)finishBlock {
    [_blockList setObject:[[ConfigLoadBlock alloc] initWithIdentity:identity finishBlock:finishBlock] forKey:identity];
}

- (void)callback:(NSString *)identity result:(BOOL)result {
    NSLog(@"identity '%@' callback,\nresult is %@,\ninstance is %@", identity, result?@"YES":@"NO", [[_blockList objectForKey:identity] finishBlock]);
    [[_blockList objectForKey:identity] callback:result];
}

- (BOOL)isLoaded:(NSString *)identity {
    if ([_blockList objectForKey:identity]) {
        return YES;
    }else {
        return NO;
    }
}

@end
