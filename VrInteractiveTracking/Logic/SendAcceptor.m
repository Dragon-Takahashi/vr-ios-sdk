//
//  SendAcceptor.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/13/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "SendAcceptor.h"

#import "ConfigAcceptor.h"

@interface SendAcceptor()
@property (nonatomic) ConfigAcceptor *configAcceptor;
@end

@implementation SendAcceptor

- (instancetype)init
{
    self = [super init];
    if (self) {
        _configAcceptor = [ConfigAcceptor new];
    }
    return self;
}

- (void)updateWithIdentity:(NSString *)identity state:(BOOL)isOK {
    NSString *state = [State IN_PROGRESS];
    if (isOK) {
        state = [State STAND_BY];
    }
    
    [_configAcceptor updateWithIdentity:identity state:state];
}

- (BOOL)isOkWithIdentity:(NSString *)identity {
    BOOL result = YES;
    if (![_configAcceptor isOKWithIdentity:identity]) {
        result = NO;
    }
    
    return result;
}


- (NSString *)toString {
    NSString *result = [NSString string];
    result = [result stringByAppendingFormat:@"\n%@", [_configAcceptor toString]];
    
    return result;
}

@end
