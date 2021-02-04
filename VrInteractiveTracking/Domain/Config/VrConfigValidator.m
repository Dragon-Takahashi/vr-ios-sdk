//
//  ConfigValidator.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 1/29/21.
//  Copyright © 2021 VideoResearch. All rights reserved.
//

#import "VrConfigValidator.h"

@interface VrConfigValidator()
@property (nonatomic, copy, readwrite, getter=handler) ConfigValidationHandler *vrhandler;
@property (nonatomic, copy) ConfigFile *vrconfig;
@end

@implementation VrConfigValidator

- (instancetype)initWithValidationHandler:(ConfigValidationHandler *)handler config:(ConfigFile *)config {
    self = [super initWithValidationHandler:handler config:config];
    if (self) {
        _vrhandler = handler;
        _vrconfig = config;
        
        [self validate];
    }
    return self;
}

- (void)validate {
    [self checkTagType];
    [self isCheckedVrTagId1];
    [self isCheckedVrTagId2];
    [super validate];
}

- (void)checkTagType {
    if ([_vrconfig.getTagType length] == 0) {
        DLog(@"The tag_type is not tag or empty")
        [_vrhandler handleError:@"The tag_type is not tag or empty"];
    }
    
    if (![@"vr" isEqual:_vrconfig.getTagType]) {
        DLog(@"The tag_type is not vr")
        [_vrhandler handleError:@"The tag_type is not vr"];
    }
}


- (void)isCheckedVrTagId1 {
    if ([_vrconfig.getVr_TagId1 length] == 0) {
        [_vrhandler handleError:@"The vr_tagid1 is empty"];
    }
}

- (void)isCheckedVrTagId2 {
    if ([_vrconfig.getVr_TagId2 length] == 0) {
        [_vrhandler handleError:@"The vr_tagid2 is empty"];
    }
}

@end
