//
//  VConfigValidatorTests.m
//  Tests
//
//  Created by 髙橋和成 on 1/30/21.
//  Copyright © 2021 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "../../../VrInteractiveTracking/Domain/Config/ConfigProvider.h"
#import "../../../VrInteractiveTracking/Domain/Config/VrConfigValidator.h"
#import "../../../VrInteractiveTracking/Common/XMLParser.h"

@interface VrConfigValidatorTests : XCTestCase

@end

@implementation VrConfigValidatorTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

/**
 目的：初期化が正常に行われることを確認する
 */
- (void)testInit {
    
    NSString *filePath = [self getFilePath:@"vrTrackingConfig_validateNomal"];
    NSString *identity = @"v";
    NSString *date = @"";
    BOOL isRemoteFile = NO;
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"vrTrackingConfig_validateNomal"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {

        XMLParser *xmlParser = [[XMLParser alloc] init];
        [xmlParser parseXML:filePath identity:identity date:date isRemoteFile:isRemoteFile callback:^(NSMutableArray *configFileArray, BOOL isRemoteFile) {

            for (id <Config> config in configFileArray) {

                @try {
                    // 正常ファイルか判断
                    VrConfigValidator *validator = [[VrConfigValidator alloc] initWithValidationHandler:[ConfigValidationHandler new] config:config];
                    config.isNormal = ![[validator handler] errors];
                    NSLog(@"%@", config.getElements);
                    
                    // 前提：想定しているバリデーションを通して正常な設定ファイルを読み込む
                    // 想定：エラーなし
                    XCTAssertFalse( [[validator handler] errors] );
                    
                } @catch (NSException *exception) {
                    XCTAssertNoThrow(exception);
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [expectation fulfill];
            });
        }];
        
    });
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：バリデーションが行われることを確認する。異常系（タグ無し）
 */
- (void)testValidateAbomalNotTag {
    
    NSString *filePath = [self getFilePath:@"vrTrackingConfig_validateNotTag"];
    NSString *identity = @"v";
    NSString *date = @"";
    BOOL isRemoteFile = NO;
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"vrTrackingConfig_validateNotTag"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {

        XMLParser *xmlParser = [[XMLParser alloc] init];
        [xmlParser parseXML:filePath identity:identity date:date isRemoteFile:isRemoteFile callback:^(NSMutableArray *configFileArray, BOOL isRemoteFile) {

            for (id <Config> config in configFileArray) {

                @try {
                    // 正常ファイルか判断
                    VrConfigValidator *validator = [[VrConfigValidator alloc] initWithValidationHandler:[ConfigValidationHandler new] config:config];
                    config.isNormal = ![[validator handler] errors];
                    NSLog(@"%@", config.getElements);
                    NSLog(@"%@", [[validator handler] toString]);
                    
                    // 前提：想定しているバリデーションを通して正常な設定ファイルを読み込む
                    // 想定：エラーあり
                    XCTAssertTrue( [[validator handler] errors] );
                    
                } @catch (NSException *exception) {
                    XCTAssertNoThrow(exception);
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [expectation fulfill];
            });
        }];
        
    });
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：バリデーションが行われることを確認する。異常系（タグ有り、値無し）
 */
- (void)testValidateAbomalNotValue {
    
    NSString *filePath = [self getFilePath:@"vrTrackingConfig_validateNotValue"];
    NSString *identity = @"v";
    NSString *date = @"";
    BOOL isRemoteFile = NO;
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"vrTrackingConfig_validateNotValue"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {

        XMLParser *xmlParser = [[XMLParser alloc] init];
        [xmlParser parseXML:filePath identity:identity date:date isRemoteFile:isRemoteFile callback:^(NSMutableArray *configFileArray, BOOL isRemoteFile) {

            for (id <Config> config in configFileArray) {

                @try {
                    // 正常ファイルか判断
                    VrConfigValidator *validator = [[VrConfigValidator alloc] initWithValidationHandler:[ConfigValidationHandler new] config:config];
                    config.isNormal = ![[validator handler] errors];
                    NSLog(@"%@", config.getElements);
                    NSLog(@"%@", [[validator handler] toString]);
                    
                    // 前提：想定しているバリデーションを通して正常な設定ファイルを読み込む
                    // 想定：エラーあり
                    XCTAssertTrue( [[validator handler] errors] );
                    
                } @catch (NSException *exception) {
                    XCTAssertNoThrow(exception);
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [expectation fulfill];
            });
        }];
        
    });
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：バリデーションが行われることを確認する。異常系（引数が全てNULL）
 */
