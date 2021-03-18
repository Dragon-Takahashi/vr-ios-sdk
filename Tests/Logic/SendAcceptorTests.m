//
//  SendAcceptorTests.m
//  Tests
//
//  Created by 髙橋和成 on 12/17/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "../../VrInteractiveTracking/Logic/SendAcceptor.h"

@interface SendAcceptorTests : XCTestCase

@end

@implementation SendAcceptorTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testNormal {
    SendAcceptor *accepter = [SendAcceptor new];
    XCTAssertTrue([accepter isOkWithIdentity:@"test"]);
}

/**
 目的：toStringで想定した文字列が返されるかを確認する
 */
- (void)testToString {
    SendAcceptor *acceptor = [SendAcceptor new];
    
    [acceptor updateWithIdentity:@"test_identity" state:NO];
    // 前提：identityが"test_identity"でステータスがNO(実行中)で登録中
    // 想定：identityが"test_identity"でステータスが"IN_PROGRESS"であることを確認
    XCTAssertTrue([@"\nConfigFile\nidentity:test_identity, state:IN_PROGRESS" isEqualToString:[acceptor toString]]);
    
}

@end
