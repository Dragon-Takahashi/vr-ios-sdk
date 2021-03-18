//
//  CounterTests.m
//  Tests
//
//  Created by 髙橋和成 on 11/18/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Counter.h"

@interface CounterTests : XCTestCase

@end

@implementation CounterTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

/**
 目的：初期値に0が入っているかを確認する
 */
- (void)testInit {
    Counter *counter = [Counter new];
    // 前提：初期値は0
    // 想定：valueには"0"が入っているかを確認
    XCTAssertTrue(counter.getValue == 0);
}

/**
 目的：正常に"1"が加算されているかを確認
 */
- (void)testIncrement {
    Counter *counter = [Counter new];
    [counter increment];
    // 前提：初期値0に1を加算している
    // 想定：valueには"1"が入っているかを確認
    XCTAssertTrue(counter.getValue == 1);
}

/**
 目的：正常に"1"が減算されているかを確認
 */
- (void)testDecrement {
    Counter *counter = [Counter new];
    [counter decrement];
    // 前提：初期値0に1を減算している
    // 想定：valueには"-1"が入っているかを確認
    XCTAssertTrue(counter.getValue == -1);
}

/**
 目的：連続で加算されても問題ないかを確認
 */
- (void)testMultiIncrement {
    Counter *counter = [Counter new];
    for (int i = 0; i < 10; i++) {
        [counter increment];
    }
    // 前提：初期値0に1を10回加算している
    // 想定：valueには"10"が入っているかを確認
    XCTAssertTrue(counter.getValue == 10);
}

/**
 目的：連続で減算されても問題ないかを確認
 */
- (void)testMultiDecrement {
    Counter *counter = [Counter new];
    for (int i = 0; i < 10; i++) {
        [counter decrement];
    }
    // 前提：初期値0に1を10回減算している
    // 想定：valueには"-10"が入っているかを確認
    XCTAssertTrue(counter.getValue == -10);
}

/**
 目的：複数のインスタンでは別々のポインタになることを確認する
 */
- (void)testPointer {
    Counter *counter1 = [Counter new];
    [counter1 increment];
    
    Counter *counter2 = [Counter new];
    [counter2 increment];
    // 前提：counter1とcounter2にそれぞれ"1"が入っている
    // 想定：ポインタが別であることを確認
    XCTAssertFalse(counter1 == counter2);
}

/**
 目的：複数のインスタンでも同値になるかを確認する
 */
- (void)testEquivalence {
    Counter *counter1 = [Counter new];
    [counter1 increment];
    
    Counter *counter2 = [Counter new];
    [counter2 increment];
    // 前提：counter1とcounter2にそれぞれ"1"が入っている
    // 想定：同値かどうかを確認
    XCTAssertTrue(counter1.getValue == counter2.getValue);
}

@end
