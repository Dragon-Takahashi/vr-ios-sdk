//
//  VrInteractiveTrackingTests.m
//  Tests
//
//  Created by 髙橋和成 on 11/24/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "../../VrInteractiveTracking/VrInteractiveData.h"
#import "../../VrInteractiveTracking/VrInteractiveTracking.h"
#import "VrInteractiveTrackingStub.h"
#import "../../VrInteractiveTracking/Domain/Opt.h"

@interface VrInteractiveTrackingTests : XCTestCase

@end

@implementation VrInteractiveTrackingTests

- (void)setUp {
    [super setUp];
    [VrInteractiveTrackingStub initConfig];
    [Opt in];
}

- (void)tearDown {
    [super tearDown];
}


#pragma mark (id)initWithAppName:(NSString *)appName eventName:(NSString *)eventName monitorId:(NSString *)monitorId;

/**
 目的：初期化したインスタンスがエラーなく実行されているかを確認する
 */
- (void)testInitWithAppNameNormal {
    VrInteractiveTracking *tracking = [[VrInteractiveTracking alloc] initWithAppName:@"test_app_name" eventName:@"test_event_name" monitorId:@"test_monitor_id"];
    
    // 前提：初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
}


/**
 目的：初期化時の引数にnullを入れた場合でも、インスタンが生成されることを確認する
 */
- (void)testInitWithAppNameIrregularNull {
    VrInteractiveTracking *tracking = [[VrInteractiveTracking alloc] initWithAppName:nil eventName:nil monitorId:nil];
    
    // 前提：初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
}

/**
 目的：初期化時の引数に空文字を入れた場合でも、インスタンが生成されることを確認する
 */
- (void)testInitWithAppNameIrregularEmpty {
    VrInteractiveTracking *tracking = [[VrInteractiveTracking alloc] initWithAppName:@"" eventName:@"" monitorId:@""];
    
    // 前提：初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
}

/**
 目的：２つのインスタンが別のインスタンスであることを確認する
 */
- (void)testInitWithAppNameIrregularEquivalence {
    VrInteractiveTracking *tracking1 = [[VrInteractiveTracking alloc] initWithAppName:@"test_app_name1" eventName:@"test_event_name1" monitorId:@"test_monitor_id1"];
    VrInteractiveTracking *tracking2 = [[VrInteractiveTracking alloc] initWithAppName:@"test_app_name2" eventName:@"test_event_name2" monitorId:@"test_monitor_id2"];
    
    // 前提：２つのインスタンスが初期化が完了している
    // 想定：tracking1とtracking2が同じインスタンスではないことを確認
    XCTAssertTrue(tracking1 != tracking2);
}


#pragma mark (id)initWithTracker:(NSString *)class withAppName:(NSString *)appName withEventName:(NSString *)eventName withMonitorId:(NSString *)monitorId;

/**
 目的：初期化したインスタンスがエラーなく実行されているかを確認する
 */
- (void)testInitWithTracker1Normal {
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id"];
    
    // 前提：初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
    
}

/**
 目的：初期化時の引数にnullを入れた場合でも、インスタンが生成されることを確認する
 */
- (void)testInitWithTracker1IrregularNull {
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking = [data withClass:self withAppName:nil withEventName:nil withMonitorId:nil];
    
    // 前提：初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
}

/**
 目的：初期化時の引数に空文字を入れた場合でも、インスタンが生成されることを確認する
 */
- (void)testInitWithTracker1IrregularEmpty {
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking = [data withClass:self withAppName:@"" withEventName:@"" withMonitorId:@""];
    
    // 前提：初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
}

/**
 目的：２つのインスタンが別のインスタンスであることを確認する
 */
- (void)testInitWithTracker1IrregularEquivalence {
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking1 = [data withClass:self withAppName:@"test_app_name1" withEventName:@"test_event_name1" withMonitorId:@"test_monitor_id1"];
    VrInteractiveTracking *tracking2 = [data withClass:self withAppName:@"test_app_name2" withEventName:@"test_event_name2" withMonitorId:@"test_monitor_id2"];
    
    // 前提：２つのインスタンスが初期化が完了している
    // 想定：tracking1とtracking2が同じインスタンスではないことを確認
    XCTAssertTrue(tracking1 != tracking2);
}



#pragma mark (id)initWithTracker:(NSString *)class withAppName:(NSString *)appName withEventName:(NSString *)eventName withMonitorId:(NSString *)monitorId finishInitBlock:(FinishInitBlock)finishInitBlock;


/**
 目的：初期化したインスタンスがエラーなく実行されているかを確認する
 */
- (void)testInitWithTracker2Normal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：初期化が完了している
        // 想定：初期化コールバック結果がtrueであることを確認
        XCTAssertTrue(result);
        
        NSLog(@"test case testInitWithTracker2Normal is finished 1");
        
        [expectation fulfill];
        NSLog(@"test case testInitWithTracker2Normal is finished 2");
    }];
    
    // 前提：初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：初期化時の引数にnullを入れた場合でも、インスタンが生成されることを確認する
 */
- (void)testInitWithTracker2IrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:nil withEventName:nil withMonitorId:nil finishInitBlock:^(BOOL result) {
        
        // 前提：初期化が完了している
        // 想定：初期化コールバック結果がtrueであることを確認
        XCTAssertTrue(result);
        XCTAssertTrue(![[tracking uuId] isEqualToString:@""]);
        XCTAssertNotNil([tracking uuId]);
        
        [expectation fulfill];
    }];
    
    // 前提：初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
    
}

/**
 目的：初期化時の引数に空文字を入れた場合でも、インスタンが生成されることを確認する
 */
- (void)testInitWithTracker2IrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking = [data withClass:self withAppName:@"" withEventName:@"" withMonitorId:@"" finishInitBlock:^(BOOL result) {
        
        // 前提：初期化が完了している
        // 想定：初期化コールバック結果がtrueであることを確認
        XCTAssertTrue(result);
        
        [expectation fulfill];
    }];
    
    // 前提：初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：２つのインスタンが別のインスタンスであることを確認する
 */
- (void)testInitWithTracker2IrregularEquivalence {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking1;
    tracking1 = [data withClass:self withAppName:@"test_app_name1" withEventName:@"test_event_name1" withMonitorId:@"test_monitor_id1" finishInitBlock:^(BOOL result) {
        
        // 前提：初期化が完了している
        // 想定：初期化コールバック結果がtrueであることを確認
        XCTAssertTrue(result);
        
//        [expectation fulfill];
    }];
    __block VrInteractiveTracking *tracking2;
    tracking2 = [data withClass:self withAppName:@"test_app_name2" withEventName:@"test_event_name2" withMonitorId:@"test_monitor_id2" finishInitBlock:^(BOOL result) {
        
        // 前提：初期化が完了している
        // 想定：初期化コールバック結果がtrueであることを確認
        XCTAssertTrue(result);
        
        [expectation fulfill];
    }];
    
    // 前提：２つのインスタンスが初期化が完了している
    // 想定：tracking1とtracking2が同じインスタンスではないことを確認
    XCTAssertTrue(tracking1 != tracking2);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}




#pragma mark (id)initWithTracker:(NSString *)class withAppName:(NSString *)appName withEventName:(NSString *)eventName withMonitorId:(NSString *)monitorId withOptFlg:(BOOL)optFlg withOutsideConfigURL:(NSString *)outsideConfigURL;


/**
 目的：初期化したインスタンスがエラーなく実行されているかを確認する
 */
- (void)testInitWithTracker3Normal {
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" withOptFlg:YES withOutsideConfigURL:@"http://config.jp/"];
    
    // 前提：初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
    
}

- (void)testInitWithTracker3NormalOptflagNO {
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" withOptFlg:NO withOutsideConfigURL:@"http://config.jp/"];
    
    // 前提：初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
}

/**
 目的：初期化時の引数にnullを入れた場合でも、インスタンが生成されることを確認する
 */
- (void)testInitWithTracker3IrregularNull {
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking = [data withClass:self withAppName:nil withEventName:nil withMonitorId:nil withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提：初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
}

/**
 目的：初期化時の引数に空文字を入れた場合でも、インスタンが生成されることを確認する
 */
- (void)testInitWithTracker3IrregularEmpty {
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking = [data withClass:self withAppName:@"" withEventName:@"" withMonitorId:@"" withOptFlg:YES withOutsideConfigURL:@""];
    
    // 前提：初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
}

/**
 目的：２つのインスタンが別のインスタンスであることを確認する
 */
- (void)testInitWithTracker3IrregularEquivalence {
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking1 = [data withClass:self withAppName:@"test_app_name1" withEventName:@"test_event_name1" withMonitorId:@"test_monitor_id1" withOptFlg:YES withOutsideConfigURL:nil];
    VrInteractiveTracking *tracking2 = [data withClass:self withAppName:@"test_app_name2" withEventName:@"test_event_name2" withMonitorId:@"test_monitor_id2" withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提：２つのインスタンスが初期化が完了している
    // 想定：tracking1とtracking2が同じインスタンスではないことを確認
    XCTAssertTrue(tracking1 != tracking2);
}


- (void)testInitWithTracker3IrregularWrongURL {
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" withOptFlg:YES withOutsideConfigURL:@"ht://config.jp/"];
    
    // 前提：初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
}



#pragma mark (id)initWithTracker:(NSString *)class withAppName:(NSString *)appName withEventName:(NSString *)eventName withMonitorId:(NSString *)monitorId finishInitBlock:(FinishInitBlock)finishInitBlock withOptFlg:(BOOL)optFlg withOutsideConfigURL:(NSString *)outsideConfigURL;

/**
 目的：初期化したインスタンスがエラーなく実行されているかを確認する
 */
- (void)testInitWithTracker4Normal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：初期化が完了している
        // 想定：初期化コールバック結果がtrueであることを確認
        XCTAssertTrue(result);
        
        [expectation fulfill];
    } withOptFlg:YES withOutsideConfigURL:@"http://config.jp/"];
    
    // 前提：初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

- (void)testInitWithTracker4NormalOptflagNO {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：OptflgがNoで初期化が完了している
        // 想定：初期化コールバック結果がfalseであることを確認
        XCTAssertFalse(result);
        
        [expectation fulfill];
    } withOptFlg:NO withOutsideConfigURL:@"http://config.jp/"];
    
    // 前提：初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：初期化時の引数にnullを入れた場合でも、インスタンが生成されることを確認する
 */
- (void)testInitWithTracker4IrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    @try {
        __block VrInteractiveTracking *tracking;
        tracking = [data withClass:self withAppName:nil withEventName:nil withMonitorId:nil finishInitBlock:^(BOOL result) {
            
            // 前提：初期化が完了している
            // 想定：初期化コールバック結果がtrueであることを確認
            XCTAssertTrue(result);
            
            [expectation fulfill];
        } withOptFlg:YES withOutsideConfigURL:nil];
        
        // 前提：初期化が完了している
        // 想定：インスタンスがnilではないことを確認
        XCTAssertNotNil(tracking);
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
//        dispatch_semaphore_signal(sem);
        XCTFail(@"%@", [exception reason]);
    }

    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：初期化時の引数に空文字を入れた場合でも、インスタンが生成されることを確認する
 */
- (void)testInitWithTracker4IrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    @try {
        __block VrInteractiveTracking *tracking;
        tracking = [data withClass:@"" withAppName:@"" withEventName:@"" withMonitorId:@"" finishInitBlock:^(BOOL result) {
            
            // 前提：初期化が完了している
            // 想定：初期化コールバック結果がtrueであることを確認
            XCTAssertTrue(result);
            
            [expectation fulfill];
        } withOptFlg:YES withOutsideConfigURL:nil];
        
        // 前提：初期化が完了している
        // 想定：インスタンスがnilではないことを確認
        XCTAssertNotNil(tracking);
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
        //        dispatch_semaphore_signal(sem);
        XCTFail(@"%@", [exception reason]);
    }
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：２つのインスタンが別のインスタンスであることを確認する
 */
- (void)testInitWithTracker4IrregularEquivalence {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking1;
    tracking1 = [data withClass:self withAppName:@"test_app_name1" withEventName:@"test_event_name1" withMonitorId:@"test_monitor_id1" finishInitBlock:^(BOOL result) {
        // 前提：初期化が完了している
        // 想定：初期化コールバック結果がtrueであることを確認
        XCTAssertTrue(result);
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    __block VrInteractiveTracking *tracking2;
    tracking2 = [data withClass:self withAppName:@"test_app_name2" withEventName:@"test_event_name2" withMonitorId:@"test_monitor_id2" finishInitBlock:^(BOOL result) {
        // 前提：初期化が完了している
        // 想定：初期化コールバック結果がtrueであることを確認
        XCTAssertTrue(result);
        
        [expectation fulfill];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提：２つのインスタンスが初期化が完了している
    // 想定：tracking1とtracking2が同じインスタンスではないことを確認
    XCTAssertTrue(tracking1 != tracking2);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}



/**
 目的：不正なURLを引数に入れた場合、初期化コールバックでNOが返ってくることを確認する。
 */
- (void)testInitWithTracker4IrregularWrongURL {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：不正なURLを使用して初期化が終了している
        // 想定：不正なURLはエラーを吐き出した上で、nilに丸められるので、初期化コールバック結果がtrueであることを確認（別途エラーを吐き出している）
        XCTAssertTrue(result);
        XCTAssertNotNil(tracking);
        
        [expectation fulfill];
    } withOptFlg:YES withOutsideConfigURL:@"ht://config.jp/"];
    
    // 前提：初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：複数設定ファイルの場合、全て設定されることを確認する。
 */
- (void)testInitWithTrackerMultiSettigWithoutIdentity {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testInitWithTrackerMultiSettigWithoutIdentityEmoty"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提："test"というidentityで設定ファイルを読み込んでいる
        // 想定：エラーがスローされずに読み込めるかを確認
//        XCTAssertNoThrow([tracking loadConfig:@"test" fileName:@"vrTrackingConfigMulti"]);
        
        [tracking loadConfig:@"test1" fileName:@"vrTrackingConfigMulti" finishBlock:^(BOOL result) {

            sleep(1);
            // 前提：読み込みが完了している
            // 想定：全ての設定ファイルがnullではない
            XCTAssertTrue(result);
            XCTAssertNotNil([tracking configParams:@"default"]);
            XCTAssertNotNil([tracking configParams:@"test1"]);
            XCTAssertNotNil([tracking configParams:@"test2"]);
            
            [expectation fulfill];
        }];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
    
    
}



/**
 目的：複数設定ファイルにIdentityが含まれていない場合、Identityを除外して設定されることを確認する。
 */
- (void)testInitWithTrackerMultiSettigWithoutIdentityEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testInitWithTrackerMultiSettigWithoutIdentityEmoty"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提："test"というidentityで設定ファイルを読み込んでいる
        // 想定：エラーがスローされずに読み込めるかを確認
        XCTAssertNoThrow([tracking loadConfig:@"test" fileName:@"TestVrTrackingConfig"]);
        
        [tracking loadConfig:@"test" fileName:@"vrTrackingConfigMulti2" finishBlock:^(BOOL result) {

            // 前提：読み込みが完了している
            // 想定：Identity = test2だけがnullになっている
            XCTAssertTrue(result);
            XCTAssertNotNil([tracking configParams:@"default"]);
            XCTAssertNotNil([tracking configParams:@"test"]);
            XCTAssertNil([tracking configParams:@"test2"]);
            
            [expectation fulfill];
        }];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
    
    
}


/**
 目的：複数設定ファイルにIdentityが含まれていない場合、Identityを除外して設定されることを確認する。
 */
- (void)testInitWithTrackerMultiSettigWithoutIdentityNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testInitWithTrackerMultiSettigWithoutIdentityNull"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提："test"というidentityで設定ファイルを読み込んでいる
        // 想定：エラーがスローされずに読み込めるかを確認
        XCTAssertNoThrow([tracking loadConfig:@"test" fileName:@"TestVrTrackingConfig"]);
        
        [tracking loadConfig:@"test" fileName:@"vrTrackingConfigMulti3" finishBlock:^(BOOL result) {

            // 前提：読み込みが完了している
            // 想定：Identity = test2だけがnullになっていることを確認
            XCTAssertTrue(result);
            XCTAssertNotNil([tracking configParams:@"default"]);
            XCTAssertNotNil([tracking configParams:@"test"]);
            XCTAssertNil([tracking configParams:@"test2"]);
            
            [expectation fulfill];
        }];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
    
    
}


/**
 目的：デフォルトの設定ファイルを正しく読み込んだことを確認する（VとVR）
 */
- (void)testInitWithTrackerDefaultConfigCheck {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testInitWithTrackerDefaultConfigCheck"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        if (result) {
            // 前提：デフォルト設定ファイルを読み込んでいる
            // 想定：エラーがスローされずに読み込めるかを確認
            XCTAssertNotNil([tracking configParams:@"default"]);
            XCTAssertNotNil([tracking configParams:@"default-v"]);

            /* リモート設定ファイルの値
             <vr_tagid1>9999</vr_tagid1>
             <vr_tagid2>9997</vr_tagid2>
             <config_url/>
             <disabled>false</disabled>
             <config_timeout>5</config_timeout>
             <beacon_timeout>5</beacon_timeout>
             <beacon_url default="https://panelstg.interactive-circle.jp/sdk-test01/measure">445</beacon_url>
             */
            NSDictionary *vr = [tracking configParams:@"default"];
            NSLog(@"%@", [vr debugDescription]);
            
            NSLog(@"%@",[vr valueForKey:@"vr_tagid1"]);
            XCTAssertTrue([@"vr" isEqual:[vr valueForKey:@"tag_type"]]);
            XCTAssertTrue([@"9999" isEqual:[vr valueForKey:@"vr_tagid1"] ]);
            XCTAssertTrue([@"9997" isEqual:[vr valueForKey:@"vr_tagid2"] ]);
            XCTAssertNil([vr valueForKey:@"config_url"]);
            XCTAssertTrue([@"false" isEqual:[vr valueForKey:@"disabled"] ]);
            XCTAssertTrue([@"5" isEqual:[vr valueForKey:@"config_timeout"] ]);
            XCTAssertTrue([@"5" isEqual:[vr valueForKey:@"beacon_timeout"] ]);
            XCTAssertTrue([@"https://panelstg.interactive-circle.jp/sdk-test01/measure" isEqual:[vr objectForKey:@"beacon_url"] ]);
            
            
            /* リモート設定ファイルの値
             <tag_type>v</tag_type>
             <a>10192881</a>
             <dcos>androidtv</dcos>
             <config_url/>
             <disabled>false</disabled>
             <config_timeout>5</config_timeout>
             <beacon_timeout>5</beacon_timeout>
             <beacon_url default="https://panelstg.interactive-circle.jp/sdk-test01/measure">445</beacon_url>
             */
            NSDictionary *v = [tracking configParams:@"default-v"];
            NSLog(@"%@", [v debugDescription]);
            XCTAssertTrue([@"v" isEqual:[v valueForKey:@"tag_type"] ]);
            XCTAssertTrue([@"10192881" isEqual:[v valueForKey:@"a"] ]);
            XCTAssertTrue([@"androidtv" isEqual:[v valueForKey:@"dcos"] ]);
            XCTAssertNil([v valueForKey:@"config_url"]);
            XCTAssertTrue([@"false" isEqual:[v valueForKey:@"disabled"] ]);
            XCTAssertTrue([@"5" isEqual:[v valueForKey:@"config_timeout"] ]);
            XCTAssertTrue([@"5" isEqual:[v valueForKey:@"beacon_timeout"] ]);
            XCTAssertTrue([@"https://panelstg.interactive-circle.jp/sdk-test01/measure" isEqual:[v objectForKey:@"beacon_url"] ]);
            
            [expectation fulfill];
        }
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
    
    
}


 #pragma mark - UUID


