//
//  QueryParameterTest.m
//  Tests
//
//  Created by 髙橋和成 on 10/30/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "QueryParameter.h"

@interface QueryParameterTest : XCTestCase

@end

@implementation QueryParameterTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}


/**
 目的：初期化時に引数に設定した際に正しく取得できるかをテスト
 */
- (void)testInitNormal {
    QueryParameter *param = [[QueryParameter alloc] initWithParameter:@"Test key" value:@"Test value"];
    
    // 前提：keyに"Test key"が、valueに"Test value”が設定されている。
    // 想定：keyに"Test key"が入っているかを確認する
    XCTAssertTrue([param.key isEqualToString:@"Test key"]);
    // 想定：valueに"Test value"が入っているかを確認する
    XCTAssertTrue([param.value isEqualToString:@"Test value"]);
}

/**
 目的：初期化時に空文字を引数に設定した際に正しく取得できるかをテスト
 */
- (void)testInitIrregularEmpty {
    QueryParameter *param = [[QueryParameter alloc] initWithParameter:@"" value:@""];
    
    // 前提：keyに"Test key"が、valueに"Test value”が設定されている。
    // 想定：keyに空文字が入っているかを確認する
    XCTAssertTrue([param.key isEqualToString:@""]);
    // 想定：valueに空文字が入っているかを確認する
    XCTAssertTrue([param.value isEqualToString:@""]);
}

/**
 目的：初期化時にnilを引数に設定した際に正しく取得できるかをテスト
 */
- (void)testInitIrregularNull {
    QueryParameter *param = [[QueryParameter alloc] initWithParameter:nil value:nil];
    
    // 前提：keyにnilが、valueにnilが設定されている。
    // 想定：keyがnilになっているかを確認する
    XCTAssertTrue(param.key == nil);
    // 想定：valueがnilになっているかを確認する
    XCTAssertTrue(param.value == nil);
}


/**
 目的：２つのインスタンスを作成した際に別のインスタンスとして認識するかをテスト
 */
- (void)testInitNotEquivalence {
    QueryParameter *param1 = [[QueryParameter alloc] initWithParameter:@"Test key1" value:@"Test value1"];
    QueryParameter *param2 = [[QueryParameter alloc] initWithParameter:@"Test key2" value:@"Test value2"];
    
    // 前提：param1とparam2にはそれぞれ別のkey/valueが設定されている
    // 想定：インスタンスが別かどうかを確認
    XCTAssertTrue(param1 != param2);
    // 想定：keyが違うことを確認
    XCTAssertTrue(param1.key != param2.key);
    // 想定：valueが違うことを確認
    XCTAssertTrue(param1.value != param2.value);
}


@end
