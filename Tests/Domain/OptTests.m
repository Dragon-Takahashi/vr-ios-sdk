//
//  OptTests.m
//  Tests
//
//  Created by 髙橋和成 on 10/23/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "../../VrInteractiveTracking/Domain/Publish/BeaconProvider.h"
#import "../../VrInteractiveTracking/Domain/Opt.h"
#import "../../VrInteractiveTracking/Domain/Model/QuerySpec.h"
#import "../../VrInteractiveTracking/Domain/UUID.h"

@interface OptTests : XCTestCase

@end

@implementation OptTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

// オプトインのテスト
- (void)testOptin {
    // Optin
    [Opt in];
    
    // 設定テスト
    XCTAssertFalse([[UUID load] isEqualToString:@"optout"]);
}

// 空の引数を持たせたテスト
- (void)testEmptyOptout {
    // UUIDを設定
    [UUID save];
    
    // 空のQuerySpecクラスを作成
    QuerySpec *spec = [QuerySpec new];
    
    // 空のBeaconProviderを作成
    BeaconProvider *provider = [BeaconProvider new];
    
    // Optout
    [Opt out:spec beaconQue:[provider getBeaconQue]];
    
    // 設定テスト
    XCTAssertTrue([[UUID load] isEqualToString:@"optout"]);
}

// 引数にnilを持たせたテスト
- (void)testnilOptout {
    // UUIDを設定
    [UUID save];
    
    // Optout
    [Opt out:nil beaconQue:nil];
    
    // 設定テスト
    XCTAssertTrue([[UUID load] isEqualToString:@"optout"]);
}

// オプトアウトの判定テスト
- (void)testIsOptout {
    // UUIDを設定
    [UUID save];
    
    // Optout
    [Opt out:nil beaconQue:nil];
    
    // 判定テスト
    XCTAssertTrue([Opt isOptout]);
}

// オプトインの判定テスト
- (void)testIsOptin {
    // Optin
    [Opt in];
    
    // 判定テスト
    XCTAssertFalse([Opt isOptout]);
}

@end