#pragma mark (NSString*) uuId; TODO 同値性テスト、代入テスト、

/**
 目的：UUIDを取得した際に、空文字やnilではないことを確認する
 */
- (void)testUuIdNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        NSLog(@"init block is finished : %@", result?@"YES":@"NO");

        [tracking replaceUUID];
        // 前提：UUIDを初期化している
        // 想定：UUIDがnilでないことを確認
        XCTAssertNotNil([tracking uuId]);

        NSString *uuid = [tracking uuId];
        NSLog(@"uuid = %@",uuid);
        // 想定：UUIDが空文字でないことを確認
        XCTAssertFalse([uuid isEqualToString:@""]);

        [expectation fulfill];

    } withOptFlg:YES withOutsideConfigURL:nil];

    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (void) updateUUID:(NSString*) uuid;

/**
 目的：UUIDが正しく上書き出来ていることを確認する
 */
- (void)testupdateUUIDNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    @try {
        __block VrInteractiveTracking *tracking;
        tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
            
            @try {
                [tracking replaceUUID];
                [tracking updateUUID:@"test_uuid"];
                XCTAssertNotNil(tracking);
                // 前提：UUIDを"test_uuid"で上書きしている
                // 想定：UUIDが"test_uuid"であることを確認
                XCTAssertTrue([[tracking uuId] isEqualToString:@"test_uuid"]);

                [expectation fulfill];
            } @catch (NSException *exception) {

                NSLog(@"%@", [exception reason]);
                XCTFail(@"%@", [exception reason]);
            }


        } withOptFlg:YES withOutsideConfigURL:nil];
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
//        dispatch_semaphore_signal(sem);
        XCTFail(@"%@", [exception reason]);
    }


    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：UUIDが空文字でも正しく上書き出来ていることを確認する
 */
- (void)testupdateUUIDIrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {

        [tracking replaceUUID];
        [tracking updateUUID:@""];

        NSLog(@"UUID is %@",[tracking uuId]);
        // 前提：UUIDを空文字で上書きしている
        // 想定：UUIDが空文字であることを確認
        XCTAssertTrue([[tracking uuId] isEqualToString:@""]);

        [expectation fulfill];

    } withOptFlg:YES withOutsideConfigURL:nil];

    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
//
/**
 目的：UUIDにnullを上書きした際には上書きを行わないことを確認する
 */
- (void)testupdateUUIDIrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        @try {
            [tracking replaceUUID];
            [tracking updateUUID:@"test_uuid"];
            [tracking updateUUID:nil];
            // 前提：UUIDをnullで上書きしている
            // 想定：エラーを吐き出すので、UUIDが"test_uuid"のままであることを確認
            XCTAssertTrue([[tracking uuId] isEqualToString:@"test_uuid"]);

            [expectation fulfill];
        } @catch (NSException *exception) {
            NSLog(@"%@", [exception reason]);
            XCTFail(@"%@", [exception reason]);
        }

    } withOptFlg:YES withOutsideConfigURL:nil];

    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (void)replaceUUID; TODO 非同値性テスト

/**
 目的：UUIDが正しく新規生成出来ていることを確認する
 */
- (void)testreplaceUUIDNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {

        @try {

            [tracking updateUUID:@"test_uuid"];
            [tracking replaceUUID];
            XCTAssertNotNil(tracking);
            // 前提：UUIDを削除し、新規生成している
            // 想定：UUIDが"test_uuid"ではないことを確認
            XCTAssertFalse([[tracking uuId] isEqualToString:@"test_uuid"]);

            [expectation fulfill];

        } @catch (NSException *exception) {
            NSLog(@"%@", [exception reason]);
            XCTFail(@"%@", [exception reason]);
        }


    } withOptFlg:YES withOutsideConfigURL:nil];

    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];

}



 #pragma mark - VrOptValue

#pragma mark (void)clearAllVrOptValueWithAppName;

/**
 目的：設定したopt値を全てクリアできるかを確認する
 */
- (void)testClearAllVrOptValueWithAppNameNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        @try {
            XCTAssertNotNil(tracking);
            
            [tracking setVrOptValue:^(OptValues *builder) {
                builder.vr_opt1 = @"test_opt1";
                builder.vr_opt2 = @"test_opt2";
                builder.vr_opt3 = @"test_opt3";
            }];
            
            XCTAssertTrue([[tracking optValueByInteger:1] isEqualToString:@"test_opt1"]);
            XCTAssertTrue([[tracking optValueByInteger:2] isEqualToString:@"test_opt2"]);
            XCTAssertTrue([[tracking optValueByInteger:3] isEqualToString:@"test_opt3"]);
            
            [tracking clearAllVrOptValueWithAppName];
            
            // 前提：セットしたOpt値をクリアしている
            // 想定："vr_opt1"に値がnilであることを確認
            NSString *opt1 = [tracking optValueByInteger:1];
            XCTAssertTrue(opt1 == nil);
            
            [expectation fulfill];
        } @catch (NSException *exception) {
            NSLog(@"%@", [exception reason]);
            XCTFail(@"%@", [exception reason]);
        }
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：opt値のクリアを複数回呼び出してもエラーが発生しないかを確認する
 */
- (void)testClearAllVrOptValueWithAppNameIrregularStress {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        @try {
            XCTAssertNotNil(tracking);
            
            // 前提：何もない状態でOpt値をクリアしている
            // 想定：エラーが起きないことと、"vr_opt1"に値がnilであることを確認
            XCTAssertNoThrow([tracking clearAllVrOptValueWithAppName]);
            XCTAssertNoThrow([tracking clearAllVrOptValueWithAppName]);
            XCTAssertNoThrow([tracking clearAllVrOptValueWithAppName]);
            
            [expectation fulfill];
        } @catch (NSException *exception) {
            NSLog(@"%@", [exception reason]);
            XCTFail(@"%@", [exception reason]);
        }
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

#pragma mark (BOOL)setVrOptValue:(NSString *)optValue forOptId:(int)optId;

/**
 目的：opt値が正常に設定できているかを確認する
 */
- (void)testSetVrOptValueNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        @try {
            XCTAssertNotNil(tracking);
            
            for (int i = 1; i < 21; i++) {
                NSString *value = [NSString stringWithFormat:@"test_opt%d",i];
                [tracking setVrOptValue:value forOptId:i];
            }
            
            // 前提："vr_opt1"〜"vr_opt20"までを登録している
            // 想定："vr_opt1"〜"vr_opt9"が"test_opt1"〜"test_opt9"で登録されているかを確認する
            XCTAssertTrue([[tracking optValueByInteger:1] isEqualToString:@"test_opt1"]);
            XCTAssertTrue([[tracking optValueByInteger:2] isEqualToString:@"test_opt2"]);
            XCTAssertTrue([[tracking optValueByInteger:3] isEqualToString:@"test_opt3"]);
            XCTAssertTrue([[tracking optValueByInteger:4] isEqualToString:@"test_opt4"]);
            XCTAssertTrue([[tracking optValueByInteger:5] isEqualToString:@"test_opt5"]);
            XCTAssertTrue([[tracking optValueByInteger:6] isEqualToString:@"test_opt6"]);
            XCTAssertTrue([[tracking optValueByInteger:7] isEqualToString:@"test_opt7"]);
            XCTAssertTrue([[tracking optValueByInteger:8] isEqualToString:@"test_opt8"]);
            XCTAssertTrue([[tracking optValueByInteger:9] isEqualToString:@"test_opt9"]);
            
            // 想定："vr_opt1"〜"vr_opt9"はバリデーションで弾かれているため、nilのままになっているかを確認
            XCTAssertTrue([tracking optValueByInteger:10] == nil);
            XCTAssertTrue([tracking optValueByInteger:11] == nil);
            XCTAssertTrue([tracking optValueByInteger:12] == nil);
            XCTAssertTrue([tracking optValueByInteger:13] == nil);
            
            // 想定："vr_opt14"〜"vr_opt20"が"test_opt14"〜"test_opt20"で登録されているかを確認する
            XCTAssertTrue([[tracking optValueByInteger:14] isEqualToString:@"test_opt14"]);
            XCTAssertTrue([[tracking optValueByInteger:15] isEqualToString:@"test_opt15"]);
            XCTAssertTrue([[tracking optValueByInteger:16] isEqualToString:@"test_opt16"]);
            XCTAssertTrue([[tracking optValueByInteger:17] isEqualToString:@"test_opt17"]);
            XCTAssertTrue([[tracking optValueByInteger:18] isEqualToString:@"test_opt18"]);
            XCTAssertTrue([[tracking optValueByInteger:19] isEqualToString:@"test_opt19"]);
            XCTAssertTrue([[tracking optValueByInteger:20] isEqualToString:@"test_opt20"]);
            
            
            [expectation fulfill];
        } @catch (NSException *exception) {
            NSLog(@"%@", [exception reason]);
            XCTFail(@"%@", [exception reason]);
        } @finally {
        }
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：値がnullでもopt値が正常に設定できているかを確認する
 */
- (void)testSetVrOptValueIrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        @try {
            XCTAssertNotNil(tracking);
            
            for (int i = 1; i < 21; i++) {
                [tracking setVrOptValue:nil forOptId:i];
            }
            
            // 前提："vr_opt1"〜"vr_opt20"までを登録している
            // 想定："vr_opt1"〜"vr_opt9"が"test_opt1"〜"test_opt9"で登録されているかを確認する
            XCTAssertTrue([tracking optValueByInteger:1] == nil);
            XCTAssertTrue([tracking optValueByInteger:2] == nil);
            XCTAssertTrue([tracking optValueByInteger:3] == nil);
            XCTAssertTrue([tracking optValueByInteger:4] == nil);
            XCTAssertTrue([tracking optValueByInteger:5] == nil);
            XCTAssertTrue([tracking optValueByInteger:6] == nil);
            XCTAssertTrue([tracking optValueByInteger:7] == nil);
            XCTAssertTrue([tracking optValueByInteger:8] == nil);
            XCTAssertTrue([tracking optValueByInteger:9] == nil);
            
            // 想定："vr_opt1"〜"vr_opt9"はバリデーションで弾かれているため、nilのままになっているかを確認
            XCTAssertTrue([tracking optValueByInteger:10] == nil);
            XCTAssertTrue([tracking optValueByInteger:11] == nil);
            XCTAssertTrue([tracking optValueByInteger:12] == nil);
            XCTAssertTrue([tracking optValueByInteger:13] == nil);
            
            // 想定："vr_opt14"〜"vr_opt20"が"test_opt14"〜"test_opt20"で登録されているかを確認する
            XCTAssertTrue([tracking optValueByInteger:14] == nil);
            XCTAssertTrue([tracking optValueByInteger:15] == nil);
            XCTAssertTrue([tracking optValueByInteger:16] == nil);
            XCTAssertTrue([tracking optValueByInteger:17] == nil);
            XCTAssertTrue([tracking optValueByInteger:18] == nil);
            XCTAssertTrue([tracking optValueByInteger:19] == nil);
            XCTAssertTrue([tracking optValueByInteger:20] == nil);
            
            [expectation fulfill];
        } @catch (NSException *exception) {
            NSLog(@"%@", [exception reason]);
            XCTFail(@"%@", [exception reason]);
        } @finally {
        }
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：値が空文字でもopt値が正常に設定できているかを確認する
 */
- (void)testSetVrOptValueIrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        @try {
            XCTAssertNotNil(tracking);
            
            for (int i = 1; i < 21; i++) {
                [tracking setVrOptValue:@"" forOptId:i];
            }
            
            // 前提："vr_opt1"〜"vr_opt20"までを登録している
            // 想定："vr_opt1"〜"vr_opt9"が"test_opt1"〜"test_opt9"で登録されているかを確認する
            XCTAssertTrue([[tracking optValueByInteger:1] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:2] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:3] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:4] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:5] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:6] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:7] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:8] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:9] isEqualToString:@""]);
            
            // 想定："vr_opt1"〜"vr_opt9"はバリデーションで弾かれているため、nilのままになっているかを確認
            XCTAssertTrue([tracking optValueByInteger:10] == nil);
            XCTAssertTrue([tracking optValueByInteger:11] == nil);
            XCTAssertTrue([tracking optValueByInteger:12] == nil);
            XCTAssertTrue([tracking optValueByInteger:13] == nil);
            
            // 想定："vr_opt14"〜"vr_opt20"が"test_opt14"〜"test_opt20"で登録されているかを確認する
            XCTAssertTrue([[tracking optValueByInteger:14] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:15] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:16] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:17] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:18] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:19] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:20] isEqualToString:@""]);
            
            
            
            [tracking clearAllVrOptValueWithAppName];
            
            // 前提：セットしたOpt値をクリアしている
            // 想定："vr_opt1"に値がnilであることを確認
            NSString *opt1 = [tracking optValueByInteger:1];
            XCTAssertTrue(opt1 == nil);
            
            [expectation fulfill];
        } @catch (NSException *exception) {
            NSLog(@"%@", [exception reason]);
            XCTFail(@"%@", [exception reason]);
        } @finally {
        }
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：opt値のバリデーションが正常に機能しているかを確認する
 */
