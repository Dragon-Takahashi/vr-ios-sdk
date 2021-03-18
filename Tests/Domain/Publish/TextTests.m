//
//  TextTests.m
//  Tests
//
//  Created by 髙橋和成 on 10/23/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Text.h"

@interface TextTests : XCTestCase

@end

@implementation TextTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

// 保持する値の一致テスト
- (void)testText {
    // 値を設定
    Text *text = [[Text alloc] initWithText:@"TEST"];
    
    // 一致テスト
    XCTAssertTrue([[text getText] isEqualToString:@"TEST"]);
    
}

@end
