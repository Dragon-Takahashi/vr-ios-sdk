//
//  URLValidator.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/24/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "URLValidator.h"

@interface URLValidator()
@property (nonatomic) NSString *url;
@property (nonatomic, copy, readwrite, getter=handler)URLValidationHandler *handler;
@end

@implementation URLValidator

- (instancetype)initWithURL:(NSString *)url handler:(URLValidationHandler *)handler {
    self = [super init];
    if (self) {
        _url = url;
        _handler = handler;
    }
    return self;
}

- (void)validate {
    [self isCheckedURL];
}

- (void)isCheckedURL {
    if (![self validateUrl:_url]) {
        [_handler handleError:@"URL is not valid"];
    }
}

-(BOOL)validateUrl:(NSString *)url{
//    NSString *urlRegEx =  @"((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?";
    NSString *urlRegEx = @"http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    if ([urlTest evaluateWithObject:url] == YES) {
        NSLog(@"URL is valid!");
    } else {
        NSLog(@"URL is not valid!\n%@",url);
    }
    return [urlTest evaluateWithObject:url];
}

@end