- (void)testSetVrOptValueIrregularBoundary {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        @try {
            XCTAssertNotNil(tracking);
            
            for (int i = 0; i < 22; i++) {
                NSString *value = [NSString stringWithFormat:@"test_opt%d",i];
                [tracking setVrOptValue:value forOptId:i];
            }
            
            // 前提："vr_opt0"〜"vr_opt21"までを登録している
            // 想定："vr_opt0"はバリデーションで弾かれているため、nilのままになっているかを確認
            XCTAssertTrue([tracking optValueByInteger:0] == nil);
            
            // 想定："vr_opt1"〜"vr_opt9"が"test_opt1"〜"test_opt9"で登録されているかを確認する
            XCTAssertTrue([[tracking optValueByInteger:1] isEqualToString:@"test_opt1"]);
            XCTAssertTrue([[tracking optValueByInteger:2] isEqualToString:@"test_opt2"]);
            XCTAssertTrue([[tracking optValueByInteger:9] isEqualToString:@"test_opt9"]);
            
            // 想定："vr_opt1"〜"vr_opt9"はバリデーションで弾かれているため、nilのままになっているかを確認
            XCTAssertTrue([tracking optValueByInteger:10] == nil);
            XCTAssertTrue([tracking optValueByInteger:11] == nil);
            XCTAssertTrue([tracking optValueByInteger:12] == nil);
            XCTAssertTrue([tracking optValueByInteger:13] == nil);
            
            // 想定："vr_opt14"〜"vr_opt20"が"test_opt14"〜"test_opt20"で登録されているかを確認する
            XCTAssertTrue([[tracking optValueByInteger:14] isEqualToString:@"test_opt14"]);
            XCTAssertTrue([[tracking optValueByInteger:15] isEqualToString:@"test_opt15"]);
            XCTAssertTrue([[tracking optValueByInteger:19] isEqualToString:@"test_opt19"]);
            XCTAssertTrue([[tracking optValueByInteger:20] isEqualToString:@"test_opt20"]);
            
            
            // 想定："vr_opt21"はバリデーションで弾かれているため、nilのままになっているかを確認
            XCTAssertTrue([tracking optValueByInteger:21] == nil);
            
            [tracking clearAllVrOptValueWithAppName];
            
            // 前提：セットしたOpt値をクリアしている
            // 想定："vr_opt1"に値がnilであることを確認
            NSString *opt1 = [tracking optValueByInteger:1];
            XCTAssertTrue(opt1 == nil);
            
            [expectation fulfill];
        } @catch (NSException *exception) {
            NSLog(@"%@", [exception reason]);
            XCTFail(@"%@", [exception reason]);
        } @finally {
        }
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (void)setVrOptValue:(void (^)(OptValues *)) builder;

/**
 目的：ビルダーを使用したvrOptのセッターで正しく値が設定出来ているかを確認する
 */
- (void)testSetVrOptValueBuildNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        @try {
            XCTAssertNotNil(tracking);
            
            
            [tracking setVrOptValue:^(OptValues *builder) {
                builder.vr_opt1 = @"test_opt1";
                builder.vr_opt2 = @"test_opt2";
                builder.vr_opt3 = @"test_opt3";
                builder.vr_opt4 = @"test_opt4";
                builder.vr_opt5 = @"test_opt5";
                builder.vr_opt6 = @"test_opt6";
                builder.vr_opt7 = @"test_opt7";
                builder.vr_opt8 = @"test_opt8";
                builder.vr_opt9 = @"test_opt9";
                builder.vr_opt14 = @"test_opt14";
                builder.vr_opt15 = @"test_opt15";
                builder.vr_opt16 = @"test_opt16";
                builder.vr_opt17 = @"test_opt17";
                builder.vr_opt18 = @"test_opt18";
                builder.vr_opt19 = @"test_opt19";
                builder.vr_opt20 = @"test_opt20";
            }];
            
            // 前提："vr_opt0"〜"vr_opt21"までを登録している
            // 想定："vr_opt1"〜"vr_opt9"が"test_opt1"〜"test_opt9"で登録されているかを確認する
            XCTAssertTrue([[tracking optValueByInteger:1] isEqualToString:@"test_opt1"]);
            XCTAssertTrue([[tracking optValueByInteger:2] isEqualToString:@"test_opt2"]);
            XCTAssertTrue([[tracking optValueByInteger:3] isEqualToString:@"test_opt3"]);
            XCTAssertTrue([[tracking optValueByInteger:4] isEqualToString:@"test_opt4"]);
            XCTAssertTrue([[tracking optValueByInteger:5] isEqualToString:@"test_opt5"]);
            XCTAssertTrue([[tracking optValueByInteger:6] isEqualToString:@"test_opt6"]);
            XCTAssertTrue([[tracking optValueByInteger:7] isEqualToString:@"test_opt7"]);
            XCTAssertTrue([[tracking optValueByInteger:8] isEqualToString:@"test_opt8"]);
            XCTAssertTrue([[tracking optValueByInteger:9] isEqualToString:@"test_opt9"]);
            
            
            // 想定："vr_opt14"〜"vr_opt20"が"test_opt14"〜"test_opt20"で登録されているかを確認する
            XCTAssertTrue([[tracking optValueByInteger:14] isEqualToString:@"test_opt14"]);
            XCTAssertTrue([[tracking optValueByInteger:15] isEqualToString:@"test_opt15"]);
            XCTAssertTrue([[tracking optValueByInteger:16] isEqualToString:@"test_opt16"]);
            XCTAssertTrue([[tracking optValueByInteger:17] isEqualToString:@"test_opt17"]);
            XCTAssertTrue([[tracking optValueByInteger:18] isEqualToString:@"test_opt18"]);
            XCTAssertTrue([[tracking optValueByInteger:19] isEqualToString:@"test_opt19"]);
            XCTAssertTrue([[tracking optValueByInteger:20] isEqualToString:@"test_opt20"]);
            
            [expectation fulfill];
        } @catch (NSException *exception) {
            NSLog(@"%@", [exception reason]);
            XCTFail(@"%@", [exception reason]);
        }
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：ビルダーを使用したvrOptのセッターで、空文字を設定した場合でも正しく値が設定出来ているかを確認する
 */
- (void)testSetVrOptValueBuildIrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        @try {
            XCTAssertNotNil(tracking);
            
            
            [tracking setVrOptValue:^(OptValues *builder) {
                builder.vr_opt1 = @"";
                builder.vr_opt2 = @"";
                builder.vr_opt3 = @"";
                builder.vr_opt4 = @"";
                builder.vr_opt5 = @"";
                builder.vr_opt6 = @"";
                builder.vr_opt7 = @"";
                builder.vr_opt8 = @"";
                builder.vr_opt9 = @"";
                builder.vr_opt14 = @"";
                builder.vr_opt15 = @"";
                builder.vr_opt16 = @"";
                builder.vr_opt17 = @"";
                builder.vr_opt18 = @"";
                builder.vr_opt19 = @"";
                builder.vr_opt20 = @"";
            }];
            
            // 前提："vr_opt0"〜"vr_opt21"まで空文字を登録している
            // 想定："vr_opt1"〜"vr_opt9"が"test_opt1"〜"test_opt9"で登録されているかを確認する
            XCTAssertTrue([[tracking optValueByInteger:1] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:2] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:3] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:4] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:5] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:6] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:7] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:8] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:9] isEqualToString:@""]);
            
            
            // 想定："vr_opt14"〜"vr_opt20"が"test_opt14"〜"test_opt20"で登録されているかを確認する
            XCTAssertTrue([[tracking optValueByInteger:14] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:15] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:16] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:17] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:18] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:19] isEqualToString:@""]);
            XCTAssertTrue([[tracking optValueByInteger:20] isEqualToString:@""]);
            
            [expectation fulfill];
        } @catch (NSException *exception) {
            NSLog(@"%@", [exception reason]);
            XCTFail(@"%@", [exception reason]);
        }
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：ビルダーを使用したvrOptのセッターで、空文字を設定した場合でも正しく値が設定出来ているかを確認する
 */
- (void)testSetVrOptValueBuildIrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        @try {
            XCTAssertNotNil(tracking);
            
            
            [tracking setVrOptValue:^(OptValues *builder) {
                builder.vr_opt1 = nil;
                builder.vr_opt2 = nil;
                builder.vr_opt3 = nil;
                builder.vr_opt4 = nil;
                builder.vr_opt5 = nil;
                builder.vr_opt6 = nil;
                builder.vr_opt7 = nil;
                builder.vr_opt8 = nil;
                builder.vr_opt9 = nil;
                builder.vr_opt14 = nil;
                builder.vr_opt15 = nil;
                builder.vr_opt16 = nil;
                builder.vr_opt17 = nil;
                builder.vr_opt18 = nil;
                builder.vr_opt19 = nil;
                builder.vr_opt20 = nil;
            }];
            
            // 前提："vr_opt0"〜"vr_opt21"まで空文字を登録している
            // 想定："vr_opt1"〜"vr_opt9"が"test_opt1"〜"test_opt9"で登録されているかを確認する
            XCTAssertTrue([tracking optValueByInteger:1] == nil);
            XCTAssertTrue([tracking optValueByInteger:2] == nil);
            XCTAssertTrue([tracking optValueByInteger:3] == nil);
            XCTAssertTrue([tracking optValueByInteger:4] == nil);
            XCTAssertTrue([tracking optValueByInteger:5] == nil);
            XCTAssertTrue([tracking optValueByInteger:6] == nil);
            XCTAssertTrue([tracking optValueByInteger:7] == nil);
            XCTAssertTrue([tracking optValueByInteger:8] == nil);
            XCTAssertTrue([tracking optValueByInteger:9] == nil);
            
            
            // 想定："vr_opt14"〜"vr_opt20"が"test_opt14"〜"test_opt20"で登録されているかを確認する
            XCTAssertTrue([tracking optValueByInteger:14] == nil);
            XCTAssertTrue([tracking optValueByInteger:15] == nil);
            XCTAssertTrue([tracking optValueByInteger:16] == nil);
            XCTAssertTrue([tracking optValueByInteger:17] == nil);
            XCTAssertTrue([tracking optValueByInteger:18] == nil);
            XCTAssertTrue([tracking optValueByInteger:19] == nil);
            XCTAssertTrue([tracking optValueByInteger:20] == nil);
            
            [expectation fulfill];
        } @catch (NSException *exception) {
            NSLog(@"%@", [exception reason]);
            XCTFail(@"%@", [exception reason]);
        }
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

#pragma mark (NSString *)optValueByInteger:(int)optId;

/**
 目的：0以下の値を引数に指定した場合でもエラーを吐かずにnilを返すことを確認する
 */
