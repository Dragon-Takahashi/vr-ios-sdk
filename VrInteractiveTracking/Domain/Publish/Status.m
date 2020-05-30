//
//  Status.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/03.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "Status.h"

@interface Status() {
    NSString *status;
}
@end

@implementation Status

- (instancetype) initWithStatus:(NSString*) status{
    if((self = [super init])){
        self->status = status;
    }
    return self;
}

- (NSString*) getStatus{
    return status;
}

@end
