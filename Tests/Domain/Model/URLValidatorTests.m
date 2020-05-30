//
//  URLValidatorTests.m
//  Tests
//
//  Created by 髙橋和成 on 1/10/19.
//  Copyright © 2019 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "URLValidator.h"

@interface URLValidatorTests : XCTestCase

@end

@implementation URLValidatorTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testNormalURLhttp {
    URLValidator *validator = [[URLValidator alloc] initWithURL:@"http://google.com/" handler:[URLValidationHandler new]];
    [validator validate];
    XCTAssertFalse([validator.handler errors]);
}

- (void)testNormalURLhttps {
    URLValidator *validator = [[URLValidator alloc] initWithURL:@"https://google.com/" handler:[URLValidationHandler new]];
    [validator validate];
    XCTAssertFalse([validator.handler errors]);
}

- (void)testNormalURLhttp2 {
    URLValidator *validator = [[URLValidator alloc] initWithURL:@"http://google.com" handler:[URLValidationHandler new]];
    [validator validate];
    XCTAssertFalse([validator.handler errors]);
}
- (void)testNormalURLhttps2 {
    URLValidator *validator = [[URLValidator alloc] initWithURL:@"https://google.com" handler:[URLValidationHandler new]];
    [validator validate];
    XCTAssertFalse([validator.handler errors]);
}

- (void)testNormalFullURLhttp {
    URLValidator *validator = [[URLValidator alloc] initWithURL:@"http://panelstg.interactive-circle.jp/ver01/measure?vr_tagid1=9997&vr_tagid2=1001&vr_opt1=direct_test" handler:[URLValidationHandler new]];
    [validator validate];
    XCTAssertFalse([validator.handler errors]);
}

- (void)testNormalFullURLhttps {
    URLValidator *validator = [[URLValidator alloc] initWithURL:@"https://panelstg.interactive-circle.jp/ver01/measure?vr_tagid1=9997&vr_tagid2=1001&vr_opt1=direct_test" handler:[URLValidationHandler new]];
    [validator validate];
    XCTAssertFalse([validator.handler errors]);
}


- (void)testWrongURLhtp {
    URLValidator *validator = [[URLValidator alloc] initWithURL:@"htp://google.com/" handler:[URLValidationHandler new]];
    [validator validate];
    XCTAssertTrue([validator.handler errors]);
}

- (void)testWrongURLJapanese {
    URLValidator *validator = [[URLValidator alloc] initWithURL:@"htp://google.coあm/" handler:[URLValidationHandler new]];
    [validator validate];
    XCTAssertTrue([validator.handler errors]);
}

- (void)testWrongURLSpace {
    URLValidator *validator = [[URLValidator alloc] initWithURL:@"htp://google.c om/" handler:[URLValidationHandler new]];
    [validator validate];
    XCTAssertTrue([validator.handler errors]);
}


- (void)testWrongURLMultiQuestionMark {
    URLValidator *validator = [[URLValidator alloc] initWithURL:@"htp://google.com/?a?b?c" handler:[URLValidationHandler new]];
    [validator validate];
    XCTAssertTrue([validator.handler errors]);
}

@end