- (void)testOptValueByIntegerIrregularMinus {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        @try {
            XCTAssertNotNil(tracking);
            
            [tracking setVrOptValue:^(OptValues *builder) {
                builder.vr_opt1 = @"test_opt1";
                builder.vr_opt2 = @"test_opt2";
                builder.vr_opt3 = @"test_opt3";
                builder.vr_opt4 = @"test_opt4";
                builder.vr_opt5 = @"test_opt5";
                builder.vr_opt6 = @"test_opt6";
                builder.vr_opt7 = @"test_opt7";
                builder.vr_opt8 = @"test_opt8";
                builder.vr_opt9 = @"test_opt9";
                builder.vr_opt14 = @"test_opt14";
                builder.vr_opt15 = @"test_opt15";
                builder.vr_opt16 = @"test_opt16";
                builder.vr_opt17 = @"test_opt17";
                builder.vr_opt18 = @"test_opt18";
                builder.vr_opt19 = @"test_opt19";
                builder.vr_opt20 = @"test_opt20";
            }];
            
            // 前提："vr_opt0"〜"vr_opt21"までを登録している
            // 想定：マイナスの値を引数に指定した場合、nilを返すか確認
            XCTAssertTrue([tracking optValueByInteger:-1] == nil);
            
            [expectation fulfill];
        } @catch (NSException *exception) {
            NSLog(@"%@", [exception reason]);
            XCTFail(@"%@", [exception reason]);
        }
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：想定している値以上の数字を引数に指定した場合でもエラーを吐かずにnilを返すことを確認する
 */
- (void)testOptValueByIntegerIrregularHundred {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        @try {
            XCTAssertNotNil(tracking);
            
            [tracking setVrOptValue:^(OptValues *builder) {
                builder.vr_opt1 = @"test_opt1";
                builder.vr_opt2 = @"test_opt2";
                builder.vr_opt3 = @"test_opt3";
                builder.vr_opt4 = @"test_opt4";
                builder.vr_opt5 = @"test_opt5";
                builder.vr_opt6 = @"test_opt6";
                builder.vr_opt7 = @"test_opt7";
                builder.vr_opt8 = @"test_opt8";
                builder.vr_opt9 = @"test_opt9";
                builder.vr_opt14 = @"test_opt14";
                builder.vr_opt15 = @"test_opt15";
                builder.vr_opt16 = @"test_opt16";
                builder.vr_opt17 = @"test_opt17";
                builder.vr_opt18 = @"test_opt18";
                builder.vr_opt19 = @"test_opt19";
                builder.vr_opt20 = @"test_opt20";
            }];
            
            // 前提："vr_opt0"〜"vr_opt21"までを登録している
            // 想定：100を引数に指定した場合、nilを返すか確認
            XCTAssertTrue([tracking optValueByInteger:100] == nil);
            
            [expectation fulfill];
        } @catch (NSException *exception) {
            NSLog(@"%@", [exception reason]);
            XCTFail(@"%@", [exception reason]);
        }
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (NSString *)optValueByString:(NSString *)optValue;
// TODO nil, 空文字,

/**
 目的：nullを引数に指定した場合でもエラーを吐かずにnilを返すことを確認する
 */
- (void)testOptValueByStringIrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        @try {
            XCTAssertNotNil(tracking);
            
            [tracking setVrOptValue:^(OptValues *builder) {
                builder.vr_opt1 = @"test_opt1";
                builder.vr_opt2 = @"test_opt2";
                builder.vr_opt3 = @"test_opt3";
                builder.vr_opt4 = @"test_opt4";
                builder.vr_opt5 = @"test_opt5";
                builder.vr_opt6 = @"test_opt6";
                builder.vr_opt7 = @"test_opt7";
                builder.vr_opt8 = @"test_opt8";
                builder.vr_opt9 = @"test_opt9";
                builder.vr_opt14 = @"test_opt14";
                builder.vr_opt15 = @"test_opt15";
                builder.vr_opt16 = @"test_opt16";
                builder.vr_opt17 = @"test_opt17";
                builder.vr_opt18 = @"test_opt18";
                builder.vr_opt19 = @"test_opt19";
                builder.vr_opt20 = @"test_opt20";
            }];
            
            // 前提："vr_opt0"〜"vr_opt21"までを登録している
            // 想定：nilを引数に指定した場合、nilを返すか確認
            XCTAssertTrue([tracking optValueByString:nil] == nil);
            
            [expectation fulfill];
        } @catch (NSException *exception) {
            NSLog(@"%@", [exception reason]);
            XCTFail(@"%@", [exception reason]);
        }
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：空文字を引数に指定した場合でもエラーを吐かずにnilを返すことを確認する
 */
- (void)testOptValueByStringIrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        @try {
            XCTAssertNotNil(tracking);
            
            [tracking setVrOptValue:^(OptValues *builder) {
                builder.vr_opt1 = @"test_opt1";
                builder.vr_opt2 = @"test_opt2";
                builder.vr_opt3 = @"test_opt3";
                builder.vr_opt4 = @"test_opt4";
                builder.vr_opt5 = @"test_opt5";
                builder.vr_opt6 = @"test_opt6";
                builder.vr_opt7 = @"test_opt7";
                builder.vr_opt8 = @"test_opt8";
                builder.vr_opt9 = @"test_opt9";
                builder.vr_opt14 = @"test_opt14";
                builder.vr_opt15 = @"test_opt15";
                builder.vr_opt16 = @"test_opt16";
                builder.vr_opt17 = @"test_opt17";
                builder.vr_opt18 = @"test_opt18";
                builder.vr_opt19 = @"test_opt19";
                builder.vr_opt20 = @"test_opt20";
            }];
            
            // 前提："vr_opt0"〜"vr_opt21"までを登録している
            // 想定：空文字を引数に指定した場合、nilを返すか確認
            XCTAssertTrue([tracking optValueByString:@""] == nil);
            
            [expectation fulfill];
        } @catch (NSException *exception) {
            NSLog(@"%@", [exception reason]);
            XCTFail(@"%@", [exception reason]);
        }
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (void)clearAllVValue;

/**
 目的：設定した拡張フィールドがクリアされるか確認する
 */
- (void)testClearAllVValueNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testClearAllVValueNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        if (result) {
            
            [tracking setVValue:^(VValues *builder) {
                builder.c = @"c";
            }];
            
            [tracking clearAllVValue:@"test"];
            
            // 前提：拡張フィールドを設定している
            // 想定：拡張フィールドが全てnilになっている
            XCTAssertNil([tracking getVValue:@"c"]);
            
            [expectation fulfill];
        }
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：設定した拡張フィールドがクリアされるか確認する（空文字）
 */
- (void)testClearAllVValueEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testClearAllVValueEmpty"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        if (result) {
            
            [tracking setVValue:^(VValues *builder) {
                builder.c = @"c";
            }];
            
            [tracking clearAllVValue:@""];
            
            // 前提：拡張フィールドを設定している
            // 想定：拡張フィールドが全てnilになっている
            XCTAssertNil([tracking getVValue:@"c"]);
            
            [expectation fulfill];
        }
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：設定した拡張フィールドがクリアされるか確認する（nil）
 */
- (void)testClearAllVValueNil {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testClearAllVValueNil"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        if (result) {
            
            [tracking setVValue:^(VValues *builder) {
                builder.c = @"c";
            }];
            
            [tracking clearAllVValue:nil];
            
            // 前提：拡張フィールドを設定している
            // 想定：拡張フィールドが全てnilになっている
            XCTAssertNil([tracking getVValue:@"c"]);
            
            [expectation fulfill];
        }
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (void)setVValue:(void (^)(VValues *))vValues;
#pragma mark (NSString *)getVValue:(NSString *)fieldName;

/**
 目的：設定した拡張フィールドが取得できるか確認する
 */
- (void)testSetVValueAndGetVValueNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSetVValueAndGetVValueNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        if (result) {
            
            [tracking setVValue:^(VValues *builder) {
                builder.c = @"c";
                builder.r = @"r";
                builder.t = @"t";
                builder.appid = @"appid";
                builder.dcid = @"dcid";
                builder.dnt = @"dnt";
                builder.dctype = @"dctype";
                builder.ref = @"ref";
                builder.url = @"url";
                builder.pf = @"pf";
                builder.pcf = @"pcf";
                builder.pcs = @"pcs";
                builder.pct = @"pct";
                builder.etime = @"etime";
                builder.event = @"event";
                builder.player = @"player";
                builder.ad = @"ad";
                builder.roll = @"roll";
                builder.pod = @"pod";
                builder.adev = @"adev";
                builder.metrics = @"metrics";
                builder.senderid = @"senderid";
                builder.senderuuid = @"senderuuid";
                builder.snederdcos = @"snederdcos";
                builder.speed = @"speed";
                builder.screen = @"screen";
                builder.p = @"p";
                builder.appver = @"appver";
                builder.projectid = @"projectid";
                builder.snsflg = @"snsflg";
                builder.u1 = @"u1";
                builder.u2 = @"u2";
                builder.u3 = @"u3";
                builder.u4 = @"u4";
                builder.u5 = @"u5";
                builder.u6 = @"u6";
                builder.u7 = @"u7";
                builder.u8 = @"u8";
                builder.u9 = @"u9";
                builder.ptag = @"ptag";
                builder.hci = @"hci";
                builder.hca = @"hca";
                builder.hce = @"hce";
                builder.hpc = @"hpc";
                builder.hcr = @"hcr";
                builder.hld = @"hld";
            }];
            
            NSLog(@"%@",[tracking getVValue:@"c"]);
            
            // 前提：拡張フィールドを設定している
            // 想定：全ての変数に変数名が入っている
            XCTAssertEqual([tracking getVValue:@"c"], @"c");
            XCTAssertEqual([tracking getVValue:@"r"], @"r");
            XCTAssertEqual([tracking getVValue:@"t"], @"t");
            XCTAssertEqual([tracking getVValue:@"appid"], @"appid");
            XCTAssertEqual([tracking getVValue:@"dcid"], @"dcid");
            XCTAssertEqual([tracking getVValue:@"dnt"], @"dnt");
            XCTAssertEqual([tracking getVValue:@"dctype"], @"dctype");
            XCTAssertEqual([tracking getVValue:@"ref"], @"ref");
            XCTAssertEqual([tracking getVValue:@"url"], @"url");
            XCTAssertEqual([tracking getVValue:@"pf"], @"pf");
            XCTAssertEqual([tracking getVValue:@"pcf"], @"pcf");
            XCTAssertEqual([tracking getVValue:@"pcs"], @"pcs");
            XCTAssertEqual([tracking getVValue:@"pct"], @"pct");
            XCTAssertEqual([tracking getVValue:@"etime"], @"etime");
            XCTAssertEqual([tracking getVValue:@"event"], @"event");
            XCTAssertEqual([tracking getVValue:@"player"], @"player");
            XCTAssertEqual([tracking getVValue:@"ad"], @"ad");
            XCTAssertEqual([tracking getVValue:@"roll"], @"roll");
            XCTAssertEqual([tracking getVValue:@"pod"], @"pod");
            XCTAssertEqual([tracking getVValue:@"adev"], @"adev");
            XCTAssertEqual([tracking getVValue:@"metrics"], @"metrics");
            XCTAssertEqual([tracking getVValue:@"senderid"], @"senderid");
            XCTAssertEqual([tracking getVValue:@"senderuuid"], @"senderuuid");
            XCTAssertEqual([tracking getVValue:@"snederdcos"], @"snederdcos");
            XCTAssertEqual([tracking getVValue:@"speed"], @"speed");
            XCTAssertEqual([tracking getVValue:@"screen"], @"screen");
            XCTAssertEqual([tracking getVValue:@"p"], @"p");
            XCTAssertEqual([tracking getVValue:@"appver"], @"appver");
            XCTAssertEqual([tracking getVValue:@"projectid"], @"projectid");
            XCTAssertEqual([tracking getVValue:@"snsflg"], @"snsflg");
            XCTAssertEqual([tracking getVValue:@"u1"], @"u1");
            XCTAssertEqual([tracking getVValue:@"u2"], @"u2");
            XCTAssertEqual([tracking getVValue:@"u3"], @"u3");
            XCTAssertEqual([tracking getVValue:@"u4"], @"u4");
            XCTAssertEqual([tracking getVValue:@"u5"], @"u5");
            XCTAssertEqual([tracking getVValue:@"u6"], @"u6");
            XCTAssertEqual([tracking getVValue:@"u7"], @"u7");
            XCTAssertEqual([tracking getVValue:@"u8"], @"u8");
            XCTAssertEqual([tracking getVValue:@"u9"], @"u9");
            XCTAssertEqual([tracking getVValue:@"ptag"], @"ptag");
            XCTAssertEqual([tracking getVValue:@"hci"], @"hci");
            XCTAssertEqual([tracking getVValue:@"hca"], @"hca");
            XCTAssertEqual([tracking getVValue:@"hce"], @"hce");
            XCTAssertEqual([tracking getVValue:@"hpc"], @"hpc");
            XCTAssertEqual([tracking getVValue:@"hcr"], @"hcr");
            XCTAssertEqual([tracking getVValue:@"hld"], @"hld");
            
            [expectation fulfill];
        }
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：設定した拡張フィールドが取得できるか確認する（空文字）
 */
- (void)testSetVValueAndGetVValueEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSetVValueAndGetVValueEmpty"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        if (result) {
            
            [tracking setVValue:^(VValues *builder) {
                builder.c = @"";
                builder.r = @"";
                builder.t = @"";
                builder.appid = @"";
                builder.dcid = @"";
                builder.dnt = @"";
                builder.dctype = @"";
                builder.ref = @"";
                builder.url = @"";
                builder.pf = @"";
                builder.pcf = @"";
                builder.pcs = @"";
                builder.pct = @"";
                builder.etime = @"";
                builder.event = @"";
                builder.player = @"";
                builder.ad = @"";
                builder.roll = @"";
                builder.pod = @"";
                builder.adev = @"";
                builder.metrics = @"";
                builder.senderid = @"";
                builder.senderuuid = @"";
                builder.snederdcos = @"";
                builder.speed = @"";
                builder.screen = @"";
                builder.p = @"";
                builder.appver = @"";
                builder.projectid = @"";
                builder.snsflg = @"";
                builder.u1 = @"";
                builder.u2 = @"";
                builder.u3 = @"";
                builder.u4 = @"";
                builder.u5 = @"";
                builder.u6 = @"";
                builder.u7 = @"";
                builder.u8 = @"";
                builder.u9 = @"";
                builder.ptag = @"";
                builder.hci = @"";
                builder.hca = @"";
                builder.hce = @"";
                builder.hpc = @"";
                builder.hcr = @"";
                builder.hld = @"";
            }];
            
            NSLog(@"%@",[tracking getVValue:@"c"]);
            
            // 前提：拡張フィールドを空文字で設定している
            // 想定：全ての変数に空文字が入っている
            XCTAssertEqual([tracking getVValue:@"c"], @"");
            XCTAssertEqual([tracking getVValue:@"r"], @"");
            XCTAssertEqual([tracking getVValue:@"t"], @"");
            XCTAssertEqual([tracking getVValue:@"appid"], @"");
            XCTAssertEqual([tracking getVValue:@"dcid"], @"");
            XCTAssertEqual([tracking getVValue:@"dnt"], @"");
            XCTAssertEqual([tracking getVValue:@"dctype"], @"");
            XCTAssertEqual([tracking getVValue:@"ref"], @"");
            XCTAssertEqual([tracking getVValue:@"url"], @"");
            XCTAssertEqual([tracking getVValue:@"pf"], @"");
            XCTAssertEqual([tracking getVValue:@"pcf"], @"");
            XCTAssertEqual([tracking getVValue:@"pcs"], @"");
            XCTAssertEqual([tracking getVValue:@"pct"], @"");
            XCTAssertEqual([tracking getVValue:@"etime"], @"");
            XCTAssertEqual([tracking getVValue:@"event"], @"");
            XCTAssertEqual([tracking getVValue:@"player"], @"");
            XCTAssertEqual([tracking getVValue:@"ad"], @"");
            XCTAssertEqual([tracking getVValue:@"roll"], @"");
            XCTAssertEqual([tracking getVValue:@"pod"], @"");
            XCTAssertEqual([tracking getVValue:@"adev"], @"");
            XCTAssertEqual([tracking getVValue:@"metrics"], @"");
            XCTAssertEqual([tracking getVValue:@"senderid"], @"");
            XCTAssertEqual([tracking getVValue:@"senderuuid"], @"");
            XCTAssertEqual([tracking getVValue:@"snederdcos"], @"");
            XCTAssertEqual([tracking getVValue:@"speed"], @"");
            XCTAssertEqual([tracking getVValue:@"screen"], @"");
            XCTAssertEqual([tracking getVValue:@"p"], @"");
            XCTAssertEqual([tracking getVValue:@"appver"], @"");
            XCTAssertEqual([tracking getVValue:@"projectid"], @"");
            XCTAssertEqual([tracking getVValue:@"snsflg"], @"");
            XCTAssertEqual([tracking getVValue:@"u1"], @"");
            XCTAssertEqual([tracking getVValue:@"u2"], @"");
            XCTAssertEqual([tracking getVValue:@"u3"], @"");
            XCTAssertEqual([tracking getVValue:@"u4"], @"");
            XCTAssertEqual([tracking getVValue:@"u5"], @"");
            XCTAssertEqual([tracking getVValue:@"u6"], @"");
            XCTAssertEqual([tracking getVValue:@"u7"], @"");
            XCTAssertEqual([tracking getVValue:@"u8"], @"");
            XCTAssertEqual([tracking getVValue:@"u9"], @"");
            XCTAssertEqual([tracking getVValue:@"ptag"], @"");
            XCTAssertEqual([tracking getVValue:@"hci"], @"");
            XCTAssertEqual([tracking getVValue:@"hca"], @"");
            XCTAssertEqual([tracking getVValue:@"hce"], @"");
            XCTAssertEqual([tracking getVValue:@"hpc"], @"");
            XCTAssertEqual([tracking getVValue:@"hcr"], @"");
            XCTAssertEqual([tracking getVValue:@"hld"], @"");
            
            [expectation fulfill];
        }
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：設定した拡張フィールドが取得できるか確認する（nil）
 */
- (void)testSetVValueAndGetVValueNil {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSetVValueAndGetVValueNil"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        if (result) {
            
            [tracking setVValue:^(VValues *builder) {
                builder.c = nil;
                builder.r = nil;
                builder.t = nil;
                builder.appid = nil;
                builder.dcid = nil;
                builder.dnt = nil;
                builder.dctype = nil;
                builder.ref = nil;
                builder.url = nil;
                builder.pf = nil;
                builder.pcf = nil;
                builder.pcs = nil;
                builder.pct = nil;
                builder.etime = nil;
                builder.event = nil;
                builder.player = nil;
                builder.ad = nil;
                builder.roll = nil;
                builder.pod = nil;
                builder.adev = nil;
                builder.metrics = nil;
                builder.senderid = nil;
                builder.senderuuid = nil;
                builder.snederdcos = nil;
                builder.speed = nil;
                builder.screen = nil;
                builder.p = nil;
                builder.appver = nil;
                builder.projectid = nil;
                builder.snsflg = nil;
                builder.u1 = nil;
                builder.u2 = nil;
                builder.u3 = nil;
                builder.u4 = nil;
                builder.u5 = nil;
                builder.u6 = nil;
                builder.u7 = nil;
                builder.u8 = nil;
                builder.u9 = nil;
                builder.ptag = nil;
                builder.hci = nil;
                builder.hca = nil;
                builder.hce = nil;
                builder.hpc = nil;
                builder.hcr = nil;
                builder.hld = nil;
            }];
            
            NSLog(@"%@",[tracking getVValue:@"c"]);
            
            // 前提：拡張フィールドをnilで設定している
            // 想定：全ての変数が入っていない（nilである）
            XCTAssertNil([tracking getVValue:@"c"]);
            XCTAssertNil([tracking getVValue:@"r"]);
            XCTAssertNil([tracking getVValue:@"t"]);
            XCTAssertNil([tracking getVValue:@"appid"]);
            XCTAssertNil([tracking getVValue:@"dcid"]);
            XCTAssertNil([tracking getVValue:@"dnt"]);
            XCTAssertNil([tracking getVValue:@"dctype"]);
            XCTAssertNil([tracking getVValue:@"ref"]);
            XCTAssertNil([tracking getVValue:@"url"]);
            XCTAssertNil([tracking getVValue:@"pf"]);
            XCTAssertNil([tracking getVValue:@"pcf"]);
            XCTAssertNil([tracking getVValue:@"pcs"]);
            XCTAssertNil([tracking getVValue:@"pct"]);
            XCTAssertNil([tracking getVValue:@"etime"]);
            XCTAssertNil([tracking getVValue:@"event"]);
            XCTAssertNil([tracking getVValue:@"player"]);
            XCTAssertNil([tracking getVValue:@"ad"]);
            XCTAssertNil([tracking getVValue:@"roll"]);
            XCTAssertNil([tracking getVValue:@"pod"]);
            XCTAssertNil([tracking getVValue:@"adev"]);
            XCTAssertNil([tracking getVValue:@"metrics"]);
            XCTAssertNil([tracking getVValue:@"senderid"]);
            XCTAssertNil([tracking getVValue:@"senderuuid"]);
            XCTAssertNil([tracking getVValue:@"snederdcos"]);
            XCTAssertNil([tracking getVValue:@"speed"]);
            XCTAssertNil([tracking getVValue:@"screen"]);
            XCTAssertNil([tracking getVValue:@"p"]);
            XCTAssertNil([tracking getVValue:@"appver"]);
            XCTAssertNil([tracking getVValue:@"projectid"]);
            XCTAssertNil([tracking getVValue:@"snsflg"]);
            XCTAssertNil([tracking getVValue:@"u1"]);
            XCTAssertNil([tracking getVValue:@"u2"]);
            XCTAssertNil([tracking getVValue:@"u3"]);
            XCTAssertNil([tracking getVValue:@"u4"]);
            XCTAssertNil([tracking getVValue:@"u5"]);
            XCTAssertNil([tracking getVValue:@"u6"]);
            XCTAssertNil([tracking getVValue:@"u7"]);
            XCTAssertNil([tracking getVValue:@"u8"]);
            XCTAssertNil([tracking getVValue:@"u9"]);
            XCTAssertNil([tracking getVValue:@"ptag"]);
            XCTAssertNil([tracking getVValue:@"hci"]);
            XCTAssertNil([tracking getVValue:@"hca"]);
            XCTAssertNil([tracking getVValue:@"hce"]);
            XCTAssertNil([tracking getVValue:@"hpc"]);
            XCTAssertNil([tracking getVValue:@"hcr"]);
            XCTAssertNil([tracking getVValue:@"hld"]);
            
            [expectation fulfill];
        }
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：設定した拡張フィールドを使用してビーコンが送信できるか確認する（VRタグ）
 */
