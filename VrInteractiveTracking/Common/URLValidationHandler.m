//
//  URLValidationHandler.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/24/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "URLValidationHandler.h"

#import "ValidationError.h"

@interface URLValidationHandler()
@property (nonatomic) NSMutableArray *errorList;
@end

@implementation URLValidationHandler

- (instancetype)init
{
    self = [super init];
    if (self) {
        _errorList = [NSMutableArray array];
    }
    return self;
}

- (void)handleError:(NSString *)msg {
    [_errorList addObject:[ValidationError ValidationError:msg]];
}

- (BOOL)errors {
    return [_errorList count] != 0;
}

- (NSString *)toString {
    return [self buildString];
}

- (NSString *)buildString {
    NSString *result = [NSString string];
    if (!_errorList) {
        return result;
    }
    for (int i = 0; i < [_errorList count]; i++) {
        result = [result stringByAppendingFormat:@"\n%@",_errorList[i]];
    }
    return result;
}


@end
