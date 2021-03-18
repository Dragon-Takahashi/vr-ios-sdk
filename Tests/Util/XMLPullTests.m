//
//  XMLPullTests.m
//  Tests
//
//  Created by 髙橋和成 on 11/5/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "XMLPull.h"

@interface XMLPullTests : XCTestCase
@property int numOfRunningAsyncTest;
@end

@implementation XMLPullTests

- (void)setUp {
    [super setUp];
    self.numOfRunningAsyncTest = 0;
}

- (void)tearDown {
    [super tearDown];
}


#pragma mark init

/**
 目的：正常に初期化できるかを確認する
 */
- (void)testInitNormal {
    XMLPull *pull = [XMLPull new];
    // 前提：初期化が完了している
    // 想定：nullでないことを確認
    XCTAssertNotNil(pull);
}


#pragma mark getXml:(NSString*) url identity:(NSString*) identity filePath:(NSString*) filePath callback:(XmlPullCallback) callback

/**
 目的：200が返ってくる設定ファイルを取得できるかを確認する
 */
- (void)testGetXmlNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testGetXml"];
    
    
    NSString *configTimeout = @"5";
    
    @try {
        XMLPull *pull = [XMLPull new];
        
        [pull getXml:[self configNormalUrl] identity:@"test_default" configTimeout:configTimeout callback:^(NSString *configFilePath, NSString *date, NSString *identity, NSString *filePath) {
            
            // 前提：XMLファイルを取得している
            // 想定：XMLファイルのidentityが"test_default"であることを確認
            XCTAssertTrue([identity isEqualToString:@"test_default"]);
            // 想定：configFilePathがnullではないことを確認
            XCTAssertNotNil(configFilePath);
            
            [expectation fulfill];
        }];
    } @catch (NSException *exception) {
        XCTFail(@"%@", [exception reason]);
    }
    
    
    [self waitForExpectationsWithTimeout:6 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：404が返ってくる設定ファイルを取得できるかを確認する
 */
- (void)testGetXmlIrregular404 {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testGetXml"];
    
    
    NSString *configTimeout = @"5";
    
    @try {
        XMLPull *pull = [XMLPull new];
        
        [pull getXml:[self config404Url] identity:@"test_default" configTimeout:configTimeout callback:^(NSString *configFilePath, NSString *date, NSString *identity, NSString *filePath) {
            
            // 前提：XMLファイルを取得している
            // 想定：XMLファイルのidentityが"test_default"であることを確認
            XCTAssertTrue([identity isEqualToString:@"test_default"]);
            // 想定：configFilePathがnullであることを確認
            XCTAssertNil(configFilePath);
            
            [expectation fulfill];
        }];
    } @catch (NSException *exception) {
        XCTFail(@"%@", [exception reason]);
    }
    
    
    [self waitForExpectationsWithTimeout:6 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

- (NSString *)configNormalUrl {
    return @"https://s3-ap-northeast-1.amazonaws.com/s3-vrlinc-stg-static-content-storage/test/sdk_config/vrTrackingConfig.xml";
}

- (NSString *)config404Url {
    return @"https://s3-ap-northeast-1.amazonaws.com/s3-vrlinc-stg-static-content-storage/test/sdk_404_config/vrTrackingConfig.xml";
}


@end