- (void)testSetVValueAndGetVValueSendBeaconVR {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSetVValueAndGetVValueSendBeaconVR"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        if (result) {
            
            [tracking setVValue:^(VValues *builder) {
                builder.c = @"c";
                builder.r = @"r";
                builder.t = @"t";
                builder.appid = @"appid";
                builder.dcid = @"dcid";
                builder.dnt = @"dnt";
                builder.dctype = @"dctype";
                builder.ref = @"ref";
                builder.url = @"url";
                builder.pf = @"pf";
                builder.pcf = @"pcf";
                builder.pcs = @"pcs";
                builder.pct = @"pct";
                builder.etime = @"etime";
                builder.event = @"event";
                builder.player = @"player";
                builder.ad = @"ad";
                builder.roll = @"roll";
                builder.pod = @"pod";
                builder.adev = @"adev";
                builder.metrics = @"metrics";
                builder.senderid = @"senderid";
                builder.senderuuid = @"senderuuid";
                builder.snederdcos = @"snederdcos";
                builder.speed = @"speed";
                builder.screen = @"screen";
                builder.p = @"p";
                builder.appver = @"appver";
                builder.projectid = @"projectid";
                builder.snsflg = @"snsflg";
                builder.u1 = @"u1";
                builder.u2 = @"u2";
                builder.u3 = @"u3";
                builder.u4 = @"u4";
                builder.u5 = @"u5";
                builder.u6 = @"u6";
                builder.u7 = @"u7";
                builder.u8 = @"u8";
                builder.u9 = @"u9";
                builder.ptag = @"ptag";
                builder.hci = @"hci";
                builder.hca = @"hca";
                builder.hce = @"hce";
                builder.hpc = @"hpc";
                builder.hcr = @"hcr";
                builder.hld = @"hld";
            }];
            
            NSLog(@"%@",[tracking getVValue:@"c"]);
            
            // 前提：拡張フィールドを設定している
            // 想定：送信時にエラーが吐き出されないことを確認
            XCTAssertNoThrow([tracking sendBeaconWithEventName:@"testSendBeaconNormal" monitorId:@"test_monitor_id" finishBlock:^(BOOL result) {
                [expectation fulfill];
            }]);
            
        }
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：設定した拡張フィールドを使用してビーコンが送信できるか確認する（VRタグ）
 */
- (void)testSetVValueAndGetVValueSendBeaconV {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSetVValueAndGetVValueNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        if (result) {
            
            [tracking setVValue:^(VValues *builder) {
                builder.c = @"c";
                builder.r = @"r";
                builder.t = @"t";
                builder.appid = @"appid";
                builder.dcid = @"dcid";
                builder.dnt = @"dnt";
                builder.dctype = @"dctype";
                builder.ref = @"ref";
                builder.url = @"url";
                builder.pf = @"pf";
                builder.pcf = @"pcf";
                builder.pcs = @"pcs";
                builder.pct = @"pct";
                builder.etime = @"etime";
                builder.event = @"event";
                builder.player = @"player";
                builder.ad = @"ad";
                builder.roll = @"roll";
                builder.pod = @"pod";
                builder.adev = @"adev";
                builder.metrics = @"metrics";
                builder.senderid = @"senderid";
                builder.senderuuid = @"senderuuid";
                builder.snederdcos = @"snederdcos";
                builder.speed = @"speed";
                builder.screen = @"screen";
                builder.p = @"p";
                builder.appver = @"appver";
                builder.projectid = @"projectid";
                builder.snsflg = @"snsflg";
                builder.u1 = @"u1";
                builder.u2 = @"u2";
                builder.u3 = @"u3";
                builder.u4 = @"u4";
                builder.u5 = @"u5";
                builder.u6 = @"u6";
                builder.u7 = @"u7";
                builder.u8 = @"u8";
                builder.u9 = @"u9";
                builder.ptag = @"ptag";
                builder.hci = @"hci";
                builder.hca = @"hca";
                builder.hce = @"hce";
                builder.hpc = @"hpc";
                builder.hcr = @"hcr";
                builder.hld = @"hld";
            }];
            
            NSLog(@"%@",[tracking getVValue:@"c"]);
            
            // 前提：拡張フィールドを設定している
            // 想定：送信時にエラーが吐き出されないことを確認
            XCTAssertNoThrow([tracking sendBeaconWithEventName:nil monitorId:nil identity:@"default-v" finishBlock:^(BOOL result) {
                [expectation fulfill];
            }]);
            
        }
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}



#pragma mark - SendBeacon


#pragma mark (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId;

/**
 目的：アプリ名・イベント名・モニターIDを設定するsendBeaconでエラーが起きないかを確認する
 */
- (void)testSendBeaconNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：SDKの初期化がを成功している
        // 想定：送信時にエラーが吐き出されないことを確認
        XCTAssertNoThrow([tracking sendBeaconWithEventName:@"testSendBeaconNormal" monitorId:@"test_monitor_id"]);
        
        [expectation fulfill];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：アプリ名・イベント名・モニターIDを設定するsendBeaconで、引数がnullでもエラーが起きないかを確認する
 */
- (void)testSendBeaconIrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：SDKの初期化がを成功している
        // 想定：送信時にエラーが吐き出されないことを確認
        XCTAssertNoThrow([tracking sendBeaconWithEventName:nil monitorId:nil]);
        
        [expectation fulfill];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：アプリ名・イベント名・モニターIDを設定するsendBeaconで、引数が空文字でもエラーが起きないかを確認する
 */
- (void)testSendBeaconIrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：SDKの初期化がを成功している
        // 想定：送信時にエラーが吐き出されないことを確認
        XCTAssertNoThrow([tracking sendBeaconWithEventName:@"" monitorId:@""]);
        
        [expectation fulfill];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

#pragma mark (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId finishBlock:(FinishSendBeaconBlock)finishBlock;

/**
 目的：アプリ名・イベント名・モニターIDを設定するsendBeaconで送信が完了したかを確認する
 */
- (void)testSendBeaconCollbackNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking sendBeaconWithEventName:@"testSendBeaconNormal" monitorId:@"test_monitor_id_send" finishBlock:^(BOOL result) {
            // 前提：ビーコンを送信している
            // 想定：送信が成功したことを示すresult=trueであることを確認
            XCTAssertTrue(result == YES);
            
            [expectation fulfill];
        }];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：アプリ名・イベント名・モニターIDを設定するsendBeaconで、引数がnullでも送信が完了したかを確認する
 */
- (void)testSendBeaconCollbackIrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking sendBeaconWithEventName:nil monitorId:nil finishBlock:^(BOOL result) {
            // 前提：引数がnullでビーコンを送信している
            // 想定：送信が成功したことを示すresult=trueであることを確認
            XCTAssertTrue(result == YES);
            
            [expectation fulfill];
        }];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：アプリ名・イベント名・モニターIDを設定するsendBeaconで、引数が空文字でも送信が完了したかを確認する
 */
- (void)testSendBeaconCollbackIrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking sendBeaconWithEventName:@"" monitorId:@"" finishBlock:^(BOOL result) {
            // 前提：引数が空文字でビーコンを送信している
            // 想定：送信が成功したことを示すresult=trueであることを確認
            XCTAssertTrue(result == YES);
            
            [expectation fulfill];
        }];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

#pragma mark (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId url:(NSString *)url;

/**
 目的：アプリ名・イベント名・モニターID・URLを設定するsendBeaconでエラーが起きないかを確認する
 */
- (void)testSendBeaconUrlNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：SDKの初期化がを成功している
        // 想定：送信時にエラーが吐き出されないことを確認
        XCTAssertNoThrow([tracking sendBeaconWithEventName:@"testSendBeaconNormal" monitorId:@"test_monitor_id" url:@"https://panelstg.interactive-circle.jp/ver01/measure"]);
        
        [expectation fulfill];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：アプリ名・イベント名・モニターID・URLを設定するsendBeaconでExceptionErrorを投げないかを確認
 */
- (void)testSendBeaconUrlCallbackNoException {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconUrlCallbackNoException"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {

        // 前提：SDKの初期化が完了している
        // 想定：送信が成功し、Exceptionが発生しない（Exception Breakpoint を設定したのちも発生しないことを確認）
        XCTAssertNoThrowSpecific([tracking sendBeaconWithEventName:@"testSendBeaconNormal" monitorId:@"test_monitor_id" url:@"https://panelstg.interactive-circle.jp/ver01/measure" finishBlock:^(BOOL result) {
            XCTAssertTrue(result == YES);
            
            [expectation fulfill];
        }], NSException);
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    XCTAssertNoThrow([tracking sendBeaconWithEventName:@"testSendBeaconNormal" monitorId:@"test_monitor_id" url:@"https://panelstg.interactive-circle.jp/ver01/measure" finishBlock:^(BOOL result) {
    }]);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：アプリ名・イベント名・モニターID・URLを設定するsendBeaconで、引数がnullでもエラーが起きないかを確認する
 */
- (void)testSendBeaconUrlIrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：SDKの初期化がを成功している
        // 想定：送信時にエラーが吐き出されないことを確認
        XCTAssertNoThrow([tracking sendBeaconWithEventName:nil monitorId:nil url:nil]);
        
        [expectation fulfill];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：アプリ名・イベント名・モニターID・URLを設定するsendBeaconで、引数が空文字でもエラーが起きないかを確認する
 */
- (void)testSendBeaconUrlIrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：SDKの初期化がを成功している
        // 想定：送信時にエラーが吐き出されないことを確認
        XCTAssertNoThrow([tracking sendBeaconWithEventName:@"" monitorId:@"" url:@""]);
        
        [expectation fulfill];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId url:(NSString *)url finishBlock:(FinishSendBeaconBlock)finishBlock;

/**
 目的：アプリ名・イベント名・モニターID・URLを設定するsendBeaconで送信が完了したかを確認する
 */
- (void)testSendBeaconUrlCallbackNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking sendBeaconWithEventName:@"testSendBeaconNormal" monitorId:@"test_monitor_id" url:@"https://panelstg.interactive-circle.jp/ver01/measure" finishBlock:^(BOOL result) {
            // 前提：ビーコンを送信している
            // 想定：送信が成功したことを示すresult=trueであることを確認
            XCTAssertTrue(result == YES);
            
            [expectation fulfill];
        }];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：アプリ名・イベント名・モニターID・URLを設定するsendBeaconで、引数がnullでも送信が完了したかを確認する
 */
- (void)testSendBeaconUrlCallbackIrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking sendBeaconWithEventName:nil monitorId:nil url:nil finishBlock:^(BOOL result) {
            // 前提：ビーコンを送信している
            // 想定：送信が成功したことを示すresult=trueであることを確認
            XCTAssertTrue(result == YES);
            
            [expectation fulfill];
        }];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：アプリ名・イベント名・モニターID・URLを設定するsendBeaconで、引数が空文字でも送信が完了したかを確認する
 */
- (void)testSendBeaconUrlCallbackIrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking sendBeaconWithEventName:@"" monitorId:@"" url:@"" finishBlock:^(BOOL result) {
            // 前提：ビーコンを送信している
            // 想定：送信が成功したことを示すresult=trueであることを確認
            XCTAssertTrue(result == YES);
            
            [expectation fulfill];
        }];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

#pragma mark (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId identity:(NSString *)identity;

/**
 目的：アプリ名・イベント名・モニターID・Identityを設定するsendBeaconでエラーが起きないかを確認する
 */
- (void)testSendBeaconidentityNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：SDKの初期化がを成功している
        // 想定：送信時にエラーが吐き出されないことを確認
        XCTAssertNoThrow([tracking sendBeaconWithEventName:@"testSendBeaconNormal" monitorId:@"test_monitor_id" identity:@"default"]);
        
        [expectation fulfill];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：アプリ名・イベント名・モニターID・Identityを設定するsendBeaconでエラーが起きないかを確認する（Vタグ）
 */
- (void)testSendBeaconidentityVConfigNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：SDKの初期化がを成功している
        // 想定：送信時にエラーが吐き出されないことを確認
        XCTAssertNoThrow([tracking sendBeaconWithEventName:@"testSendBeaconNormal" monitorId:@"test_monitor_id" identity:@"default-v"]);
        
        [expectation fulfill];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：アプリ名・イベント名・モニターID・Identityを設定するsendBeaconで、引数がnullでもエラーが起きないかを確認する
 */
- (void)testSendBeaconidentityIrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：SDKの初期化がを成功している
        // 想定：送信時にエラーが吐き出されないことを確認
        XCTAssertNoThrow([tracking sendBeaconWithEventName:nil monitorId:nil identity:nil]);
        
        [expectation fulfill];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：アプリ名・イベント名・モニターID・Identityを設定するsendBeaconで、引数が空文字でもエラーが起きないかを確認する
 */
- (void)testSendBeaconidentityIrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：SDKの初期化がを成功している
        // 想定：送信時にエラーが吐き出されないことを確認
        XCTAssertNoThrow([tracking sendBeaconWithEventName:@"" monitorId:@"" identity:@""]);
        
        [expectation fulfill];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId identity:(NSString *)identity finishBlock:(FinishSendBeaconBlock)finishBlock;

/**
 目的：アプリ名・イベント名・モニターID・Identityを設定するsendBeaconで送信が完了したかを確認する
 */
- (void)testSendBeaconIdentityCallbackNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking sendBeaconWithEventName:@"testSendBeaconNormal" monitorId:@"test_monitor_id" identity:@"default" finishBlock:^(BOOL result) {
            // 前提：ビーコンを送信している
            // 想定：送信が成功したことを示すresult=trueであることを確認
            XCTAssertTrue(result == YES);
            
            [expectation fulfill];
        }];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：アプリ名・イベント名・モニターID・Identityを設定するsendBeaconで送信が完了したかを確認する（Vタグ）
 */
- (void)testSendBeaconIdentityCallbackVConfigNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking sendBeaconWithEventName:@"testSendBeaconNormal" monitorId:@"test_monitor_id" identity:@"default-v" finishBlock:^(BOOL result) {
            // 前提：ビーコンを送信している
            // 想定：送信が成功したことを示すresult=trueであることを確認
            XCTAssertTrue(result == YES);
            
            [expectation fulfill];
        }];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：VRタグ用のOptValueを追加しても、Vタグ用のビーコンに混ざらないで送信が完了したかを確認する
 */
- (void)testSendBeaconIdentityCallbackAddOptValueNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking setVrOptValue:@"test_1" forOptId:1];
        
        [tracking sendBeaconWithEventName:@"testSendBeaconNormal" monitorId:@"test_monitor_id" identity:@"default-v" finishBlock:^(BOOL result) {
            // 前提：ビーコンを送信している
            // 想定：送信が成功したことを示すresult=trueであることを確認
            XCTAssertTrue(result == YES);
            
            [expectation fulfill];
        }];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：アプリ名・イベント名・モニターID・Identityを設定するsendBeaconで、引数がnullでも送信が完了したかを確認する
 */
- (void)testSendBeaconIdentityCallbackIrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking sendBeaconWithEventName:nil monitorId:nil identity:nil finishBlock:^(BOOL result) {
            // 前提：ビーコンを送信している
            // 想定：送信が成功したことを示すresult=trueであることを確認
            XCTAssertTrue(result == YES);
            
            [expectation fulfill];
        }];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：アプリ名・イベント名・モニターID・Identityを設定するsendBeaconで、引数が空文字でも送信が完了したかを確認する
 */
- (void)testSendBeaconIdentityCallbackIrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking sendBeaconWithEventName:@"" monitorId:@"" identity:@"" finishBlock:^(BOOL result) {
            // 前提：ビーコンを送信している
            // 想定：送信が成功したことを示すresult=trueであることを確認
            XCTAssertTrue(result == YES);
            
            [expectation fulfill];
        }];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

#pragma mark (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId url:(NSString *)url identity:(NSString *)identity;

/**
 目的：アプリ名・イベント名・モニターID・URL・Identityを設定するsendBeaconでエラーが起きないかを確認する
 */
- (void)testSendBeaconUrlIdentityNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：SDKの初期化がを成功している
        // 想定：送信時にエラーが吐き出されないことを確認
        XCTAssertNoThrow([tracking sendBeaconWithEventName:@"testSendBeaconNormal" monitorId:@"test_monitor_id" url:@"https://panelstg.interactive-circle.jp/ver01/measure" identity:@"default"]);
        
        [expectation fulfill];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：アプリ名・イベント名・モニターID・URL・Identityを設定するsendBeaconで、引数がnullでもエラーが起きないかを確認する
 */
- (void)testSendBeaconUrlIdentityIrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：SDKの初期化がを成功している
        // 想定：送信時にエラーが吐き出されないことを確認
        XCTAssertNoThrow([tracking sendBeaconWithEventName:nil monitorId:nil url:nil identity:nil]);
        
        [expectation fulfill];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：アプリ名・イベント名・モニターID・URL・Identityを設定するsendBeaconで、引数が空文字でもエラーが起きないかを確認する
 */
- (void)testSendBeaconUrlIdentityIrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：SDKの初期化がを成功している
        // 想定：送信時にエラーが吐き出されないことを確認
        XCTAssertNoThrow([tracking sendBeaconWithEventName:@"" monitorId:@"" url:@"" identity:@""]);
        
        [expectation fulfill];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

#pragma mark (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId url:(NSString *)url identity:(NSString *)identity finishBlock:(FinishSendBeaconBlock)finishBlock;

/**
 目的：アプリ名・イベント名・モニターID・URL・Identityを設定するsendBeaconで送信が完了したかを確認する
 */
- (void)testSendBeaconUrlIdentityCallbackNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking sendBeaconWithEventName:@"testSendBeaconNormal" monitorId:@"test_monitor_id" url:@"https://panelstg.interactive-circle.jp/ver01/measure" identity:@"default" finishBlock:^(BOOL result) {
            // 前提：ビーコンを送信している
            // 想定：送信が成功したことを示すresult=trueであることを確認
            XCTAssertTrue(result == YES);
            
            [expectation fulfill];
        }];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：アプリ名・イベント名・モニターID・URL・Identityを設定するsendBeaconで、引数がnullでも送信が完了したかを確認する
 */
- (void)testSendBeaconUrlIdentityCallbackIrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking sendBeaconWithEventName:nil monitorId:nil url:nil identity:nil finishBlock:^(BOOL result) {
            // 前提：ビーコンを送信している
            // 想定：送信が成功したことを示すresult=trueであることを確認
            XCTAssertTrue(result == YES);
            
            [expectation fulfill];
        }];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：アプリ名・イベント名・モニターID・URL・Identityを設定するsendBeaconで、引数が空文字でも送信が完了したかを確認する
 */
- (void)testSendBeaconUrlIdentityCallbackIrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking sendBeaconWithEventName:@"" monitorId:@"" url:@"" identity:@"" finishBlock:^(BOOL result) {
            // 前提：ビーコンを送信している
            // 想定：送信が成功したことを示すresult=trueであることを確認
            XCTAssertTrue(result == YES);
            
            [expectation fulfill];
        }];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}



#pragma mark - Opt

#pragma mark (void)setOptin;

/**
 目的：オプトインできているかを確認する
 */
- (void)testOptInNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking setOptout];
        XCTAssertTrue([tracking isOptout]);
        
        // 前提：オプトアウトしている
        // 想定：オプトインできていることを確認
        [tracking setOptin];
        XCTAssertTrue([tracking isOptout] == NO);
        
        [expectation fulfill];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (void)setOptin:(FinishSetOptinBlock)finishBlock;

/**
 目的：オプトインできているかを確認する
 */
- (void)testOptInCallbackNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking setOptout];
        XCTAssertTrue([tracking isOptout]);
        
        // 前提：オプトアウトしている
        // 想定：オプトインできていることを確認
        [tracking setOptin:^(BOOL result) {
            XCTAssertTrue(result == YES);
            XCTAssertTrue([tracking isOptout] == NO);
            
            [expectation fulfill];
        }];

    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (void)setOptout;

/**
 目的：オプトアウトできているかを確認する
 */
- (void)testOptOutNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking setOptin];
        XCTAssertFalse([tracking isOptout]);
        
        // 前提：オプトインしている
        // 想定：オプトアウトできていることを確認
        [tracking setOptout];
        XCTAssertTrue([tracking isOptout] == YES);
        
        [expectation fulfill];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (void)setOptout:(FinishSetOptoutBlock)finishBlock;

/**
 目的：オプトアウトできているかをコールバックで確認する
 */
- (void)testOptOutCallbackNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking setOptin];
        XCTAssertFalse([tracking isOptout]);
        
        // 前提：オプトインしている
        // 想定：オプトアウトできていることを確認
        [tracking setOptout:^(BOOL result) {
            XCTAssertTrue(result == YES);
            XCTAssertTrue([tracking isOptout] == YES);
            
            [expectation fulfill];
        }];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

#pragma mark (BOOL)isOptout; 上記で行なっているので省略



#pragma mark - ConfigFile
 
#pragma mark (void)loadConfig:(NSString *)identity fileName:(NSString *)fileName;

/**
 目的：デフォルト以外の設定ファイルをエラーを吐き出さずに設定できているかを確認する
 */
- (void)testLoadConfigNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提："test"というidentityで設定ファイルを読み込んでいる
        // 想定：エラーがスローされずに読み込めるかを確認
        XCTAssertNoThrow([tracking loadConfig:@"test" fileName:@"TestVrTrackingConfig"]);
        
        [expectation fulfill];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：初期化直後に設定した場合でも、他の設定ファイルが読み込み完了するかを確認する
 */
- (void)testLoadConfigAfterNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提："test"というidentityで設定ファイルを読み込んでいる
    // 想定：読み込みが完了するかを確認
    [tracking loadConfig:@"test" fileName:@"TestVrTrackingConfig" finishBlock:^(BOOL result) {

        NSDictionary *aaa = [tracking configParams:@"test"];
        NSLog(@"takahashi test %@", [aaa description]);
        [expectation fulfill];
    }];
    
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：デフォルト以外の設定ファイルを読み込む際に、引数がnullでもエラーが起きないかを確認する
 */
- (void)testLoadConfigIrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提："test"というidentityで設定ファイルを読み込んでいる
        // 想定：エラーがスローされずに読み込めるかを確認
        XCTAssertNoThrow([tracking loadConfig:nil fileName:nil]);
        
        [expectation fulfill];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：デフォルト以外の設定ファイルを読み込む際に、引数が空文字でもエラーが起きないかを確認する
 */
- (void)testLoadConfigIrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提："test"というidentityで設定ファイルを読み込んでいる
        // 想定：エラーがスローされずに読み込めるかを確認
        XCTAssertNoThrow([tracking loadConfig:@"" fileName:@""]);
        
        [expectation fulfill];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

#pragma mark (void)loadConfig:(NSString *)identity fileName:(NSString *)fileName finishBlock:(FinishLoadBlock)finishBlock;

/**
 目的：デフォルト以外の設定ファイルをエラーを吐き出さずに正しく設定できているかを確認する
 */
- (void)testLoadConfigCallbackNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking loadConfig:@"test" fileName:@"TestVrTrackingConfig" finishBlock:^(BOOL result) {
            
            // 前提："test"というidentityで設定ファイルを読み込んでいる
            // 想定：コールバックがtrueで返ってくることを確認
            XCTAssertTrue(result == YES);
            
            [expectation fulfill];
        }];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：デフォルト以外の設定ファイルを読み込む際に、引数がnullだとコールバックで成功が返ってくることを確認する
 */
- (void)testLoadConfigCallbackIrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking loadConfig:nil fileName:nil finishBlock:^(BOOL result) {
            
            // 前提：nilのidentityで設定ファイルを読み込んでいる
            // 想定：fileNameがnilなので、falseで返ってくることを確認
            XCTAssertTrue(result == NO);
            
            [expectation fulfill];
        }];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：デフォルト以外の設定ファイルを読み込む際に、引数が空文字だとコールバックで失敗が返ってくることを確認する
 */
- (void)testLoadConfigCallbackIrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking loadConfig:@"" fileName:@"" finishBlock:^(BOOL result) {
            
            // 前提：空文字のidentityで設定ファイルを読み込んでいる
            // 想定：fileNameが空なので、falseで返ってくることを確認
            XCTAssertTrue(result == NO);
            
            [expectation fulfill];
        }];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (BOOL)isCheckedLoadConfigRunning:(NSString *)identity;

/**
 目的：設定ファイルが読み込み中かどうかが正しく判定できているかを確認する
 */
- (void)testIsCheckedLoadConfigRunningNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking loadConfig:@"test" fileName:@"TestVrTrackingConfig" finishBlock:^(BOOL result) {
            NSLog(@"isCheckedLoadConfigRunning result : %@", result?@"YES":@"NO");
            // 前提："test"というidentityで設定ファイルを読みが完了している
            // 想定：読み込みが完了しているので、isCheckedLoadConfigRunning=falseなのを確認
            XCTAssertTrue([tracking isCheckedLoadConfigRunning:@"test"] == NO);
            
            [expectation fulfill];
        }];
        // 前提："test"というidentityで設定ファイルを読み込んでいる
        // 想定：非同期にてリモート設定ファイルを読み込み中なので、isCheckedLoadConfigRunning=trueなのを確認
        XCTAssertTrue([tracking isCheckedLoadConfigRunning:@"test"] == YES);
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}



#pragma mark (NSDictionary *)configParams;


/**
 目的：読み込んだ設定ファイルが正しく取得できるかを確認する
 */
- (void)testConfigParamsNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        NSDictionary *config = [tracking configParams];
        NSLog(@"%@", [config debugDescription]);
        
        // 前提：デフォルトの設定ファイルの読みが完了している
        // 想定：設定値が全て正確に入っているかをを確認
        XCTAssertTrue([[config objectForKey:@"vr_tagid1"] isEqualToString:@"9999"]);
        XCTAssertTrue([[config objectForKey:@"vr_tagid2"] isEqualToString:@"9997"]);
        XCTAssertNil([config objectForKey:@"config_url"]);
        XCTAssertTrue([[config objectForKey:@"disabled"] isEqualToString:@"false"]);
        XCTAssertTrue([[config objectForKey:@"config_timeout"] isEqualToString:@"5"]);
        XCTAssertTrue([[config objectForKey:@"beacon_timeout"] isEqualToString:@"5"]);
        XCTAssertTrue([[config objectForKey:@"beacon_url"] isEqualToString:@"https://panelstg.interactive-circle.jp/sdk-test01/measure"]);
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (NSDictionary *)configParams:(NSString *)identity;

/**
 目的：identityを指定しても読み込んだ設定ファイルが正しく取得できるかを確認する
 */
- (void)testConfigParamsWithIdentityNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking loadConfig:@"test" fileName:@"TestVrTrackingConfig" finishBlock:^(BOOL result) {
            NSLog(@"isCheckedLoadConfigRunning result : %@", result?@"YES":@"NO");
            NSDictionary *config = [tracking configParams:@"test"];
            
            // 前提："test"というidentityで設定ファイルを読みが完了している
            // 想定：設定値が全て正確に入っているかをを確認
            XCTAssertTrue([[config objectForKey:@"vr_tagid1"] isEqualToString:@"9997"]);
            XCTAssertTrue([[config objectForKey:@"vr_tagid2"] isEqualToString:@"1002"]);
            XCTAssertTrue([[config objectForKey:@"max_que_recs"] isEqualToString:@"10000"]);
            XCTAssertNil([config objectForKey:@"config_url"]);
            XCTAssertTrue([[config objectForKey:@"debug_log"] isEqualToString:@"true"]);
            XCTAssertTrue([[config objectForKey:@"disabled"] isEqualToString:@"false"]);
            XCTAssertTrue([[config objectForKey:@"polling"] isEqualToString:@"true"]);
            XCTAssertTrue([[config objectForKey:@"polling_start"] isEqualToString:@"true"]);
            XCTAssertTrue([[config objectForKey:@"polling_interval"] isEqualToString:@"2"]);
            XCTAssertTrue([[config objectForKey:@"config_timeout"] isEqualToString:@"5"]);
            XCTAssertTrue([[config objectForKey:@"beacon_timeout"] isEqualToString:@"5"]);
            XCTAssertTrue([[config objectForKey:@"expired_time_beacon_log"] isEqualToString:@"2147483646"]);
            XCTAssertTrue([[config objectForKey:@"beacon_url"] isEqualToString:@"https://panelstg.interactive-circle.jp/ver01/measure"]);
            
            [expectation fulfill];
        }];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：nullのidentityを指定しても読み込んだ設定ファイルが正しく取得できるかを確認する
 */
- (void)testConfigParamsWithIdentityIrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking loadConfig:@"test" fileName:@"TestVrTrackingConfig" finishBlock:^(BOOL result) {
            NSLog(@"isCheckedLoadConfigRunning result : %@", result?@"YES":@"NO");
            NSDictionary *config = [tracking configParams:nil];
            
            // 前提："test"というidentityで設定ファイルを読みが完了している
            // 想定：デフォルトの設定値が全て正確に入っているかをを確認
            XCTAssertTrue([[config objectForKey:@"vr_tagid1"] isEqualToString:@"9999"]);
            XCTAssertTrue([[config objectForKey:@"vr_tagid2"] isEqualToString:@"9997"]);
            XCTAssertNil([config objectForKey:@"config_url"]);
            XCTAssertTrue([[config objectForKey:@"disabled"] isEqualToString:@"false"]);
            XCTAssertTrue([[config objectForKey:@"config_timeout"] isEqualToString:@"5"]);
            XCTAssertTrue([[config objectForKey:@"beacon_timeout"] isEqualToString:@"5"]);
            XCTAssertTrue([[config objectForKey:@"beacon_url"] isEqualToString:@"https://panelstg.interactive-circle.jp/sdk-test01/measure"]);
            
            [expectation fulfill];
        }];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：空文字のidentityを指定しても読み込んだ設定ファイルが正しく取得できるかを確認する
 */
- (void)testConfigParamsWithIdentityIrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking loadConfig:@"test" fileName:@"TestVrTrackingConfig" finishBlock:^(BOOL result) {
            NSLog(@"isCheckedLoadConfigRunning result : %@", result?@"YES":@"NO");
            NSDictionary *config = [tracking configParams:@""];
            
            NSLog(@"%@", [config debugDescription]);
            
            // 前提："test"というidentityで設定ファイルを読みが完了している
            // 想定：デフォルト設定値が全て正確に入っているかをを確認
            XCTAssertTrue([[config objectForKey:@"vr_tagid1"] isEqualToString:@"9999"]);
            XCTAssertTrue([[config objectForKey:@"vr_tagid2"] isEqualToString:@"9997"]);
            XCTAssertNil([config objectForKey:@"config_url"]);
            XCTAssertTrue([[config objectForKey:@"disabled"] isEqualToString:@"false"]);
            XCTAssertTrue([[config objectForKey:@"config_timeout"] isEqualToString:@"5"]);
            XCTAssertTrue([[config objectForKey:@"beacon_timeout"] isEqualToString:@"5"]);
            XCTAssertTrue([[config objectForKey:@"beacon_url"] isEqualToString:@"https://panelstg.interactive-circle.jp/sdk-test01/measure"]);
            
            [expectation fulfill];
        }];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (NSDictionary *)getVConfigParams;

/**
 目的：デフォルトの設定ファイルを正しく読み込んだことを確認する（VとVR）
 */
