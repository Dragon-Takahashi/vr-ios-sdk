//
//  StatusTests.m
//  Tests
//
//  Created by 髙橋和成 on 10/23/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Status.h"

@interface StatusTests : XCTestCase

@end

@implementation StatusTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

// 保持する値の一致テスト
- (void)testStatus {
    // 値を設定
    Status *status = [[Status alloc] initWithStatus:@"TEST"];
    
    // 一致テスト
    XCTAssertTrue([[status getStatus] isEqualToString:@"TEST"]);
}

@end
