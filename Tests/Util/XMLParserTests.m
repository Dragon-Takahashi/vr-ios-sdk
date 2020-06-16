//
//  XMLParserTests.m
//  Tests
//
//  Created by 髙橋和成 on 11/5/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "XMLParser.h"
#import "ConfigFile.h"
//#import "../../VrInteractiveTracking/Common/XMLParser.h"
//#import "../../VrInteractiveTracking/Domain/Config/ConfigFile.h"

@interface XMLParserTests : XCTestCase

@end

@implementation XMLParserTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}


/**
 初期化の正常系テスト
 */
- (void)testParseXMLInitNormal {
    // 初期化
    XMLParser *parser = [XMLParser new];
    // テスト
    XCTAssertNotNil(parser);
}

#pragma mark parseXML

/**
 パースの正常系テスト
 */
- (void)testParseXMLParseNormal {
    // 初期化
    XMLParser *parser = [XMLParser new];
    // パース処理
    [parser parseXML:[self getTestConfigFilePath:@"TestVrTrackingConfig"] identity:@"test_config" date:nil isRemoteFile:NO callback:^(NSMutableArray *configFileArray, BOOL isRemoteFile) {
        
        // テスト
        XCTAssertTrue([[configFileArray[0] getIdentity] isEqualToString:@"test_config"]);
    }];
}

/**
 identity=Defaultテスト
 */
- (void)testParseXMLParseIdentityDefault {
    // 初期化
    XMLParser *parser = [XMLParser new];
    // パース処理
    [parser parseXML:[self getTestConfigFilePath:@"TestVrTrackingConfig"] identity:@"default" date:nil isRemoteFile:NO callback:^(NSMutableArray *configFileArray, BOOL isRemoteFile) {
        
        // テスト
        XCTAssertTrue([configFileArray count] == 1);
        XCTAssertTrue([[configFileArray[0] getIdentity] isEqualToString:@"default"]);
    }];
}

/**
 identity設定テスト
 */
- (void)testParseXMLParseIdentityMissmatch {
    // 初期化
    XMLParser *parser = [XMLParser new];
    // パース処理
    [parser parseXML:[self getTestConfigFilePath:@"TestVrTrackingConfig"] identity:@"test_default" date:nil isRemoteFile:NO callback:^(NSMutableArray *configFileArray, BOOL isRemoteFile) {
        
        // テスト
        XCTAssertTrue([configFileArray count] == 1);
        XCTAssertTrue([[configFileArray[0] getIdentity] isEqualToString:@"test_default"]);
    }];
}


/**
 複数設定テスト
 */
- (void)testParseXMLParseMultipulConfig {
    // 初期化
    XMLParser *parser = [XMLParser new];
    // パース処理
    [parser parseXML:[self getTestConfigFilePath:@"SeriesVrTrackingConfig"] identity:@"test_default" date:nil isRemoteFile:NO callback:^(NSMutableArray *configFileArray, BOOL isRemoteFile) {
        
        // テスト
        XCTAssertTrue([configFileArray count] == 3);
        XCTAssertTrue([[configFileArray[0] getIdentity] isEqualToString:@"default"]);
        XCTAssertTrue([[configFileArray[1] getIdentity] isEqualToString:@"test1"]);
        XCTAssertTrue([[configFileArray[2] getIdentity] isEqualToString:@"test2"]);
    }];
}

/**
 テスト用のローカル設定ファイルを取得
 
 @param fileName ファイル名
 @return ファイルパス
 */
- (NSString *)getTestConfigFilePath:(NSString *)fileName {
    // Documentsディレクトリパス
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirPath = [path objectAtIndex:0];
    NSString *configPath = [[documentsDirPath stringByAppendingPathComponent:@"Config"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml",fileName]];
    // Documents配下に設定ファイルがあるかを判定
    if ([[NSFileManager defaultManager] fileExistsAtPath:configPath] == NO) {
        configPath = [[NSBundle bundleForClass:self.class] pathForResource:fileName ofType:@"xml"];
    }
    NSLog(@"Local config file path = %@", configPath);
    return configPath;
}

- (NSString *)testConfigPath:(NSString *)fileName {
    NSString *configPath = [[NSBundle bundleForClass:self.class] pathForResource:fileName ofType:@"xml"];
    
    NSLog(@"Test local config file path = %@", configPath);
    return configPath;
}

@end
