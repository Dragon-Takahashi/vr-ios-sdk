//
//  QuerySpecTest.m
//  Tests
//
//  Created by 髙橋和成 on 10/30/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "QuerySpec.h"
#import "OptValues.h"

@interface QuerySpecTest : XCTestCase

@end

@implementation QuerySpecTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - init

/**
 初期化テスト（self）
 */
- (void)testInit {
    // 生成
    QuerySpec *spec = [QuerySpec new];
    
    // 生成テスト
    XCTAssertNotNil(spec);
}

/**
 初期化テスト（QueryParametersの値）
 */
- (void)testInitQueryParameters {
    // 生成
    QuerySpec *spec = [QuerySpec new];
    
    // 生成テスト
    XCTAssertNotNil(spec.getQueryParameters);
}



#pragma mark - getQueryParameters


/**
 取得した配列のnullテスト（初期化直後）
 */
- (void)testGetQueryParametersNonNull {
    // 生成
    QuerySpec *spec = [QuerySpec new];
    
    // 生成テスト
    XCTAssertNotNil([spec getQueryParameters]);
}

/**
 取得した配列の値テスト（値追加後）
 */
- (void)testGetQueryParametersIncludeValue {
    // 生成
    QuerySpec *spec = [QuerySpec new];
    
    // 値追加
    [[spec getQueryParameters] add:@"Test key" value:@"Test value"];
    
    // 生成テスト
    XCTAssertTrue([[[spec getQueryParameters] getValue:@"Test key"].value isEqualToString:@"Test value"]);
}


#pragma mark - clearAllParameters

/**
 配列内容をクリア後のnullテスト
 */
- (void)testClearAllParameters {
    // 生成
    QuerySpec *spec = [QuerySpec new];
    
    // 値追加
    [[spec getQueryParameters] add:@"Test key" value:@"Test value"];
    
    // クリア
    [spec clearAllParameters];
    
    // nullテスト
    XCTAssertNotNil([spec getQueryParameters]);
}

/**
 目的：正しくQueryParameterを全て削除出来ているかを確認する
 */
- (void)testClearAllParametersNullValue {
    QuerySpec *spec = [QuerySpec new];
    [[spec getQueryParameters] add:@"Test key" value:@"Test value"];
    
    [spec clearAllParameters];
    
    @try {
        [[spec getQueryParameters] getValue:@"Test key"];
        XCTFail(@"do not throw error.");
    } @catch (NSException *exception) {
        // 前提：QueryParameterを全て削除している
        // 想定：存在しないkeyなので、エラーが吐き出されるかを確認
        XCTAssertTrue([[exception reason] isEqualToString:@"key is not found : Test key"]);
    }
}


#pragma mark - addParametersWithBuilder

/**
 受け取ったパラメータをビルダーとして処理
 
 @param builder ビルドメソッド
 @return ビルダー
 */
- (OptValues *)querySpecBuilder:(void (^)(OptValues *)) builder {
    OptValues *innerBuilder = [OptValues new];
    builder(innerBuilder);
    return innerBuilder;
}

/**
 ビルダーでの生成テスト（単体）
 */
- (void)testAddParametersWithBuilderSingleParameter {
    // 生成
    QuerySpec *spec = [QuerySpec new];
    
    // 追加
    [spec addParametersWithBuilder:[self querySpecBuilder:^(OptValues *builder) {
        builder.vr_opt1 = @"test_value1";
    }]];
    
    // 整合性テスト
    XCTAssertTrue([[[spec getQueryParameters] getValue:@"vr_opt1"].value isEqualToString:@"test_value1"]);
}

/**
 ビルダーでの生成テスト（フルセット）
 */
