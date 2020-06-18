//
//  ConfigFileProviderStubTests.m
//  Tests
//
//  Created by 髙橋和成 on 11/1/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ConfigFileProviderStub.h"
//#import "ConfigFileProvider.h"
#import "../../../VrInteractiveTracking/Domain/Config/ConfigFileProvider.h"

NSString *const VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY = @"default";
NSString *const VR_LIB_DEFAULT_FILE_NAME = @"vrTrackingConfig";

@interface ConfigFileProviderTests : XCTestCase
@property (nonatomic) int numOfRunningAsyncTest;
@property (nonatomic) NSTimeInterval timeoutSec;
@property (nonatomic) NSTimeInterval monitorInterval;
@property (nonatomic) NSDate *startDate;
@end

@implementation ConfigFileProviderTests

- (void)setUp {
    [super setUp];
    self.numOfRunningAsyncTest = 0;
    [ConfigFileProviderStub initConfig];
}

- (void)tearDown {
    [super tearDown];
}


#pragma mark - initWithOutsideConfigURL:(NSString *)outsideConfigURL callback:(ConfigStatusCallback) callback
/**
 目的：インスタンス化できるか
 */
- (void)testConfigFileProviderInit {
    ConfigFileProvider *configFileProvider = [[ConfigFileProvider alloc] initWithOutsideConfigURL:[self testConfigPath:@"vrTrackingConfig"] callback:^(BOOL isRunning, NSString *identity) {
        
    }];
    
    // 前提：なし
    // 想定：インスタンスがnilでない
    XCTAssertNotNil(configFileProvider);
}

/**
 目的：１つの設定ファイルでコールバックが返ってくるか
 */
- (void)testConfigFileProviderCallbackSingle {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testConfigFileProviderCallback"];
    __block ConfigFileProvider *configFileProvider;
    configFileProvider = [[ConfigFileProvider alloc] initWithOutsideConfigURL:[self testConfigPath:@"vrTrackingConfig"] callback:^(BOOL isRunning, NSString *identity) {

        if (!isRunning && [identity isEqualToString:@"test_config"]) {

            // 前提：コールバックを設定し、Identity=test_configで処理を行なっている
            // 想定：identity=test_configで設定ファイルの読み込みコールバックが返ってくる
            XCTAssertNotNil(configFileProvider);
            
            [expectation fulfill];
        }
    }];

    [configFileProvider addConfigWithIdentity:@"test_config" fileName:@"TestVrTrackingConfig"];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：複数の設定ファイルでコールバックが返ってくるか
 */
- (void)testConfigFileProviderCallbackMultipul {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testConfigFileProviderCallbackMultipul"];
    __block ConfigFileProvider *configFileProvider;
    configFileProvider = [[ConfigFileProviderStub alloc] initWithOutsideConfigURL:[self testConfigPath:@"SeriesVrTrackingConfig"] callback:^(BOOL isRunning, NSString *identity) {

        if (!isRunning && [identity isEqualToString:@"test_config"]) {

            // 前提：コールバックを設定し、Identity=test_configで処理を行なっている
            // 想定：identity=test_configで設定ファイルの読み込みコールバックが返ってくる
            XCTAssertNotNil(configFileProvider);
            
            [expectation fulfill];
        }
    }];

    [configFileProvider addConfigWithIdentity:@"test_config" fileName:@"SeriesVrTrackingConfig"];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：１つの設定ファイルで設定が正しくされているが
 */
- (void)testConfigFileProviderCorrectSettingSingle {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testConfigFileProviderCorrectSettingSingle"];
    __block ConfigFileProvider *configFileProvider;
    configFileProvider = [[ConfigFileProviderStub alloc] initWithOutsideConfigURL:[self testConfigPath:@"vrTrackingConfig"] callback:^(BOOL isRunning, NSString *identity) {

        if (!isRunning && [identity isEqualToString:@"test_config"]) {

            // 前提：コールバックを設定し、Identity=test_configで処理を行なっている
            // 想定：identity=default, test1, test2のConfigが作成されている
            XCTAssertNotNil([configFileProvider loadConfig:@"test_config"]);
            
            [expectation fulfill];
        }
    }];

    [configFileProvider addConfigWithIdentity:@"test_config" fileName:@"vrTrackingConfig"];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：複数の設定ファイルで設定が正しくされているが
 */
- (void)testConfigFileProviderCorrectSettingMultipul {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testConfigFileProviderCallbackMultipul"];
    __block ConfigFileProvider *configFileProvider;
    configFileProvider = [[ConfigFileProviderStub alloc] initWithOutsideConfigURL:[self testConfigPath:@"SeriesVrTrackingConfig"] callback:^(BOOL isRunning, NSString *identity) {

        if (!isRunning && [identity isEqualToString:@"test_config"]) {

            // 前提：コールバックを設定し、Identity=test_configで処理を行なっている
            // 想定：identity=default, test1, test2のConfigが作成されている
//            XCTAssertNotNil([configFileProvider loadConfig:@"test_config"]);
            XCTAssertNotNil([configFileProvider loadConfig]);
            XCTAssertNotNil([configFileProvider loadConfig:@"test1"]);
            XCTAssertNotNil([configFileProvider loadConfig:@"test2"]);
            
            [expectation fulfill];
        }
    }];

    [configFileProvider addConfigWithIdentity:@"test_config" fileName:@"SeriesVrTrackingConfig"];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


- (NSString *)testConfigPath:(NSString *)fileName {
    NSString *configPath = [[NSBundle bundleForClass:self.class] pathForResource:fileName ofType:@"xml"];
    
    NSLog(@"Test local config file path = %@", configPath);
    return configPath;
}




@end
