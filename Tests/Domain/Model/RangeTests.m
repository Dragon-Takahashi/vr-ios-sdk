//
//  RangeTests.m
//  Tests
//
//  Created by 髙橋和成 on 11/14/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Range.h"

@interface RangeTests : XCTestCase

@end

@implementation RangeTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

/**
 目的：指定した上限下限の値が正常に設定されているかを確認
 */
- (void)testNormal {
    Range *range = [[Range alloc] initWithLesserEqual:1 greater_equal:20];
    // 前提：[下限:1 上限:20]の範囲内
    // 想定：5がtrueであることを確認
    XCTAssertTrue([range includes:5]);
}

/**
 目的：指定した上限下限の値が正常に設定されているかを境界値テストで確認
 */
- (void)testBoundaryValueTest {
    Range *range = [[Range alloc] initWithLesserEqual:(long)1 greater_equal:(long)20];
    
    // 前提：[下限:1 上限:20]の範囲内
    // 想定：0がfalseであることを確認
    XCTAssertFalse([range includes:(long)0]);
    // 想定：1がtrueであることを確認
    XCTAssertTrue([range includes:(long)1]);
    // 想定：2がtrueであることを確認
    XCTAssertTrue([range includes:(long)2]);
    // 想定：19がtrueであることを確認
    XCTAssertTrue([range includes:(long)19]);
    // 想定：20がtrueであることを確認
    XCTAssertTrue([range includes:(long)20]);
    // 想定：21がfalseであることを確認
    XCTAssertFalse([range includes:(long)21]);
}

//
/**
 目的：toStringメソッドが正しく変数を文字列に反映できているかを確認する
 */
- (void)testToString {
    Range *range = [[Range alloc] initWithLesserEqual:1 greater_equal:20];
    // 前提：[下限:1 上限:20]の範囲内
    // 想定：指定した下限と上限の値が文字列に反映されていることを確認
    NSLog(@"%@",[range toString]);
    XCTAssertTrue([[range toString] isEqualToString:@"lesser equal[1],greater equal[20]"]);
}

@end