- (void)testAddParametersWithBuilderFullParameter {
    // 生成
    QuerySpec *spec = [QuerySpec new];
    
    // 追加
    [spec addParametersWithBuilder:[self querySpecBuilder:^(OptValues *builder) {
        builder.vr_opt1 = @"test_value1";
        builder.vr_opt2 = @"test_value2";
        builder.vr_opt3 = @"test_value3";
        builder.vr_opt4 = @"test_value4";
        builder.vr_opt5 = @"test_value5";
        builder.vr_opt6 = @"test_value6";
        builder.vr_opt7 = @"test_value7";
        builder.vr_opt8 = @"test_value8";
        builder.vr_opt9 = @"test_value9";
    }]];
    
    // 整合性テスト
    XCTAssertTrue([[[spec getQueryParameters] getValue:@"vr_opt1"].value isEqualToString:@"test_value1"]);
    XCTAssertTrue([[[spec getQueryParameters] getValue:@"vr_opt2"].value isEqualToString:@"test_value2"]);
    XCTAssertTrue([[[spec getQueryParameters] getValue:@"vr_opt3"].value isEqualToString:@"test_value3"]);
    XCTAssertTrue([[[spec getQueryParameters] getValue:@"vr_opt4"].value isEqualToString:@"test_value4"]);
    XCTAssertTrue([[[spec getQueryParameters] getValue:@"vr_opt5"].value isEqualToString:@"test_value5"]);
    XCTAssertTrue([[[spec getQueryParameters] getValue:@"vr_opt6"].value isEqualToString:@"test_value6"]);
    XCTAssertTrue([[[spec getQueryParameters] getValue:@"vr_opt7"].value isEqualToString:@"test_value7"]);
    XCTAssertTrue([[[spec getQueryParameters] getValue:@"vr_opt8"].value isEqualToString:@"test_value8"]);
    XCTAssertTrue([[[spec getQueryParameters] getValue:@"vr_opt9"].value isEqualToString:@"test_value9"]);
}

/**
 ビルダーでの上書きテスト（単体）
 */
- (void)testAddParametersWithBuilderSingleParameter2StraightTimes {
    // 生成
    QuerySpec *spec = [QuerySpec new];
    
    // 追加
    [spec addParametersWithBuilder:[self querySpecBuilder:^(OptValues *builder) {
        builder.vr_opt1 = @"test_value1";
    }]];
    
    [spec addParametersWithBuilder:[self querySpecBuilder:^(OptValues *builder) {
        builder.vr_opt1 = @"test_value1_1";
    }]];
    
    // 整合性テスト
    XCTAssertTrue([[[spec getQueryParameters] getValue:@"vr_opt1"].value isEqualToString:@"test_value1_1"]);
}

/**
 ビルダーでの生成テスト（フルセット）
 */
- (void)testAddParametersWithBuilderFullParameter2StraightTimes {
    // 生成
    QuerySpec *spec = [QuerySpec new];
    
    // 追加
    [spec addParametersWithBuilder:[self querySpecBuilder:^(OptValues *builder) {
        builder.vr_opt1 = @"test_value1";
        builder.vr_opt2 = @"test_value2";
        builder.vr_opt3 = @"test_value3";
        builder.vr_opt4 = @"test_value4";
        builder.vr_opt5 = @"test_value5";
        builder.vr_opt6 = @"test_value6";
        builder.vr_opt7 = @"test_value7";
        builder.vr_opt8 = @"test_value8";
        builder.vr_opt9 = @"test_value9";
    }]];
    
    [spec addParametersWithBuilder:[self querySpecBuilder:^(OptValues *builder) {
        builder.vr_opt1 = @"test_value1_1";
        builder.vr_opt2 = @"test_value2_1";
        builder.vr_opt3 = @"test_value3_1";
        builder.vr_opt4 = @"test_value4_1";
        builder.vr_opt5 = @"test_value5_1";
        builder.vr_opt6 = @"test_value6_1";
        builder.vr_opt7 = @"test_value7_1";
        builder.vr_opt8 = @"test_value8_1";
        builder.vr_opt9 = @"test_value9_1";
    }]];
    
    // 整合性テスト
    XCTAssertTrue([[[spec getQueryParameters] getValue:@"vr_opt1"].value isEqualToString:@"test_value1_1"]);
    XCTAssertTrue([[[spec getQueryParameters] getValue:@"vr_opt2"].value isEqualToString:@"test_value2_1"]);
    XCTAssertTrue([[[spec getQueryParameters] getValue:@"vr_opt3"].value isEqualToString:@"test_value3_1"]);
    XCTAssertTrue([[[spec getQueryParameters] getValue:@"vr_opt4"].value isEqualToString:@"test_value4_1"]);
    XCTAssertTrue([[[spec getQueryParameters] getValue:@"vr_opt5"].value isEqualToString:@"test_value5_1"]);
    XCTAssertTrue([[[spec getQueryParameters] getValue:@"vr_opt6"].value isEqualToString:@"test_value6_1"]);
    XCTAssertTrue([[[spec getQueryParameters] getValue:@"vr_opt7"].value isEqualToString:@"test_value7_1"]);
    XCTAssertTrue([[[spec getQueryParameters] getValue:@"vr_opt8"].value isEqualToString:@"test_value8_1"]);
    XCTAssertTrue([[[spec getQueryParameters] getValue:@"vr_opt9"].value isEqualToString:@"test_value9_1"]);
}


@end
