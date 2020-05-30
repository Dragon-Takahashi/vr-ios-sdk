//
//  ResponseTests.m
//  Tests
//
//  Created by 髙橋和成 on 10/23/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Response.h"

@interface ResponseTests : XCTestCase

@end

@implementation ResponseTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

// 保持する値の一致テスト（Textクラス）
- (void)testTextInResponse {
    // 値を設定
    Status *status = [[Status alloc] initWithStatus:@"STATUS_TEST"];
    Text *text = [[Text alloc] initWithText:@"TEXT_TEST"];
    Response *response = [[Response alloc] initWithResult:status text:text];
    
    // 一致テスト
    XCTAssertEqual([response getText], text);
}

// 保持する値の一致テスト（Statusクラス）
- (void)testStatusInResponse {
    // 値を設定
    Status *status = [[Status alloc] initWithStatus:@"STATUS_TEST"];
    Text *text = [[Text alloc] initWithText:@"TEXT_TEST"];
    Response *response = [[Response alloc] initWithResult:status text:text];
    
    // 一致テスト
    XCTAssertEqual([response getStatus], status);
}

@end
