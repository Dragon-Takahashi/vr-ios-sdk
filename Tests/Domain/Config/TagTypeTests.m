//
//  TagTypeTests.m
//  Tests
//
//  Created by 髙橋和成 on 1/30/21.
//  Copyright © 2021 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../../../VrInteractiveTracking/Domain/Config/TagType.h"
#import "../../../VrInteractiveTracking/Common/XMLParser.h"

@interface TagTypeTests : XCTestCase

@end

@implementation TagTypeTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

/**
 目的：VとVRをsymbolとして許容するか確認する
 */
- (void)testOf {
    
    // 前提：symbolを設定
    // 想定：定数と一致
    XCTAssertEqual([[TagType new] of:@"vr"].symbol, kVR) ;
    XCTAssertEqual([[TagType new] of:@"v"].symbol, kV) ;
}

/**
 目的：
 */
- (void)testValidateNormal {
    
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
                   
                    // 前提：Configを読み込みバリデーションをかける
                    // 想定：エラーをスルーせず、isNormalがTrueになっている
                    XCTAssertNoThrow( [[[TagType new] of:config.getTagType] validate:config handler:[ConfigValidationHandler new]]);
                    XCTAssertTrue([config isNormal]);
                    
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