- (void)testConfigParamsDefaultConfigCheck {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testInitWithTrackerDefaultConfigCheck"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        if (result) {
            // 前提：デフォルト設定ファイルを読み込んでいる
            // 想定：エラーがスローされずに読み込めるかを確認
            XCTAssertNotNil([tracking configParams]);
            XCTAssertNotNil([tracking getVConfigParams]);

            /* リモート設定ファイルの値
             <vr_tagid1>9999</vr_tagid1>
             <vr_tagid2>9997</vr_tagid2>
             <config_url/>
             <disabled>false</disabled>
             <config_timeout>5</config_timeout>
             <beacon_timeout>5</beacon_timeout>
             <beacon_url default="https://panelstg.interactive-circle.jp/sdk-test01/measure">445</beacon_url>
             */
            NSDictionary *vr = [tracking configParams];
            NSLog(@"%@", [vr debugDescription]);
            
            NSLog(@"%@",[vr valueForKey:@"vr_tagid1"]);
            XCTAssertTrue([@"vr" isEqual:[vr valueForKey:@"tag_type"]]);
            XCTAssertTrue([@"9999" isEqual:[vr valueForKey:@"vr_tagid1"] ]);
            XCTAssertTrue([@"9997" isEqual:[vr valueForKey:@"vr_tagid2"] ]);
            XCTAssertNil([vr valueForKey:@"config_url"]);
            XCTAssertTrue([@"false" isEqual:[vr valueForKey:@"disabled"] ]);
            XCTAssertTrue([@"5" isEqual:[vr valueForKey:@"config_timeout"] ]);
            XCTAssertTrue([@"5" isEqual:[vr valueForKey:@"beacon_timeout"] ]);
            XCTAssertTrue([@"https://panelstg.interactive-circle.jp/sdk-test01/measure" isEqual:[vr objectForKey:@"beacon_url"] ]);
            
            
            /* リモート設定ファイルの値
             <tag_type>v</tag_type>
             <a>10192881</a>
             <dcos>androidtv</dcos>
             <config_url/>
             <disabled>false</disabled>
             <config_timeout>5</config_timeout>
             <beacon_timeout>5</beacon_timeout>
             <beacon_url default="https://panelstg.interactive-circle.jp/sdk-test01/measure">445</beacon_url>
             */
            NSDictionary *v = [tracking getVConfigParams];
            NSLog(@"%@", [v debugDescription]);
            XCTAssertTrue([@"v" isEqual:[v valueForKey:@"tag_type"] ]);
            XCTAssertTrue([@"10192881" isEqual:[v valueForKey:@"a"] ]);
            XCTAssertTrue([@"androidtv" isEqual:[v valueForKey:@"dcos"] ]);
            XCTAssertNil([v valueForKey:@"config_url"]);
            XCTAssertTrue([@"false" isEqual:[v valueForKey:@"disabled"] ]);
            XCTAssertTrue([@"5" isEqual:[v valueForKey:@"config_timeout"] ]);
            XCTAssertTrue([@"5" isEqual:[v valueForKey:@"beacon_timeout"] ]);
            XCTAssertTrue([@"https://panelstg.interactive-circle.jp/sdk-test01/measure" isEqual:[v objectForKey:@"beacon_url"] ]);
            
            [expectation fulfill];
        }
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

#pragma mark (void)setConfig:(NSDictionary *)config;

/**
 目的：設定ファイルの一部だけを上書きできているかを確認する
 */
- (void)testSetConfigNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        NSDictionary *override = @{@"vr_tagid2":@"1002"};
        [tracking setConfig:override];
        
        NSDictionary *config = [tracking configParams];
        
        // 前提：デフォルトの設定ファイルに"vr_tagid2"に"1002"という文字列を上書きしている
        // 想定："vr_tagid2"に"1002"が入っており、設定値が全て正確に入っているかをを確認
        XCTAssertTrue([[config objectForKey:@"vr_tagid1"] isEqualToString:@"9999"]);
        XCTAssertTrue([[config objectForKey:@"vr_tagid2"] isEqualToString:@"1002"]);
        XCTAssertNil([config objectForKey:@"config_url"]);
        XCTAssertTrue([[config objectForKey:@"disabled"] isEqualToString:@"false"]);
        XCTAssertTrue([[config objectForKey:@"config_timeout"] isEqualToString:@"5"]);
        XCTAssertTrue([[config objectForKey:@"beacon_timeout"] isEqualToString:@"5"]);
        XCTAssertTrue([[config objectForKey:@"beacon_url"] isEqualToString:@"https://panelstg.interactive-circle.jp/sdk-test01/measure"]);
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：設定ファイルの一部だけを値が空文字でも上書きできているかを確認する
 */
- (void)testSetConfigIrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        NSDictionary *override = @{@"vr_tagid2":@""};
        [tracking setConfig:override];
        
        NSDictionary *config = [tracking configParams];
        
        // 前提：デフォルトの設定ファイルに"vr_tagid2"に空文字で上書きしている
        // 想定："vr_tagid2"に空文字を許容していないので、変更されていないかをを確認
        XCTAssertTrue([[config objectForKey:@"vr_tagid1"] isEqualToString:@"9999"]);
        XCTAssertTrue([[config objectForKey:@"vr_tagid2"] isEqualToString:@"9997"]);
        XCTAssertNil([config objectForKey:@"config_url"]);
        XCTAssertTrue([[config objectForKey:@"disabled"] isEqualToString:@"false"]);
        XCTAssertTrue([[config objectForKey:@"config_timeout"] isEqualToString:@"5"]);
        XCTAssertTrue([[config objectForKey:@"beacon_timeout"] isEqualToString:@"5"]);
        XCTAssertTrue([[config objectForKey:@"beacon_url"] isEqualToString:@"https://panelstg.interactive-circle.jp/sdk-test01/measure"]);
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：設定ファイルの一部だけをnullの辞書で上書きしても変更されないかを確認する
 */
- (void)testSetConfigIrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {

        [tracking setConfig:nil];

        NSDictionary *config = [tracking configParams];

        // 前提：デフォルトの設定ファイルにnilの配列で上書きしている
        // 想定：設定値が全て正確に入っているかをを確認
        XCTAssertTrue([[config objectForKey:@"vr_tagid1"] isEqualToString:@"9999"]);
        XCTAssertTrue([[config objectForKey:@"vr_tagid2"] isEqualToString:@"9997"]);
        XCTAssertNil([config objectForKey:@"config_url"]);
        XCTAssertTrue([[config objectForKey:@"disabled"] isEqualToString:@"false"]);
        XCTAssertTrue([[config objectForKey:@"config_timeout"] isEqualToString:@"5"]);
        XCTAssertTrue([[config objectForKey:@"beacon_timeout"] isEqualToString:@"5"]);
        XCTAssertTrue([[config objectForKey:@"beacon_url"] isEqualToString:@"https://panelstg.interactive-circle.jp/sdk-test01/measure"]);

        [expectation fulfill];


    } withOptFlg:YES withOutsideConfigURL:nil];

    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (void)setVConfig:(NSDictionary *)config;

/**
 目的：設定ファイルの一部だけを上書きできているかを確認する
 */
- (void)testSetVConfigNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSetVConfigNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        NSDictionary *override = @{@"dcos":@"ios"};
        [tracking setVConfig:override];
        
        NSDictionary *config = [tracking getVConfigParams];
        
        NSLog(@"%@", [config debugDescription]);
        
        // 前提：デフォルトの設定ファイルに"dcos"に"ios"という文字列を上書きしている
        // 想定："dcos"に"ios"が入っており、設定値が全て正確に入っているかをを確認
        XCTAssertTrue([[config objectForKey:@"a"] isEqualToString:@"10192881"]);
        XCTAssertTrue([[config objectForKey:@"dcos"] isEqualToString:@"ios"]);
        XCTAssertNil([config objectForKey:@"config_url"]);
        XCTAssertTrue([[config objectForKey:@"disabled"] isEqualToString:@"false"]);
        XCTAssertTrue([[config objectForKey:@"config_timeout"] isEqualToString:@"5"]);
        XCTAssertTrue([[config objectForKey:@"beacon_timeout"] isEqualToString:@"5"]);
        XCTAssertTrue([[config objectForKey:@"beacon_url"] isEqualToString:@"https://panelstg.interactive-circle.jp/sdk-test01/measure"]);
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：設定ファイルの一部だけを値が空文字でも上書きできているかを確認する
 */
- (void)testSetVConfigIrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        NSDictionary *override = @{@"dcos":@""};
        [tracking setVConfig:override];
        
        NSDictionary *config = [tracking getVConfigParams];
        
        // 前提：デフォルトの設定ファイルに"dcos"に空文字で上書きしている
        // 想定："dcos"に空文字を許容していないので、変更されていないかをを確認
        XCTAssertTrue([[config objectForKey:@"a"] isEqualToString:@"10192881"]);
        XCTAssertTrue([[config objectForKey:@"dcos"] isEqualToString:@""]);
        XCTAssertNil([config objectForKey:@"config_url"]);
        XCTAssertTrue([[config objectForKey:@"disabled"] isEqualToString:@"false"]);
        XCTAssertTrue([[config objectForKey:@"config_timeout"] isEqualToString:@"5"]);
        XCTAssertTrue([[config objectForKey:@"beacon_timeout"] isEqualToString:@"5"]);
        XCTAssertTrue([[config objectForKey:@"beacon_url"] isEqualToString:@"https://panelstg.interactive-circle.jp/sdk-test01/measure"]);
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：設定ファイルの一部だけをnullの辞書で上書きしても変更されないかを確認する
 */
- (void)testSetVConfigIrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {

        [tracking setVConfig:nil];

        NSDictionary *config = [tracking getVConfigParams];

        // 前提：デフォルトの設定ファイルにnilの配列で上書きしている
        // 想定：設定値が全て正確に入っているかをを確認
        XCTAssertTrue([[config objectForKey:@"a"] isEqualToString:@"10192881"]);
        XCTAssertTrue([[config objectForKey:@"dcos"] isEqualToString:@"androidtv"]);
        XCTAssertNil([config objectForKey:@"config_url"]);
        XCTAssertTrue([[config objectForKey:@"disabled"] isEqualToString:@"false"]);
        XCTAssertTrue([[config objectForKey:@"config_timeout"] isEqualToString:@"5"]);
        XCTAssertTrue([[config objectForKey:@"beacon_timeout"] isEqualToString:@"5"]);
        XCTAssertTrue([[config objectForKey:@"beacon_url"] isEqualToString:@"https://panelstg.interactive-circle.jp/sdk-test01/measure"]);
        
        [expectation fulfill];


    } withOptFlg:YES withOutsideConfigURL:nil];

    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

#pragma mark (void)setConfig:(NSDictionary *)config identity:(NSString *)identity;

/**
 目的：identityを指定して設定ファイルの一部だけを上書きできているかを確認する
 */
- (void)testSetConfigWithIdentityNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking loadConfig:@"test" fileName:@"TestVrTrackingConfig" finishBlock:^(BOOL result) {
            NSLog(@"isCheckedLoadConfigRunning result : %@", result?@"YES":@"NO");
            
            NSDictionary *override = @{@"vr_tagid2":@"1001"};
            [tracking setConfig:override identity:@"test"];
            
            NSDictionary *config = [tracking configParams:@"test"];
            
            // 前提："test"というidentityの設定ファイルに"vr_tagid2"に"1002"という文字列を上書きしている
            // 想定："vr_tagid2"に"1002"が入っており、設定値が全て正確に入っているかをを確認
            XCTAssertTrue([[config objectForKey:@"vr_tagid1"] isEqualToString:@"9997"]);
            XCTAssertTrue([[config objectForKey:@"vr_tagid2"] isEqualToString:@"1001"]);
            XCTAssertTrue([[config objectForKey:@"max_que_recs"] isEqualToString:@"10000"]);
            XCTAssertNil([config objectForKey:@"config_url"]);
            XCTAssertTrue([[config objectForKey:@"debug_log"] isEqualToString:@"true"]);
            XCTAssertTrue([[config objectForKey:@"disabled"] isEqualToString:@"false"]);
            XCTAssertTrue([[config objectForKey:@"polling"] isEqualToString:@"true"]);
            XCTAssertTrue([[config objectForKey:@"polling_start"] isEqualToString:@"true"]);
            XCTAssertTrue([[config objectForKey:@"polling_interval"] isEqualToString:@"2"]);
            XCTAssertTrue([[config objectForKey:@"config_timeout"] isEqualToString:@"5"]);
            XCTAssertTrue([[config objectForKey:@"beacon_timeout"] isEqualToString:@"5"]);
            XCTAssertTrue([[config objectForKey:@"expired_time_beacon_log"] isEqualToString:@"2147483646"]);
            XCTAssertTrue([[config objectForKey:@"beacon_url"] isEqualToString:@"https://panelstg.interactive-circle.jp/ver01/measure"]);
            
            [expectation fulfill];
        }];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：存在しないidentityを指定して設定ファイルの一部だけを追加できているかを確認する
 */
- (void)testSetConfigWithIdentityIrregularOtherIdentity {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking loadConfig:@"test" fileName:@"TestVrTrackingConfig" finishBlock:^(BOOL result) {
            NSLog(@"isCheckedLoadConfigRunning result : %@", result?@"YES":@"NO");
            
            NSDictionary *override = @{@"vr_tagid2":@"1001"};
            [tracking setConfig:override identity:@"test_other"];
            
            NSDictionary *config = [tracking configParams:@"test"];
            NSDictionary *config_other = [tracking configParams:@"test_other"];
            
            NSLog(@"%@", [config description]);
            
            // 前提："test_other"という存在しないidentityの設定ファイルに"vr_tagid2"に"1002"という文字列を上書きしている
            // 想定："test"というidentityの設定値は変更がないか、また、存在しない"test_other"というidentityは設定されずnullが返ってくるかを確認
            XCTAssertNil(config_other);
            XCTAssertTrue([[config objectForKey:@"vr_tagid1"] isEqualToString:@"9997"]);
            XCTAssertTrue([[config objectForKey:@"vr_tagid2"] isEqualToString:@"1002"]);
            XCTAssertTrue([[config objectForKey:@"max_que_recs"] isEqualToString:@"10000"]);
            XCTAssertNil([config objectForKey:@"config_url"]);
            XCTAssertTrue([[config objectForKey:@"debug_log"] isEqualToString:@"true"]);
            XCTAssertTrue([[config objectForKey:@"disabled"] isEqualToString:@"false"]);
            XCTAssertTrue([[config objectForKey:@"polling"] isEqualToString:@"true"]);
            XCTAssertTrue([[config objectForKey:@"polling_start"] isEqualToString:@"true"]);
            XCTAssertTrue([[config objectForKey:@"polling_interval"] isEqualToString:@"2"]);
            XCTAssertTrue([[config objectForKey:@"config_timeout"] isEqualToString:@"5"]);
            XCTAssertTrue([[config objectForKey:@"beacon_timeout"] isEqualToString:@"5"]);
            XCTAssertTrue([[config objectForKey:@"expired_time_beacon_log"] isEqualToString:@"2147483646"]);
            XCTAssertTrue([[config objectForKey:@"beacon_url"] isEqualToString:@"https://panelstg.interactive-circle.jp/ver01/measure"]);
            
            [expectation fulfill];
        }];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：設定ファイルを読み込んでいる間に該当の設定ファイルの一部を変更できるかを確認する
 */
