//
//  VConfigValidator.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 1/29/21.
//  Copyright © 2021 VideoResearch. All rights reserved.
//

#import "VConfigValidator.h"

@interface VConfigValidator()
@property (nonatomic, copy, readwrite, getter=handler) ConfigValidationHandler *vhandler;
@property (nonatomic, copy) ConfigFile *vconfig;
@end

@implementation VConfigValidator

- (instancetype)initWithValidationHandler:(ConfigValidationHandler *)handler config:(ConfigFile *)config {
    self = [super initWithValidationHandler:handler config:config];
    if (self) {
        _vhandler = handler;
        _vconfig = config;
        
        [self validate];
    }
    return self;
}

- (void)validate {
    [self checkTagType];
    [self checkA];
    [self checkDcos];
    [super validate];
}


- (void)checkTagType {
    if ([_vconfig.getTagType length] == 0) {
        DLog(@"The tag_type is not tag or empty")
        [_vhandler handleError:@"The tag_type is not tag or empty"];
    }
    
    if (![@"v" isEqual:_vconfig.getTagType]) {
        DLog(@"The tag_type is not v")
        [_vhandler handleError:@"The tag_type is not v"];
    }
}

- (void)checkA {
    if ([_vconfig.getA length] == 0) {
        DLog(@"The a is not tag or empty")
        [_vhandler handleError:@"The a is not tag or empty"];
    }
}

- (void)checkDcos {
    if ([_vconfig.getDcos length] == 0) {
        DLog(@"The dcos is not tag or empty")
        [_vhandler handleError:@"The dcos is not tag or empty"];
    }
}

@end