- (void)testInstansiateIsNull0 {
    
    VrConfigValidator *validator = [VrConfigValidator new];
    
    // 前提：想定しているバリデーションを通して正常な設定ファイルを読み込む
    // 想定：エラーが起きない
    XCTAssertNoThrow([validator validate]);
        
}

/**
 目的：バリデーションが行われることを確認する。異常系（引数が全てNULL）
 */
- (void)testInstansiateIsNull1 {
    
    VrConfigValidator *validator = [[VrConfigValidator alloc] initWithValidationHandler:nil config:nil];
    
    // 前提：バリデーションの初期化引数がnil
    // 想定：エラーが起きない
    XCTAssertNoThrow([validator validate]);
        
}

/**
 目的：バリデーションが行われることを確認する。異常系（config=NULL）
 */
- (void)testInstansiateIsNull2 {
    
    VrConfigValidator *validator = [[VrConfigValidator alloc] initWithValidationHandler:[ConfigValidationHandler new] config:nil];
    
    NSLog(@"%@", [[validator handler] toString]);
    
    // 前提：バリデーションの初期化の設定ファイル引数がnil
    // 想定：エラーが起きず、バリデーションエラーが正しく吐き出される
    XCTAssertNoThrow([validator validate]);
    XCTAssertTrue([[validator handler] errors]);
        
}

/**
 目的：バリデーションが行われることを確認する。異常系（handler=NULL）
 */
- (void)testInstansiateIsNull3 {
    
    NSString *filePath = [self getFilePath:@"vrTrackingConfig_validateNomal"];
    NSString *identity = @"v";
    NSString *date = @"";
    BOOL isRemoteFile = NO;
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"vrTrackingConfig_validateNomal"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {

        XMLParser *xmlParser = [[XMLParser alloc] init];
        [xmlParser parseXML:filePath identity:identity date:date isRemoteFile:isRemoteFile callback:^(NSMutableArray *configFileArray, BOOL isRemoteFile) {

            for (id <Config> config in configFileArray) {

                @try {
                    // 正常ファイルか判断
                    VrConfigValidator *validator = [[VrConfigValidator alloc] initWithValidationHandler:nil config:config];
                    config.isNormal = ![[validator handler] errors];
                    NSLog(@"%@", config.getElements);
                    NSLog(@"%@", [[validator handler] toString]);
                    
                    // 前提：バリデーションの初期化の設定ファイル引数がnil
                    // 想定：エラーが起きない
                    XCTAssertNoThrow([validator validate]);
                    
                } @catch (NSException *exception) {
                    XCTAssertNoThrow(exception);
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [expectation fulfill];
            });
        }];
        
    });
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}










#pragma mark - Util


- (NSString *)testConfigPath:(NSString *)fileName {
    NSString *configPath = [[NSBundle bundleForClass:self.class] pathForResource:fileName ofType:@"xml"];
    
    NSLog(@"Test local config file path = %@", configPath);
    return configPath;
}
- (NSString *)mainConfigPath:(NSString *)fileName {
    // Documentsディレクトリパス
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirPath = [path objectAtIndex:0];
    NSString *configPath = [[documentsDirPath stringByAppendingPathComponent:@"Remote"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml",fileName]];
    // Documents配下に設定ファイルがあるかを判定
    if ([[NSFileManager defaultManager] fileExistsAtPath:configPath] == NO) {
        configPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
    }
    
    NSLog(@"Main local config file path = %@", configPath);
    return configPath;
}

- (NSString *) getFilePath:(NSString *)fileName {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePathComponent = @"Remote";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirPath = [paths objectAtIndex:0];
    
    //    NSString *configPath = [[documentsDirPath stringByAppendingPathComponent:filePathComponent] stringByAppendingPathComponent:@"vrTrackingConfig.xml"];
    NSString *configPath = [[documentsDirPath stringByAppendingPathComponent:filePathComponent] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml",fileName]];
    
    BOOL isDeleted = [fileManager removeItemAtPath:[self mainConfigPath:fileName] error:nil];
    if (isDeleted) {
        NSLog(@"file is deleted");
    }else {
        NSLog(@"file is not deleted...");
    }
    
    if ([fileManager copyItemAtPath:[self testConfigPath:fileName] toPath:configPath error:nil]) {
        NSLog(@"Config file copy is success");
    }else {
        NSLog(@"Config file copy is miss");
    }
    return configPath;
}


@end
