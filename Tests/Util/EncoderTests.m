//
//  EncoderTests.m
//  Tests
//
//  Created by 髙橋和成 on 11/5/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Encoder.h"

@interface EncoderTests : XCTestCase

@end

@implementation EncoderTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (NSString *)normalURL {
    return @"https://panelstg.interactive-circle.jp/ver01/measure?test_key1=test_value1";
}
- (NSString *)encodedURL {
    return @"https%3A%2F%2Fpanelstg.interactive-circle.jp%2Fver01%2Fmeasure%3Ftest_key1%3Dtest_value1";
}

#pragma mark urlEncode:(NSString*) urlStr

/**
 エンコードの正常系テスト
 */
- (void)testUrlEncoderNormal {
    NSLog(@"%@", [Encoder urlEncode:[self normalURL]]);
    XCTAssertTrue([[Encoder urlEncode:[self normalURL]] isEqualToString:[self encodedURL]]);
}


/**
 異常系テストパターン（追加予定）
 ・特殊文字
 ・日本語
 ・英語大文字
 ・500文字程度の長めのURL
 */

@end
