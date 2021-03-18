//
//  SendTypeTests.m
//  Tests
//
//  Created by 髙橋和成 on 11/3/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "SendType.h"

@interface SendTypeTests : XCTestCase

@end

@implementation SendTypeTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (BeaconEvent *)normalBeaconEvent {
    return [[BeaconEvent alloc] initWithParam:[EventIdentity new] uri:[self normalURI] eventName:@"STAND_BY"];
}
- (URI *)normalURI {
    NSMutableDictionary *dic = [@{@"disabled":@"false",
                                 @"beacon_timeout":@"15"}
                                mutableCopy];
    return [[URI alloc] initWithDirectURL:@"https://panelstg.interactive-circle.jp/ver01/measure?test1=value1" configFile:[[ConfigFile alloc] initWithParams:dic] finishBlock:nil];
}

#pragma mark init

/**
 初期化の正常系テスト
 */
- (void)testInitNormal {
    // 生成
    SendType *sendType = [SendType new];
    //テスト
    XCTAssertNotNil(sendType);
}

/**
 初期化変数の正常系テスト
 */
- (void)testInitParamsNormal {
    // 生成
    SendType *sendType = [SendType new];
    //テスト
    XCTAssertTrue([sendType.RUNNING isEqualToString:@"RUNNING"]);
    XCTAssertTrue([sendType.STAND_BY isEqualToString:@"STAND_BY"]);
    XCTAssertNil([sendType listener]);
}

#pragma mark sendTypeOf:(NSString*) name

/**
 送信先変更の正常系テスト
 */
- (void)testSendTypeOfNormal {
    // 生成
    SendType *sendType = [SendType new];
    // 送信先変更
    [sendType sendTypeOf:sendType.STAND_BY];
    //テスト
    XCTAssertTrue([sendType.strategy.type isEqualToString:sendType.STAND_BY]);
    // 送信先変更
    [sendType sendTypeOf:sendType.RUNNING];
    //テスト
    XCTAssertTrue([sendType.strategy.type isEqualToString:sendType.RUNNING]);
}


#pragma mark send:(BeaconEvent*) event callback:(BeaconCallback) callback

/**
 送信処理の正常系テスト
 */
- (void)testSendNormal {
    // 生成
    SendType *sendType = [SendType new];
    // 送信処理
    [sendType send:[self normalBeaconEvent] callback:^(NSString *url) {
        // テスト
        XCTAssertTrue([url isEqualToString:[[[self normalURI] toURI] absoluteString]]);
    }];
}

@end
