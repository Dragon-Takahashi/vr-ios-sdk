//
//  BeaconEventTests.m
//  Tests
//
//  Created by 髙橋和成 on 11/3/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BeaconEvent.h"

@interface BeaconEventTests : XCTestCase
@property (nonatomic, readwrite) NSString *RUNNING;
@property (nonatomic, readwrite) NSString *STAND_BY;
@property (nonatomic) URI *uri;
@end

@implementation BeaconEventTests

- (void)setUp {
    [super setUp];
    _STAND_BY = @"STAND_BY";
    _RUNNING = @"RUNNING";
    NSMutableDictionary *dic = [@{@"disabled":@"false",
                                 @"beacon_timeout":@"15"}
                                mutableCopy];
    _uri = [[URI alloc] initWithDirectURL:@"https://www.e-agency.co.jp/" configFile:[[ConfigFile alloc] initWithParams:dic] finishBlock:nil];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark initWithParam:(EventIdentity*) eventId uri:(URI*) uri eventName:(NSString *)eventName


/**
 初期化の正常値テスト
 */
- (void)testInitNormal {
    // 生成
    BeaconEvent *event = [[BeaconEvent alloc] initWithParam:[EventIdentity new] uri:_uri eventName:_RUNNING];
    
    // テスト
    XCTAssertNotNil(event);
}


#pragma mark getEventIdentity

/**
 識別子取得の正常値テスト
 */
- (void)testGetEventIdentityNormal {
    // 生成
    EventIdentity *eventId = [EventIdentity new];
    BeaconEvent *event = [[BeaconEvent alloc] initWithParam:eventId uri:_uri eventName:_RUNNING];
    
    // テスト
    XCTAssertTrue([[eventId getEventIdentity] isEqualToString:[event getEventIdentity]]);
}

#pragma mark occurredOn

/**
 初期化時間の正常値テスト
 */
- (void)testOccurredOnNormal {
    // 生成
    BeaconEvent *event = [[BeaconEvent alloc] initWithParam:[EventIdentity new] uri:_uri eventName:_RUNNING];
    
    // テスト
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *time = [formatter stringFromDate:event.date];
    XCTAssertNotNil(time);
}

#pragma mark getURI

/**
 初期化の正常値テスト（URIはDirectを採用）
 */
- (void)testGetURINormal {
    // 生成
    BeaconEvent *event = [[BeaconEvent alloc] initWithParam:[EventIdentity new] uri:_uri eventName:_RUNNING];
    
    // テスト
    XCTAssertTrue([[[[event getURI] toURI] absoluteString] isEqualToString:@"https://www.e-agency.co.jp/"]);
}

@end
