//
//  SessionID.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 3/15/20.
//  Copyright © 2020 VideoResearch. All rights reserved.
//

#import "SessionID.h"

@interface SessionID()
@property(nonatomic) NSString *sessionID;
@end

@implementation SessionID

/**
 イニシャライザ

 @return self
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        _sessionID = [self createUUID];
    }
    return self;
}

- (NSString *) getSessionID {
    return _sessionID;
}

- (NSString *) createUUID {
    // UUIDを発行
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuid =(__bridge_transfer NSString*)CFUUIDCreateString(nil,uuidObj);
    CFRelease(uuidObj);
    uuid = [uuid substringWithRange:NSMakeRange(0, 32)];
    return uuid;
}

- (SessionID *) newSessionID {
    SessionID *newSessionID = SessionID.new;
    return newSessionID;
}

- (BOOL) equals:(NSObject*)o {
    if ([o isKindOfClass:[SessionID class]] ) {
        NSString *otherID = [(SessionID *)o getSessionID];
        return [otherID isEqual:_sessionID];
    }
    return NO;
}


@end