- (void)testSetConfigNormalWithSetConfigQueue {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        NSDictionary *config = [tracking configParams];
        
        // 前提：デフォルトの設定ファイルに"vr_tagid2"に"1002"という文字列を上書きしている
        // 想定："vr_tagid2"に"1002"が入っており、設定値が全て正確に入っているかをを確認
        XCTAssertTrue([[config objectForKey:@"vr_tagid1"] isEqualToString:@"9999"]);
        XCTAssertTrue([[config objectForKey:@"vr_tagid2"] isEqualToString:@"1002"]);
        XCTAssertNil([config objectForKey:@"config_url"]);
        XCTAssertTrue([[config objectForKey:@"disabled"] isEqualToString:@"false"]);
        XCTAssertTrue([[config objectForKey:@"config_timeout"] isEqualToString:@"5"]);
        XCTAssertTrue([[config objectForKey:@"beacon_timeout"] isEqualToString:@"5"]);
        XCTAssertTrue([[config objectForKey:@"beacon_url"] isEqualToString:@"https://panelstg.interactive-circle.jp/sdk-test01/measure"]);
        
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    NSDictionary *override = @{@"vr_tagid2":@"1002"};
    [tracking setConfig:override];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：設定ファイルを読み込んでいる間に該当の設定ファイルの一部を複数回変更できるかを確認する
 */
- (void)testSetConfigNormalWithSetConfigQueueMulti {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        NSDictionary *config = [tracking configParams];
        
        // 前提：デフォルトの設定ファイルに"vr_tagid2"に"1002"という文字列を上書きしている
        // 想定："vr_tagid2"に"1002"が入っており、かつ、その他の設定値が全て正確に入っているかをを確認
        XCTAssertTrue([[config objectForKey:@"vr_tagid1"] isEqualToString:@"9999"]);
        XCTAssertTrue([[config objectForKey:@"vr_tagid2"] isEqualToString:@"1002"]);
        XCTAssertNil([config objectForKey:@"config_url"]);
        XCTAssertTrue([[config objectForKey:@"disabled"] isEqualToString:@"false"]);
        XCTAssertTrue([[config objectForKey:@"config_timeout"] isEqualToString:@"5"]);
        XCTAssertTrue([[config objectForKey:@"beacon_timeout"] isEqualToString:@"5"]);
        XCTAssertTrue([[config objectForKey:@"beacon_url"] isEqualToString:@"https://panelstg.interactive-circle.jp/sdk-test01/measure"]);
        
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    NSDictionary *override = @{@"vr_tagid2":@"1002"};
    [tracking setConfig:override];
    
    NSDictionary *override2 = @{@"polling_interval":@"3"};
    [tracking setConfig:override2];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}



#pragma mark - Deprecated methods


#pragma mark (void) __attribute__((deprecated(""))) setPollingEnabled;

/**
 目的：非推奨のsetPollingEnabledをVrInteractiveTrackingのインスタンス化直後に叩いてもエラーが起きないかを確認する
 */
- (void)testSetPollingEnabledNormalBeforeInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSetPollingEnabledNormalBeforeInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提：VrInteractiveTrackingのインスタンス化を行なっている
    // 想定：エラーが起きないかを確認
    XCTAssertNoThrow([tracking setPollingEnabled]);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：非推奨のsetPollingEnabledをVrInteractiveTrackingの初期化コールバックの中で叩いてもエラーが起きないかを確認する
 */
- (void)testSetPollingEnabledNormalAfterInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSetPollingEnabledNormalAfterInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：VrInteractiveTrackingのインスタンス化を行なっている/初期化コールバックが返ってきている
        // 想定：エラーが起きないかを確認
        XCTAssertNoThrow([tracking setPollingEnabled]);
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

#pragma mark (void) __attribute__((deprecated(""))) setPollingDisabled;

/**
 目的：非推奨のsetPollingDisabledをVrInteractiveTrackingのインスタンス化直後に叩いてもエラーが起きないかを確認する
 */
- (void)testSetPollingDisabledNormalBeforeInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSetPollingDisabledNormalBeforeInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提：VrInteractiveTrackingのインスタンス化を行なっている
    // 想定：エラーが起きないかを確認
    XCTAssertNoThrow([tracking setPollingDisabled]);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：非推奨のsetPollingDisabledをVrInteractiveTrackingの初期化コールバックの中で叩いてもエラーが起きないかを確認する
 */
- (void)testSetPollingDisabledNormalAfterInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSetPollingDisabledNormalAfterInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：VrInteractiveTrackingのインスタンス化を行なっている/初期化コールバックが返ってきている
        // 想定：エラーが起きないかを確認
        XCTAssertNoThrow([tracking setPollingDisabled]);
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

#pragma mark (void) __attribute__((deprecated(""))) startPolling;

/**
 目的：非推奨のstartPollingをVrInteractiveTrackingのインスタンス化直後に叩いてもエラーが起きないかを確認する
 */
- (void)testStartPollingNormalBeforeInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testStartPollingNormalBeforeInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提：VrInteractiveTrackingのインスタンス化を行なっている
    // 想定：エラーが起きないかを確認
    XCTAssertNoThrow([tracking startPolling]);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：非推奨のstartPollingをVrInteractiveTrackingの初期化コールバックの中で叩いてもエラーが起きないかを確認する
 */
- (void)testStartPollingNormalAfterInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testStartPollingNormalAfterInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：VrInteractiveTrackingのインスタンス化を行なっている/初期化コールバックが返ってきている
        // 想定：エラーが起きないかを確認
        XCTAssertNoThrow([tracking startPolling]);
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (void) __attribute__((deprecated(""))) startPolling:(NSTimeInterval)pollingInterval;

/**
 目的：非推奨のstartPolling(interval)をVrInteractiveTrackingのインスタンス化直後に叩いてもエラーが起きないかを確認する
 */
- (void)testStartPollingWithIntervalNormalBeforeInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testStartPollingWithIntervalNormalBeforeInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提：VrInteractiveTrackingのインスタンス化を行なっている
    // 想定：エラーが起きないかを確認
    XCTAssertNoThrow([tracking startPolling:5]);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：非推奨のstartPolling(interval)をVrInteractiveTrackingの初期化コールバックの中で叩いてもエラーが起きないかを確認する
 */
- (void)testStartPollingWithIntervalNormalAfterInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testStartPollingWithIntervalNormalAfterInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：VrInteractiveTrackingのインスタンス化を行なっている/初期化コールバックが返ってきている
        // 想定：エラーが起きないかを確認
        XCTAssertNoThrow([tracking startPolling:5]);
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (void) __attribute__((deprecated(""))) stopPolling;


/**
 目的：非推奨のstopPollingをVrInteractiveTrackingのインスタンス化直後に叩いてもエラーが起きないかを確認する
 */
- (void)testStopPollingNormalBeforeInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testStopPollingNormalBeforeInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提：VrInteractiveTrackingのインスタンス化を行なっている
    // 想定：エラーが起きないかを確認
    XCTAssertNoThrow([tracking stopPolling]);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：非推奨のstopPollingをVrInteractiveTrackingの初期化コールバックの中で叩いてもエラーが起きないかを確認する
 */
- (void)testStopPollingNormalAfterInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testStopPollingNormalAfterInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：VrInteractiveTrackingのインスタンス化を行なっている/初期化コールバックが返ってきている
        // 想定：エラーが起きないかを確認
        XCTAssertNoThrow([tracking stopPolling]);
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (BOOL) __attribute__((deprecated(""))) isDuringPolling;


/**
 目的：非推奨のisDuringPollingをVrInteractiveTrackingのインスタンス化直後に叩いてもNOが返ってくるかを確認する
 */
- (void)testIsDuringPollingNormalBeforeInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testIsDuringPollingNormalBeforeInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提：VrInteractiveTrackingのインスタンス化を行なっている
    // 想定：NOが返ってくるかを確認
    XCTAssertTrue([tracking isDuringPolling] == NO);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：非推奨のisDuringPollingをVrInteractiveTrackingの初期化コールバックの中で叩いてもNOが返ってくるかを確認する
 */
- (void)testIsDuringPollingNormalAfterInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testIsDuringPollingNormalAfterInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：VrInteractiveTrackingのインスタンス化を行なっている/初期化コールバックが返ってきている
        // 想定：NOが返ってくるかを確認
        XCTAssertTrue([tracking isDuringPolling] == NO);
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

#pragma mark (BOOL) __attribute__((deprecated(""))) isPollingEnabled;


/**
 目的：非推奨のisPollingEnabledをVrInteractiveTrackingのインスタンス化直後に叩いてもNOが返ってくるかを確認する
 */
- (void)testIsPollingEnabledNormalBeforeInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testIsDuringPollingNormalBeforeInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提：VrInteractiveTrackingのインスタンス化を行なっている
    // 想定：NOが返ってくるかを確認
    XCTAssertTrue([tracking isPollingEnabled] == NO);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：非推奨のisPollingEnabledをVrInteractiveTrackingの初期化コールバックの中で叩いてもNOが返ってくるかを確認する
 */
- (void)testIsPollingEnabledNormalAfterInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testIsDuringPollingNormalAfterInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：VrInteractiveTrackingのインスタンス化を行なっている/初期化コールバックが返ってきている
        // 想定：NOが返ってくるかを確認
        XCTAssertTrue([tracking isPollingEnabled] == NO);
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (void) __attribute__((deprecated(""))) customConfigParamWithTag:(NSString *)tag withUrl:(NSString *)url finishLoadCustomConfigBlock:(FinishLoadCustomConfigBlock)finishReloadCustomConfig;

/**
 目的：非推奨のcustomConfigParamWithTagをVrInteractiveTrackingのインスタンス化直後に叩いてもエラーが起きないかを確認する
 */
- (void)testCustomConfigParamWithTagNormalBeforeInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testCustomConfigParamWithTagNormalBeforeInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提：VrInteractiveTrackingのインスタンス化を行なっている
    // 想定：エラーが起きないかを確認
    XCTAssertNoThrow([tracking customConfigParamWithTag:@"tag?" withUrl:@"url" finishLoadCustomConfigBlock:^(NSString *param, int result) {
        // 想定：paramがnilであることを確認
        XCTAssertNil(param);
        // 想定：reulutが0であることを確認
        XCTAssertTrue(result == 0);
    }]);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：非推奨のcustomConfigParamWithTagをVrInteractiveTrackingの初期化コールバックの中で叩いてもエラーが起きないかを確認する
 */
- (void)testCustomConfigParamWithTagNormalAfterInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testCustomConfigParamWithTagNormalAfterInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：VrInteractiveTrackingのインスタンス化を行なっている/初期化コールバックが返ってきている
        // 想定：エラーが起きないかを確認
        XCTAssertNoThrow([tracking customConfigParamWithTag:@"tag?" withUrl:@"url" finishLoadCustomConfigBlock:^(NSString *param, int result) {
            // 想定：paramがnilであることを確認
            XCTAssertNil(param);
            // 想定：reulutが0であることを確認
            XCTAssertTrue(result == 0);
            
            [expectation fulfill];
        }]);
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (BOOL) __attribute__((deprecated(""))) isServerConfigSetting;

/**
 目的：非推奨のisServerConfigSettingをVrInteractiveTrackingのインスタンス化直後に叩いてもNOが返ってくるかを確認する
 */
- (void)testIsServerConfigSettingNormalBeforeInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testIsServerConfigSettingNormalBeforeInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提：VrInteractiveTrackingのインスタンス化を行なっている
    // 想定：NOが返ってくるかを確認
    XCTAssertTrue([tracking isServerConfigSetting] == NO);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：非推奨のisServerConfigSettingをVrInteractiveTrackingの初期化コールバックの中で叩いてもNOが返ってくるかを確認する
 */
- (void)testIsServerConfigSettingNormalAfterInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testIsServerConfigSettingNormalAfterInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：VrInteractiveTrackingのインスタンス化を行なっている/初期化コールバックが返ってきている
        // 想定：NOが返ってくるかを確認
        XCTAssertTrue([tracking isServerConfigSetting] == NO);
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (NSDate *) __attribute__((deprecated(""))) configAcquisitionTime;


/**
 目的：非推奨のconfigAcquisitionTimeをVrInteractiveTrackingのインスタンス化直後に叩いてもnilが返ってくるかを確認する
 */
- (void)testConfigAcquisitionTimeNormalBeforeInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testConfigAcquisitionTimeNormalBeforeInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提：VrInteractiveTrackingのインスタンス化を行なっている
    // 想定：nilが返ってくるかを確認
    XCTAssertNil([tracking configAcquisitionTime]);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：非推奨のconfigAcquisitionTimeをVrInteractiveTrackingの初期化コールバックの中で叩いてもNOが返ってくるかを確認する
 */
- (void)testConfigAcquisitionTimeNormalAfterInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testConfigAcquisitionTimeNormalAfterInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：VrInteractiveTrackingのインスタンス化を行なっている/初期化コールバックが返ってきている
        // 想定：nilが返ってくるかを確認
        XCTAssertNil([tracking configAcquisitionTime]);
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

#pragma mark (int) __attribute__((deprecated(""))) elapsedTimeFromConfigAcquisition;

/**
 目的：非推奨のelapsedTimeFromConfigAcquisitionをVrInteractiveTrackingのインスタンス化直後に叩いても0が返ってくるかを確認する
 */
- (void)testElapsedTimeFromConfigAcquisitionNormalBeforeInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testElapsedTimeFromConfigAcquisitionNormalBeforeInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提：VrInteractiveTrackingのインスタンス化を行なっている
    // 想定：0が返ってくるかを確認
    XCTAssertTrue([tracking elapsedTimeFromConfigAcquisition] == 0);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：非推奨のelapsedTimeFromConfigAcquisitionをVrInteractiveTrackingの初期化コールバックの中で叩いてもNOが返ってくるかを確認する
 */
- (void)testElapsedTimeFromConfigAcquisitionNormalAfterInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testElapsedTimeFromConfigAcquisitionNormalAfterInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：VrInteractiveTrackingのインスタンス化を行なっている/初期化コールバックが返ってきている
        // 想定：0が返ってくるかを確認
        XCTAssertTrue([tracking elapsedTimeFromConfigAcquisition] == 0);
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

#pragma mark (void) __attribute__((deprecated(""))) reloadConfig;

/**
 目的：非推奨のreloadConfigをVrInteractiveTrackingのインスタンス化直後に叩いてもNOが返ってくるかを確認する
 */
- (void)testReloadConfigNormalBeforeInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testReloadConfigNormalBeforeInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提：VrInteractiveTrackingのインスタンス化を行なっている
    // 想定：エラーが起きないかを確認
    XCTAssertNoThrow([tracking reloadConfig]);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：非推奨のreloadConfigをVrInteractiveTrackingの初期化コールバックの中で叩いてもNOが返ってくるかを確認する
 */
- (void)testReloadConfigNormalAfterInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testReloadConfigNormalAfterInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：VrInteractiveTrackingのインスタンス化を行なっている/初期化コールバックが返ってきている
        // 想定：エラーが起きないかを確認
        XCTAssertNoThrow([tracking reloadConfig]);
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
#pragma mark (void) __attribute__((deprecated(""))) reloadConfig:(FinishReloadBlock)finishReloadBlock;

/**
 目的：非推奨のreloadConfig(コールバック)をVrInteractiveTrackingのインスタンス化直後に叩いてもNOが返ってくるかを確認する
 */
- (void)testReloadConfigWithCallbackNormalBeforeInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testReloadConfigWithCallbackNormalBeforeInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提：VrInteractiveTrackingのインスタンス化を行なっている
    // 想定：エラーが起きないかを確認
    XCTAssertNoThrow([tracking reloadConfig:^(BOOL result) {
        // 想定：NOが返ってくるかを確認
        XCTAssertTrue(result == NO);
    }]);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：非推奨のreloadConfig(コールバック)をVrInteractiveTrackingの初期化コールバックの中で叩いてもNOが返ってくるかを確認する
 */
- (void)testReloadConfigWithCallbackNormalAfterInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testReloadConfigWithCallbackNormalAfterInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：VrInteractiveTrackingのインスタンス化を行なっている/初期化コールバックが返ってきている
        // 想定：エラーが起きないかを確認
        XCTAssertNoThrow([tracking reloadConfig:^(BOOL result) {
            // 想定：NOが返ってくるかを確認
            XCTAssertTrue(result == NO);
            
            [expectation fulfill];
        }]);
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
#pragma mark (long) __attribute__((deprecated(""))) beaconlogCount;

/**
 目的：非推奨のbeaconlogCountをVrInteractiveTrackingのインスタンス化直後に叩いてもNOが返ってくるかを確認する
 */
- (void)testBeaconlogCountNormalBeforeInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testBeaconlogCountNormalBeforeInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提：VrInteractiveTrackingのインスタンス化を行なっている
    // 想定：0が返ってくるかを確認
    XCTAssertTrue([tracking beaconlogCount] == 0);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：非推奨のbeaconlogCountをVrInteractiveTrackingの初期化コールバックの中で叩いてもNOが返ってくるかを確認する
 */
- (void)testBeaconlogCountNormalAfterInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testBeaconlogCountNormalAfterInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：VrInteractiveTrackingのインスタンス化を行なっている/初期化コールバックが返ってきている
        // 想定：0が返ってくるかを確認
        XCTAssertTrue([tracking beaconlogCount] == 0);
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (void) __attribute__((deprecated(""))) beaconlogCount:(FinishBeaconlogCountBlock)finishBeaconlogCountBlock;

/**
 目的：非推奨のbeaconlogCount(コールバック)をVrInteractiveTrackingのインスタンス化直後に叩いてもNOが返ってくるかを確認する
 */
- (void)testBeaconlogCountWithCallbackNormalBeforeInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testBeaconlogCountWithCallbackNormalBeforeInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提：VrInteractiveTrackingのインスタンス化を行なっている
    // 想定：NOが返ってくるかを確認
    XCTAssertNoThrow([tracking beaconlogCount:^(long result) {
        // 想定：0が返ってくるかを確認
        XCTAssertTrue(result == 0);
    }]);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
/**
 目的：非推奨のbeaconlogCount(コールバック)をVrInteractiveTrackingの初期化コールバックの中で叩いてもNOが返ってくるかを確認する
 */
- (void)testBeaconlogCountWithCallbackNormalAfterInitCallback {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testBeaconlogCountWithCallbackNormalAfterInitCallback"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：VrInteractiveTrackingのインスタンス化を行なっている/初期化コールバックが返ってきている
        // 想定：NOが返ってくるかを確認
        XCTAssertNoThrow([tracking beaconlogCount:^(long result) {
            // 想定：0が返ってくるかを確認
            XCTAssertTrue(result == 0);
            
            [expectation fulfill];
        }]);
        
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


@end
