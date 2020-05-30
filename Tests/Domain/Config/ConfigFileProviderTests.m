//
//  ConfigFileProviderStubTests.m
//  Tests
//
//  Created by 髙橋和成 on 11/1/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ConfigFileProviderStub.h"

//NSString *const VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY = @"default";
//NSString *const VR_LIB_DEFAULT_FILE_NAME = @"vrTrackingConfig";

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


#pragma mark - initWithCallback:(ConfigStatusCallback) callback

///**
// 目的：初期化が正常に行われるかを確認する
// */
//- (void)testInit {
//    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
//    __block ConfigFileProviderStub *provider = nil;
//
//    @try {
//        provider = [[ConfigFileProviderStub alloc] initWithOutsideConfigURL:nil callback:^(BOOL isRunning, NSString *identity) {
//            if (!isRunning && [identity isEqualToString:@"default"]) {
//                // 前提：デフォルトのローカル設定ファイルを読み込むように初期化
//                // 想定："default"というidentityで設定ファイルが正常に取得できているか確認
//                XCTAssertTrue([[provider loadConfig:@"default"] isNormal] == true);
//
//                [expectation fulfill];
//            }
//        }];
//        [provider addConfigWithIdentity:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY fileName:VR_LIB_DEFAULT_FILE_NAME];
//    } @catch (NSException *exception) {
//        NSLog(@"%@", [exception reason]);
//        XCTFail(@"%@", [exception reason]);
//    }
//
//    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
//        XCTAssertNil(error, @"has error.");
//    }];
//
//}
//
///**
//  目的：初期化時に外部設定ファイルを指定した際でも初期化が正常に行われるかを確認する
//  */
//- (void)testInitWithOutsideConfigURL {
//    __block ConfigFileProviderStub *provider = nil;
//    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
//
//    @try {
//        // 生成
//        provider = [[ConfigFileProviderStub alloc] initWithOutsideConfigURL:@"https://linc-sdkstg.interactive-circle.jp/test/sdk_config/normalVrTrackingConfig.xml" callback:^(BOOL isRunning, NSString *identity) {
//
//            if ([identity isEqualToString:@"default"] && !isRunning) {
//                // 前提：デフォルトのローカル設定ファイルを読み込むように初期化
//                // 想定："default"というidentityで設定ファイルが正常に取得できているか確認
//                XCTAssertTrue([[provider loadConfig:@"default"] isNormal] == true);
//
//                [expectation fulfill];
//            }
//
//        }];
//        [provider addConfigWithIdentity:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY fileName:VR_LIB_DEFAULT_FILE_NAME];
//
//    } @catch (NSException *exception) {
//        NSLog(@"%@", [exception reason]);
//        XCTFail(@"%@", [exception reason]);
//    }
//
//    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
//        XCTAssertNil(error, @"has error.");
//    }];
//}
//
/////**
//// 目的：不正な設定ファイルを読み込んだ際に、エラーが吐き出されるかを検証
//// */
////- (void)testInitIrregularConfigUnderZero {
////    __block ConfigFileProviderStub *provider = nil;
////    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
////
////    @try {
////        // 生成
////        provider = [[ConfigFileProviderStub alloc] initWithOutsideConfigURL:nil callback:^(BOOL isRunning, NSString *identity) {
////            NSLog(@"identity = %@, isRunning = %@", identity, isRunning?@"YES":@"NO");
////            if ([identity isEqualToString:@"test_config"] && !isRunning) {
////
////                XCTAssertFalse([[provider loadConfig:@"test_config"] isNormal]);
////            }
////        }];
////
////        [provider addConfigWithIdentity:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY fileName:VR_LIB_DEFAULT_FILE_NAME];
////        [provider addConfigWithIdentity:@"test_config" fileName:@"TestIrregularUnderZeroVrTrackingConfig"];
////    } @catch (NSException *exception) {
////        NSLog(@"%@", [exception reason]);
////        XCTFail(@"%@", [exception reason]);
////    }
////
////    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
////        // 前提：非同期でConfigValidatorがエラーを吐く。ログには出るが、それをキャッチする方法がない。
////        // 想定：タイムアウトが起きる
////        XCTAssertNotNil(error, @"has error.");
////    }];
////
////}
//
///**
// 目的：不正な設定ファイルを読み込んだ際に、エラーが吐き出されるかを検証
// */
////- (void)testInitIrregularConfigWrongURL {
////    __block ConfigFileProviderStub *provider = nil;
////    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
////
//////    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
////        @try {
////            // 生成
////            provider = [[ConfigFileProviderStub alloc] initWithOutsideConfigURL:nil callback:^(BOOL isRunning, NSString *identity) {
////                NSLog(@"identity = %@, isRunning = %@", identity, isRunning?@"YES":@"NO");
////                if ([identity isEqualToString:@"test_config"] && !isRunning) {
////
////                    [expectation fulfill];
////                    ConfigFile *config = [provider loadConfig:@"test_config"];
////                    XCTAssertFalse(config.isNormal);
////                }
////            }];
////
////            [provider addConfigWithIdentity:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY fileName:VR_LIB_DEFAULT_FILE_NAME];
////            [provider addConfigWithIdentity:@"test_config" fileName:@"TestIrregularWrongURLVrTrackingConfig"];
////        } @catch (NSException *exception) {
////            NSLog(@"%@", [exception reason]);
////            [expectation fulfill];
////            XCTFail(@"%@", [exception reason]);
////        }
//////    });
////
////    dispatch_time_t timeout = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 5);
////    if (dispatch_semaphore_wait(sem, timeout)) {
////        // 前提：非同期でConfigValidatorがエラーを吐く。ログには出るが、それをキャッチする方法がない。
////        // 想定：タイムアウトが起きる
////    }
////}
//
///**
// 目的：不正な設定ファイルを読み込んだ際に、エラーが吐き出されるかを検証
// */
////- (void)testInitIrregularConfigOverflow {
////    __block ConfigFileProviderStub *provider = nil;
////    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
////
////    @try {
////        // 生成
////        provider = [[ConfigFileProviderStub alloc] initWithOutsideConfigURL:nil callback:^(BOOL isRunning, NSString *identity) {
////            NSLog(@"identity = %@, isRunning = %@", identity, isRunning?@"YES":@"NO");
////            if ([identity isEqualToString:@"test_config"] && !isRunning) {
////
////                XCTAssertFalse([[provider loadConfig:@"test_config"] isNormal]);
////            }
////        }];
////
////        [provider addConfigWithIdentity:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY fileName:VR_LIB_DEFAULT_FILE_NAME];
////        [provider addConfigWithIdentity:@"test_config" fileName:@"TestIrregularOverflowVrTrackingConfig"];
////    } @catch (NSException *exception) {
////        NSLog(@"%@", [exception reason]);
////        XCTFail(@"%@", [exception reason]);
////    }
////
////    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
////        // 前提：非同期でConfigValidatorがエラーを吐く。ログには出るが、それをキャッチする方法がない。
////        // 想定：タイムアウトが起きる
////        XCTAssertNotNil(error, @"has error.");
////    }];
////}
//
//
//
//#pragma mark - addConfigWithIdentity:(NSString*) identity filePath:(NSString*) filePath
//
///**
// 目的：設定ファイルが正常に追加できるか、また、取り出せるかを確認する
// */
//- (void)testAddConfigWithIdentityAndLoadConfigNormal {
//    __block ConfigFileProviderStub *provider = nil;
//    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
//
//    @try {
//        provider = [[ConfigFileProviderStub alloc] initWithOutsideConfigURL:nil callback:^(BOOL isRunning, NSString *identity) {
//            if ([identity isEqualToString:@"test_config"] && !isRunning) {
//
//                NSLog(@"testAddConfigWithIdentityValueNormal %@",[[[provider loadConfig:identity] getElements] description]);
//
//                // 前提：providerに"test_config"というidentityで設定ファイルが格納されている
//                // 想定：全ての値が正しく入っているかを確認
//                XCTAssertTrue([[provider loadConfig:identity].getVr_TagId1 isEqualToString:@"9997"] );
//                XCTAssertTrue([[provider loadConfig:identity].getVr_TagId2 isEqualToString:@"1001"]);
//                XCTAssertTrue([[provider loadConfig:identity].getMax_Que_Recs isEqualToString:@"10000"]);
//                XCTAssertNil([provider loadConfig:identity].getConfig_Url);
//                XCTAssertTrue([[provider loadConfig:identity] getDebugLog]);
//                XCTAssertFalse([[provider loadConfig:identity] getDisabled]);
//                XCTAssertTrue([[provider loadConfig:identity].getPolling isEqualToString:@"true"]);
//                XCTAssertTrue([[provider loadConfig:identity].getPolling_start isEqualToString:@"true"]);
//                XCTAssertTrue([[provider loadConfig:identity].getPolling_interval isEqualToString:@"2"]);
//                XCTAssertTrue([[provider loadConfig:identity].getConfig_timeout isEqualToString:@"5"]);
//                XCTAssertTrue([[provider loadConfig:identity].getBeacon_timeout isEqualToString:@"5"]);
//                XCTAssertTrue([[provider loadConfig:identity].getExpired_time_beacon_log isEqualToString:@"100"]);
//                XCTAssertTrue([[provider loadConfig:identity].getBeacon_url isEqualToString:@"https://panelstg.interactive-circle.jp/ver01/measure"]);
//
//                [expectation fulfill];
//            }
//        }];
//
//        // 追加
//        [provider addConfigWithIdentity:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY fileName:VR_LIB_DEFAULT_FILE_NAME];
//        [provider addConfigWithIdentity:@"test_config" fileName:@"vrTrackingConfig"];
//    } @catch (NSException *exception) {
//        NSLog(@"%@", [exception reason]);
//        XCTFail(@"%@", [exception reason]);
//    }
//
//
//    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
//        XCTAssertNil(error, @"has error.");
//    }];
//}
//
//
//#pragma mark - setConfig:(NSDictionary*) config identity:(NSString *)identity
//
///**
// 目的：読み込んだ設定ファイルに追加で上書きを正常に行えるかを確認する
// */
//- (void)testSetConfigNormal {
//    __block ConfigFileProviderStub *provider = nil;
//    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
//
//    @try {
//        // 生成
//        provider = [[ConfigFileProviderStub alloc] initWithOutsideConfigURL:nil callback:^(BOOL isRunning, NSString *identity) {
//            NSLog(@"identity = %@, isRunning = %@", identity, isRunning?@"YES":@"NO");
//            if ([identity isEqualToString:@"test_config"] && !isRunning) {
//                // 変更
//                NSMutableDictionary *dic = [[[provider loadConfig:@"test_config"] getElements] mutableCopy];
//                [dic setObject:@"1002" forKey:@"vr_tagid2"];
//                [provider setConfig:dic identity:@"test_config"];
//
//                // 前提：vr_tagid2に"1002"を新たに上書きしており、vr_tagid1には設定ファイルから"9997"が設定してある
//                // 想定：vr_tagid2に"1002"があり、vr_tagid1に"9997"が入っているかを確認
//                XCTAssertTrue([[[provider loadConfig:@"test_config"] getVr_TagId1] isEqualToString:@"9997"]);
//                XCTAssertTrue([[[provider loadConfig:@"test_config"] getVr_TagId2] isEqualToString:@"1002"]);
//
//
//                [expectation fulfill];
//            }
//        }];
//
//        [provider addConfigWithIdentity:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY fileName:VR_LIB_DEFAULT_FILE_NAME];
//        [provider addConfigWithIdentity:@"test_config" fileName:@"vrTrackingConfig"];
//    } @catch (NSException *exception) {
//        NSLog(@"%@", [exception reason]);
//        XCTFail(@"%@", [exception reason]);
//    }
//
//    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
//        XCTAssertNil(error, @"has error.");
//    }];
//}
//
///**
// 目的：読み込んだ設定ファイルにint型でも追加で上書きを正常に行えるかを確認する
// */
//- (void)testSetConfigIrregularInt {
//    __block ConfigFileProviderStub *provider = nil;
//    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
//
//    @try {
//        // 生成
//        provider = [[ConfigFileProviderStub alloc] initWithOutsideConfigURL:nil callback:^(BOOL isRunning, NSString *identity) {
//            NSLog(@"identity = %@, isRunning = %@", identity, isRunning?@"YES":@"NO");
//            if ([identity isEqualToString:@"test_config"] && !isRunning) {
//                // 変更
////                NSMutableDictionary *dic = [[[provider loadConfig:@"test_config"] getElements] mutableCopy];
//                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//                [dic setObject:@1002 forKey:@"vr_tagid2"];
//                [provider setConfig:dic identity:@"test_config"];
//
//                // 前提：vr_tagid2に"1002"を新たに上書きしており、vr_tagid1には設定ファイルから"9997"が設定してある
//                // 想定：vr_tagid2に"1002"があり、vr_tagid1に"9997"が入っているかを確認
//                XCTAssertTrue([[[provider loadConfig:@"test_config"] getVr_TagId1] isEqualToString:@"9997"]);
//                XCTAssertTrue([[[provider loadConfig:@"test_config"] getVr_TagId2] isEqualToString:@"1002"]);
//
//
//                [expectation fulfill];
//            }
//        }];
//
//        [provider addConfigWithIdentity:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY fileName:VR_LIB_DEFAULT_FILE_NAME];
//        [provider addConfigWithIdentity:@"test_config" fileName:@"vrTrackingConfig"];
//    } @catch (NSException *exception) {
//        NSLog(@"%@", [exception reason]);
//        XCTFail(@"%@", [exception reason]);
//    }
//
//    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
//        XCTAssertNil(error, @"has error.");
//    }];
//}
//
///**
// 目的：読み込んだ設定ファイルにnullを入れた場合でも、設定してあるパラメータに変化がないことを確認する
// */
//- (void)testSetConfigIrregularNull {
//    __block ConfigFileProviderStub *provider = nil;
//    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
//
//    @try {
//        // 生成
//        provider = [[ConfigFileProviderStub alloc] initWithOutsideConfigURL:nil callback:^(BOOL isRunning, NSString *identity) {
//            NSLog(@"identity = %@, isRunning = %@", identity, isRunning?@"YES":@"NO");
//            if ([identity isEqualToString:@"test_config"] && !isRunning) {
//                // 変更
//                [provider setConfig:nil identity:@"test_config"];
//
//                // 前提：vr_tagid2に"1001"が、vr_tagid1には設定ファイルから"9997"が設定してある
//                // 想定：vr_tagid2に"1001"があり、vr_tagid1に"9997"が入っているかを確認
//                XCTAssertTrue([[[provider loadConfig:@"test_config"] getVr_TagId1] isEqualToString:@"9997"]);
//                XCTAssertTrue([[[provider loadConfig:@"test_config"] getVr_TagId2] isEqualToString:@"1001"]);
//
//
//                [expectation fulfill];
//            }
//        }];
//
//        [provider addConfigWithIdentity:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY fileName:VR_LIB_DEFAULT_FILE_NAME];
//        [provider addConfigWithIdentity:@"test_config" fileName:@"vrTrackingConfig"];
//    } @catch (NSException *exception) {
//        NSLog(@"%@", [exception reason]);
//        XCTFail(@"%@", [exception reason]);
//    }
//
//    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
//        XCTAssertNil(error, @"has error.");
//    }];
//}
//
///**
// 目的：読み込んだ設定ファイルに空の辞書を入れた場合でも、設定してあるパラメータに変化がないことを確認する
// */
//- (void)testSetConfigIrregularEmpty {
//    __block ConfigFileProviderStub *provider = nil;
//    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
//
//    @try {
//        // 生成
//        provider = [[ConfigFileProviderStub alloc] initWithOutsideConfigURL:nil callback:^(BOOL isRunning, NSString *identity) {
//            NSLog(@"identity = %@, isRunning = %@", identity, isRunning?@"YES":@"NO");
//            if ([identity isEqualToString:@"test_config"] && !isRunning) {
//                // 変更
//                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//                [provider setConfig:dic identity:@"test_config"];
//
//                // 前提：vr_tagid2に"1001"が、vr_tagid1には設定ファイルから"9997"が設定してある
//                // 想定：vr_tagid2に"1001"があり、vr_tagid1に"9997"が入っているかを確認
//                XCTAssertTrue([[[provider loadConfig:@"test_config"] getVr_TagId1] isEqualToString:@"9997"]);
//                XCTAssertTrue([[[provider loadConfig:@"test_config"] getVr_TagId2] isEqualToString:@"1001"]);
//
//                [expectation fulfill];
//            }
//        }];
//
//        [provider addConfigWithIdentity:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY fileName:VR_LIB_DEFAULT_FILE_NAME];
//        [provider addConfigWithIdentity:@"test_config" fileName:@"vrTrackingConfig"];
//    } @catch (NSException *exception) {
//        NSLog(@"%@", [exception reason]);
//        XCTFail(@"%@", [exception reason]);
//    }
//
//    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
//        XCTAssertNil(error, @"has error.");
//    }];
//}
//
//
///**
// 目的：設定ファイルの上書きメソッドにおいて、vr_tagid1に空文字を入れた場合に正しくエラーが吐き出されるかを確認する
// */
//- (void)testSetConfigIrregularConfigValueEmpty {
//    __block ConfigFileProviderStub *provider = nil;
//    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
//
//    @try {
//        // 生成
//        provider = [[ConfigFileProviderStub alloc] initWithOutsideConfigURL:nil callback:^(BOOL isRunning, NSString *identity) {
//            NSLog(@"identity = %@, isRunning = %@", identity, isRunning?@"YES":@"NO");
//            if ([identity isEqualToString:@"test_config"] && !isRunning) {
//                // 変更
////                NSMutableDictionary *dic = [[[provider loadConfig:@"test_config"] getElements] mutableCopy];
//                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//                [dic setObject:@"" forKey:@"vr_tagid1"];
//                @try {
//                    [provider setConfig:dic identity:@"test_config"];
//
//                    XCTFail(@"do not throw error");
//                } @catch (NSException *exception) {
//                    NSLog(@"%@", [exception reason]);
//
//                    // 前提：vr_tagid1に空文字を新たに上書きしてる
//                    // 想定：vr_tagid1が空だという旨のエラーが吐き出されているかを確認
//                    XCTAssertTrue([[exception reason] isEqualToString:@"\nThe vr_tagid1 is empty"]);
//
//                    [expectation fulfill];
//                }
//            }
//        }];
//
//        [provider addConfigWithIdentity:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY fileName:VR_LIB_DEFAULT_FILE_NAME];
//        [provider addConfigWithIdentity:@"test_config" fileName:@"vrTrackingConfig"];
//    } @catch (NSException *exception) {
//        NSLog(@"%@", [exception reason]);
//        XCTFail(@"%@", [exception reason]);
//    }
//
//    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
//        XCTAssertNil(error, @"has error.");
//    }];
//}
//
///**
// 目的：設定ファイルの上書きメソッドにおいて、beacon_timeoutに0を入れた場合に正しくエラーが吐き出されるかを確認する
// */
//- (void)testSetConfigIrregularConfigUnderZero {
//    __block ConfigFileProviderStub *provider = nil;
//    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
//
//    @try {
//        // 生成
//        provider = [[ConfigFileProviderStub alloc] initWithOutsideConfigURL:nil callback:^(BOOL isRunning, NSString *identity) {
//            NSLog(@"identity = %@, isRunning = %@", identity, isRunning?@"YES":@"NO");
//            if ([identity isEqualToString:@"test_config"] && !isRunning) {
//                // 変更
//                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//                [dic setObject:@"0" forKey:@"beacon_timeout"];
//                @try {
//                    [provider setConfig:dic identity:@"test_config"];
//
//                    XCTFail(@"do not throw error");
//                } @catch (NSException *exception) {
//                    NSLog(@"%@", [exception reason]);
//
//                    // 前提：beacon_timeoutに0を新たに上書きしてる
//                    // 想定：beacon_timeoutが0だという旨のエラーが吐き出されているかを確認
//                    XCTAssertTrue([[exception reason] isEqualToString:@"\nThe beacon_timeout is under zero"]);
//
//                    [expectation fulfill];
//                }
//            }
//        }];
//
//        [provider addConfigWithIdentity:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY fileName:VR_LIB_DEFAULT_FILE_NAME];
//        [provider addConfigWithIdentity:@"test_config" fileName:@"vrTrackingConfig"];
//    } @catch (NSException *exception) {
//        NSLog(@"%@", [exception reason]);
//        XCTFail(@"%@", [exception reason]);
//    }
//
//    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
//        XCTAssertNil(error, @"has error.");
//    }];
//}
//
///**
// 目的：設定ファイルの上書きメソッドにおいて、beacon_urに不正なURLを入れた場合に正しくエラーが吐き出されるかを確認する
// */
//- (void)testSetConfigIrregularConfigWrongURL {
//    __block ConfigFileProviderStub *provider = nil;
//    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
//
//    @try {
//        // 生成
//        provider = [[ConfigFileProviderStub alloc] initWithOutsideConfigURL:nil callback:^(BOOL isRunning, NSString *identity) {
//            NSLog(@"identity = %@, isRunning = %@", identity, isRunning?@"YES":@"NO");
//            if ([identity isEqualToString:@"test_config"] && !isRunning) {
//                // 変更
//                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//                [dic setObject:@"ht://test.config.jp/" forKey:@"beacon_url"];
//                @try {
//                    [provider setConfig:dic identity:@"test_config"];
//
//                    XCTFail(@"do not throw error");
//                } @catch (NSException *exception) {
//                    NSLog(@"%@", [exception reason]);
//
//                    // 前提：beacon_urに不正なURLを新たに上書きしてる
//                    // 想定：beacon_urが不正なURLだという旨のエラーが吐き出されているかを確認
//                    XCTAssertTrue([[exception reason] isEqualToString:@"\nThe beacon_url is not URL"]);
//
//                    [expectation fulfill];
//                }
//            }
//        }];
//
//        [provider addConfigWithIdentity:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY fileName:VR_LIB_DEFAULT_FILE_NAME];
//        [provider addConfigWithIdentity:@"test_config" fileName:@"vrTrackingConfig"];
//    } @catch (NSException *exception) {
//        NSLog(@"%@", [exception reason]);
//        XCTFail(@"%@", [exception reason]);
//    }
//
//    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
//        XCTAssertNil(error, @"has error.");
//    }];
//}
//
///**
// 目的：設定ファイルの上書きメソッドにおいて、beacon_urに不正なURLを入れた場合に正しくエラーが吐き出されるかを確認する
// */
//- (void)testSetConfigIrregularConfigWrongURLAsyc {
//    __block ConfigFileProviderStub *provider = nil;
//    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
//
//    @try {
//        // 生成
//        provider = [[ConfigFileProviderStub alloc] initWithOutsideConfigURL:nil callback:^(BOOL isRunning, NSString *identity) {
//            NSLog(@"identity = %@, isRunning = %@", identity, isRunning?@"YES":@"NO");
//            if ([identity isEqualToString:@"test_config"] && !isRunning) {
//                // 変更
//                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//                [dic setObject:@"ht://test.config.jp/" forKey:@"beacon_url"];
//                @try {
//                    [provider setConfig:dic identity:@"test_config"];
//
//                    XCTFail(@"do not throw error");
//                } @catch (NSException *exception) {
//                    NSLog(@"%@", [exception reason]);
//
//                    // 前提：beacon_urに不正なURLを新たに上書きしてる
//                    // 想定：beacon_urが不正なURLだという旨のエラーが吐き出されているかを確認
//                    XCTAssertTrue([[exception reason] isEqualToString:@"\nThe beacon_url is not URL"]);
//
//                    [expectation fulfill];
//                }
//            }
//        }];
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            // バックグラウンドで行う処理を記述
//            NSLog(@"サブスレッドです");
//            [provider addConfigWithIdentity:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY fileName:VR_LIB_DEFAULT_FILE_NAME];
//        });
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            // バックグラウンドで行う処理を記述
//            NSLog(@"サブスレッドです");
//            [provider addConfigWithIdentity:@"test_config" fileName:@"vrTrackingConfig"];
//        });
//
//    } @catch (NSException *exception) {
//        NSLog(@"%@", [exception reason]);
//        XCTFail(@"%@", [exception reason]);
//    }
//
//    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
//        XCTAssertNil(error, @"has error.");
//    }];
//}
//
///**
// 目的：設定ファイルの上書きメソッドにおいて、beacon_timeoutにInt型の最大値を上回る値を入れた場合に正しくエラーが吐き出されるかを確認する
// */
//- (void)testSetConfigIrregularConfigOverflow {
//    __block ConfigFileProviderStub *provider = nil;
//    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
//
//    @try {
//        // 生成
//        provider = [[ConfigFileProviderStub alloc] initWithOutsideConfigURL:nil callback:^(BOOL isRunning, NSString *identity) {
//            NSLog(@"identity = %@, isRunning = %@", identity, isRunning?@"YES":@"NO");
//            if ([identity isEqualToString:@"test_config"] && !isRunning) {
//                // 変更
//                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//                [dic setObject:@"10000000000" forKey:@"beacon_timeout"];
//                @try {
//                    [provider setConfig:dic identity:@"test_config"];
//
//                    XCTFail(@"do not throw error");
//                } @catch (NSException *exception) {
//                    NSLog(@"%@", [exception reason]);
//
//                    // 前提：beacon_timeoutにInt型の最大値を上回る値を新たに上書きしてる
//                    // 想定：beacon_timeoutがオーバーフローしているという旨のエラーが吐き出されているかを確認
//                    XCTAssertTrue([[exception reason] isEqualToString:@"\nThe beacon_timeout is overflow"]);
//
//                    [expectation fulfill];
//                }
//            }
//        }];
//
//        [provider addConfigWithIdentity:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY fileName:VR_LIB_DEFAULT_FILE_NAME];
//        [provider addConfigWithIdentity:@"test_config" fileName:@"vrTrackingConfig"];
//    } @catch (NSException *exception) {
//        NSLog(@"%@", [exception reason]);
//        XCTFail(@"%@", [exception reason]);
//    }
//
//    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
//        XCTAssertNil(error, @"has error.");
//    }];
//}
//




@end
