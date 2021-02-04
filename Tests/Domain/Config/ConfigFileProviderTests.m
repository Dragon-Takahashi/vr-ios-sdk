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
 目的：インスタンス化できるか確認（VRタグ）
 */
- (void)testVRConfigFileProviderInit {
    ConfigFileProvider *configFileProvider = [[ConfigFileProvider alloc] initWithOutsideConfigURL:[self testConfigPath:@"vrTrackingConfig"] callback:^(BOOL isRunning, NSString *identity) {
        
    }];
    
    // 前提：なし
    // 想定：インスタンスがnilでない
    XCTAssertNotNil(configFileProvider);
}
/**
 目的：インスタンス化できるか確認（Vタグ）
 */
- (void)testVConfigFileProviderInit {
    ConfigFileProvider *configFileProvider = [[ConfigFileProvider alloc] initWithOutsideConfigURL:[self testConfigPath:@"vrTrackingVConfig"] callback:^(BOOL isRunning, NSString *identity) {
        
    }];
    
    // 前提：なし
    // 想定：インスタンスがnilでない
    XCTAssertNotNil(configFileProvider);
}

/**
 目的：１つの設定ファイルでコールバックが返ってくるか確認
 */
- (void)testVConfigFileProviderCallbackSingle {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testVConfigFileProviderCallbackSingle"];
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
 目的：１つの設定ファイルでコールバックが返ってくるか確認
 */
- (void)testVRConfigFileProviderCallbackSingle {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testVRConfigFileProviderCallbackSingle"];
    __block ConfigFileProvider *configFileProvider;
    configFileProvider = [[ConfigFileProvider alloc] initWithOutsideConfigURL:[self testConfigPath:@"vrTrackingVConfig"] callback:^(BOOL isRunning, NSString *identity) {

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
 目的：複数の設定ファイルでコールバックが返ってくるか確認
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
 目的：複数の設定ファイルでコールバックが返ってくるか確認
 */
- (void)testVConfigFileProviderCallbackMultipul {
//    [self testConfigPath:@"SeriesVrTrackingConfig3"];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testConfigFileProviderCallbackMultipul"];
    __block ConfigFileProvider *configFileProvider;
    configFileProvider = [[ConfigFileProviderStub alloc] initWithOutsideConfigURL:[self testConfigPath:@"SeriesVrTrackingConfig3"] callback:^(BOOL isRunning, NSString *identity) {
        
        if (!isRunning && [identity isEqualToString:@"test_config"]) {

            // 前提：コールバックを設定し、Identity=test_configで処理を行なっている
            // 想定：identity=test_configで設定ファイルの読み込みコールバックが返ってくる
            XCTAssertNotNil(configFileProvider);
            
            [expectation fulfill];
        }
    }];

    [configFileProvider addConfigWithIdentity:@"test_config" fileName:@"SeriesVrTrackingConfig3"];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：１つの設定ファイルで設定が正しくされているか確認
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
 目的：１つの設定ファイルで設定が正しくされているか確認
 */
- (void)testVConfigFileProviderCorrectSettingSingle {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testVConfigFileProviderCorrectSettingSingle"];
    __block ConfigFileProvider *configFileProvider;
    configFileProvider = [[ConfigFileProviderStub alloc] initWithOutsideConfigURL:[self testConfigPath:@"vrTrackingVConfig"] callback:^(BOOL isRunning, NSString *identity) {

        if (!isRunning && [identity isEqualToString:@"test_config"]) {

            // 前提：コールバックを設定し、Identity=test_configで処理を行なっている
            // 想定：identity=default, test1, test2のConfigが作成されている
            XCTAssertNotNil([configFileProvider loadConfig:@"test_config"]);
            
            [expectation fulfill];
        }
    }];

    [configFileProvider addConfigWithIdentity:@"test_config" fileName:@"vrTrackingVConfig"];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：複数の設定ファイルで設定が正しくされているか確認
 */
- (void)testConfigFileProviderCorrectSettingMultipul {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testConfigFileProviderCorrectSettingMultipul"];
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

/**
 目的：複数の設定ファイルで設定が正しくされているか確認
 */
- (void)testVConfigFileProviderCorrectSettingMultipul {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testVConfigFileProviderCorrectSettingMultipul"];
    __block ConfigFileProvider *configFileProvider;
    configFileProvider = [[ConfigFileProviderStub alloc] initWithOutsideConfigURL:[self testConfigPath:@"SeriesVrTrackingConfig"] callback:^(BOOL isRunning, NSString *identity) {

        if (!isRunning && [identity isEqualToString:@"test_config"]) {

            // 前提：コールバックを設定し、Identity=test_configで処理を行なっている
            // 想定：identity=default, test1, test2、testv1のConfigが作成されている、かつ、test_configがVタグに変更されている
//            XCTAssertNotNil([configFileProvider loadConfig:@"test_config"]);
            XCTAssertNotNil([configFileProvider loadConfig]);
            XCTAssertNotNil([configFileProvider loadConfig:@"test1"]);
            XCTAssertNotNil([configFileProvider loadConfig:@"test2"]);
            XCTAssertNotNil([configFileProvider loadConfig:@"testv1"]);
            NSString *tagType = [[configFileProvider loadConfig:@"test_config"] getTagType];
//            NSLog(@"%@", [[configFileProvider loadConfig:@"test_config"] getElements]);
            XCTAssertEqual(@"v", tagType);
            
            [expectation fulfill];
        }
    }];

    [configFileProvider addConfigWithIdentity:@"test_config" fileName:@"SeriesVrTrackingConfig3"];
    
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
