//
//  SendNullRepositoryTests.m
//  Tests
//
//  Created by 髙橋和成 on 10/23/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SendNullRepository.h"
#import "EventIdentity.h"

@interface SendNullRepositoryTests : XCTestCase

@end

@implementation SendNullRepositoryTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (ConfigFile *)normalConfig {
    NSMutableDictionary *dic = [@{@"disabled":@"false",
                                  @"beacon_timeout":@"15"}
                                mutableCopy];
    return [[ConfigFile alloc] initWithParams:dic];
}

// コールバックテスト
- (void)testSendCallback {
    // BeaconEvent生成
    URI *uri = [[URI alloc] initWithDirectURL:@"https://test.com/takahashi.gif" configFile:[self normalConfig] finishBlock:nil];
    BeaconEvent *beaconEvent = [[BeaconEvent alloc] initWithParam:[EventIdentity new] uri:uri eventName:@"RUNNING"];
    
    // Callback生成
    BeaconCallback callback = ^(NSString *url) {
        XCTAssertTrue([url isEqualToString:@"https://test.com/takahashi.gif"]);
    };
    
    // 呼び出し
    [SendNullRepository send:beaconEvent callback:callback];
}

// 通信結果テスト
- (void)testSendNilResponse {
    // BeaconEvent生成
    URI *uri = [[URI alloc] initWithDirectURL:@"https://test.com/takahashi.gif" configFile:[self normalConfig] finishBlock:nil];
    BeaconEvent *beaconEvent = [[BeaconEvent alloc] initWithParam:[EventIdentity new] uri:uri eventName:@"RUNNING"];
    
    // Callback生成
    BeaconCallback callback = ^(NSString *url) {};
    
    // 呼び出し
    Response *response = [SendNullRepository send:beaconEvent callback:callback];
    
    // 返り値テスト
    XCTAssertNil([response getStatus]);
}

@end
