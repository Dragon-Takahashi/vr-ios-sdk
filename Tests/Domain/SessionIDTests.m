//
//  SessionIDTests.m
//  Tests
//
//  Created by 髙橋和成 on 3/15/20.
//  Copyright © 2020 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "../../VrInteractiveTracking/Domain/SessionID.h"

@interface SessionIDTests : XCTestCase

@end

@implementation SessionIDTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

/**
 * 目的：セッションIDを取得した際に、空文字やnullではないことを確認する
 */
- (void)testGetSessionID {
    SessionID *sessionID = SessionID.new;
    XCTAssertFalse([sessionID.getSessionID isEqual:@""]);
    XCTAssertNotNil(sessionID.getSessionID);
}

/**
 * 目的：セッションIDがメソッド呼び出し毎に新規に生成されることを確認する
 */
- (void)testNewSessionID {
    SessionID *sessionID = SessionID.new;

    // 1回目:newSessionID()呼び出し
    SessionID *sessionID1 = sessionID.newSessionID;
    // 2回目:newSessionID()呼び出し
    SessionID *sessionID2 = sessionID.newSessionID;
    
    // 1回目と2回目で生成されたセッションIDが異なることを確認
    XCTAssertNotEqual(sessionID1, sessionID2);
}

/**
 * 目的：equalsメソッドの引数にセッションIDインスタンスを渡した場合、セッションIDが同値であることを確認する
 */
- (void)testEquals {
    SessionID *sessionID = SessionID.new;
    
    // 引数がセッションIDインスタンスの場合、Trueが返却されること
    XCTAssertTrue([sessionID equals:sessionID]);
    // 引数がセッションIDインスタンスではない場合、Falseが返却されること
    XCTAssertFalse([sessionID equals:@"string"]);
}

/**
 * 目的：セッションIDの文字列が32文字であることを確認する
 */
- (void)testLength {
    SessionID *sessionID = SessionID.new;
    
    // セッションIDの文字列が32文字なので、Trueが返却されること
    XCTAssertTrue(sessionID.getSessionID.length == 32);
}

@end
