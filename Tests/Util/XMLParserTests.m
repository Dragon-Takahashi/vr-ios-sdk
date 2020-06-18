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
 目的：インスタンス化できるか
 */
- (void)testParseXMLInitNormal {
    XMLParser *parser = [XMLParser new];
    
    // 前提：なし
    // 想定：インスタンスがnilでない
    XCTAssertNotNil(parser);
}

#pragma mark parseXML

/**
 目的：正常にパースが行えるかを確認する
 */
- (void)testParseXMLParseNormal {
    // 初期化
    XMLParser *parser = [XMLParser new];
    // パース処理
    [parser parseXML:[self getTestConfigFilePath:@"TestVrTrackingConfig"] identity:@"test_config" date:nil isRemoteFile:NO callback:^(NSMutableArray *configFileArray, BOOL isRemoteFile) {
        
        // 前提：インスタンス化し、パース処理を行なっている
        // 想定：設定ファイルを読み込み、必須設定項目のIdentityが設定できている
        XCTAssertTrue([[configFileArray[0] getIdentity] isEqualToString:@"test_config"]);
    }];
}

/**
 目的：引数のIdentityを設定ファイルに記載されているIdentityより優先して設定できているかを確認する
 */
- (void)testParseXMLParsePriority {
    // 初期化
    XMLParser *parser = [XMLParser new];
    // パース処理
    [parser parseXML:[self getTestConfigFilePath:@"TestVrTrackingConfig"] identity:@"test_config_A" date:nil isRemoteFile:NO callback:^(NSMutableArray *configFileArray, BOOL isRemoteFile) {
        
        // 前提：インスタンス化し、パース処理を行なっている
        // 想定：設定ファイルを読み込み、Identityが引数の値になっている
        XCTAssertTrue([[configFileArray[0] getIdentity] isEqualToString:@"test_config_A"]);
    }];
}

/**
 目的：複数の設定が含まれている設定ファイルの場合に全ての設定が正しくパースできているかを確認する
 */
- (void)testParseXMLParseMultipulConfig {
    // 初期化
    XMLParser *parser = [XMLParser new];
    // パース処理
    [parser parseXML:[self getTestConfigFilePath:@"SeriesVrTrackingConfig"] identity:@"test_default" date:nil isRemoteFile:NO callback:^(NSMutableArray *configFileArray, BOOL isRemoteFile) {
        
        // 前提：インスタンス化し、複数の設定が含まれている設定ファイルのパース処理を行なっている
        // 想定１：Identityが無視されている
        XCTAssertFalse([[configFileArray[0] getIdentity] isEqualToString:@"test_default"]);
        // 想定２：設定ファイルに含まれている個数がパースされている
        XCTAssertTrue([configFileArray count] == 3);
        // 想定３：設定ファイルに含まれているIdentityが正しくConfigクラスに設定されている
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
