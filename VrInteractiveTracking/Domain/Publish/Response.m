//
//  Response.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/03.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "Response.h"

@interface Response() {
    Status *status;
    Text *text;
}
@end

@implementation Response

- (instancetype) initWithResult:(Status*) status text:(Text*) text {
    if((self = [super init])){
        self->status = status;
        self->text = text;
        NSLog(@"Receive data in Response class");
    }
    return self;
}

- (Status*) getStatus {
    return status;
}

- (Text*) getText {
    return text;
}

@end
