//
//  Text.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/03.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "Text.h"

@interface Text() {
    NSString *text;
}
@end

@implementation Text

- (instancetype) initWithText:(NSString*) text {
    if((self = [super init])){
        self->text = text;
    }
    return self;
}


- (NSString*) getText {
    return text;
}

@end
