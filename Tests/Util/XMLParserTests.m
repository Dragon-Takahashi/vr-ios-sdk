//
//  XMLParserTests.m
//  Tests
//
//  Created by 髙橋和成 on 11/5/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "XMLParser.h"

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
 ConfigFileProviderクラスの正常系UTブランチとマージ後に実施（ConfigFileの競合を回避するため、）
 */
//- (void)testParseXMLParseNormal {
//    // 初期化
//    XMLParser *parser = [XMLParser new];
//    // パース処理
//    [parser parseXML:[self getTestConfigFilePath:@"vrTrackingConfig"] identity:@"test_default" date:nil isRemoteFile:NO callback:^(NSMutableDictionary *result, NSString *identity, NSString *filePath, NSString *date, BOOL isRemoteFile) {
//        // テスト
//        XCTAssertTrue([identity isEqualToString:@"test_default"]);
//    }];
//}


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




@end
