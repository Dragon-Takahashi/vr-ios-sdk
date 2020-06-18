//
//  VrInteractiveTrackingTestsForOptOut.m
//  Tests
//
//  Created by 髙橋和成 on 12/16/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "VrInteractiveTrackingStub.h"
#import "../../VrInteractiveTracking/VrInteractiveData.h"
#import "../../VrInteractiveTracking/Domain/Model/OptValues.h"

@interface VrInteractiveTrackingTestsForOptOut : XCTestCase

@end

@implementation VrInteractiveTrackingTestsForOptOut

- (void)setUp {
    [super setUp];
    
    [VrInteractiveTrackingStub initConfig];
    [VrInteractiveTrackingStub forceOptOut];
}

- (void)tearDown {
    [VrInteractiveTrackingStub forceOptIn];
    [super tearDown];
}

- (void)testInitForOptOut {
    
}



#pragma mark (id)initWithAppName:(NSString *)appName eventName:(NSString *)eventName monitorId:(NSString *)monitorId;

/**
 目的：オプトアウトしている状態で、初期化したインスタンスがエラーなく実行されているかを確認する
 */
- (void)testInitWithAppNameNormal {
    VrInteractiveTracking *tracking = [[VrInteractiveTracking alloc] initWithAppName:@"test_app_name" eventName:@"test_event_name" monitorId:@"test_monitor_id"];
    
    // 前提：ユーザーがオプトアウトしている。初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
}


/**
 目的：オプトアウトしている状態で、初期化時の引数にnullを入れた場合でも、インスタンが生成されることを確認する
 */
- (void)testInitWithAppNameIrregularNull {
    VrInteractiveTracking *tracking = [[VrInteractiveTracking alloc] initWithAppName:nil eventName:nil monitorId:nil];
    
    // 前提：ユーザーがオプトアウトしている。初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
}

/**
 目的：オプトアウトしている状態で、初期化時の引数に空文字を入れた場合でも、インスタンが生成されることを確認する
 */
- (void)testInitWithAppNameIrregularEmpty {
    VrInteractiveTracking *tracking = [[VrInteractiveTracking alloc] initWithAppName:@"" eventName:@"" monitorId:@""];
    
    // 前提：ユーザーがオプトアウトしている。初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
}

/**
 目的：オプトアウトしている状態で、２つのインスタンが別のインスタンスであることを確認する
 */
- (void)testInitWithAppNameIrregularEquivalence {
    VrInteractiveTracking *tracking1 = [[VrInteractiveTracking alloc] initWithAppName:@"test_app_name1" eventName:@"test_event_name1" monitorId:@"test_monitor_id1"];
    VrInteractiveTracking *tracking2 = [[VrInteractiveTracking alloc] initWithAppName:@"test_app_name2" eventName:@"test_event_name2" monitorId:@"test_monitor_id2"];
    
    // 前提：ユーザーがオプトアウトしている。２つのインスタンスが初期化が完了している
    // 想定：tracking1とtracking2が同じインスタンスではないことを確認
    XCTAssertTrue(tracking1 != tracking2);
}


#pragma mark (id)initWithTracker:(NSString *)class withAppName:(NSString *)appName withEventName:(NSString *)eventName withMonitorId:(NSString *)monitorId;

/**
 目的：オプトアウトしている状態で、初期化したインスタンスがエラーなく実行されているかを確認する
 */
- (void)testInitWithTracker1Normal {
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id"];
    
    // 前提：ユーザーがオプトアウトしている。初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
    
}

/**
 目的：オプトアウトしている状態で、初期化時の引数にnullを入れた場合でも、インスタンが生成されることを確認する
 */
- (void)testInitWithTracker1IrregularNull {
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking = [data withClass:self withAppName:nil withEventName:nil withMonitorId:nil];
    
    // 前提：ユーザーがオプトアウトしている。初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
}

/**
 目的：オプトアウトしている状態で、初期化時の引数に空文字を入れた場合でも、インスタンが生成されることを確認する
 */
- (void)testInitWithTracker1IrregularEmpty {
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking = [data withClass:self withAppName:@"" withEventName:@"" withMonitorId:@""];
    
    // 前提：ユーザーがオプトアウトしている。初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
}

/**
 目的：オプトアウトしている状態で、２つのインスタンが別のインスタンスであることを確認する
 */
- (void)testInitWithTracker1IrregularEquivalence {
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking1 = [data withClass:self withAppName:@"test_app_name1" withEventName:@"test_event_name1" withMonitorId:@"test_monitor_id1"];
    VrInteractiveTracking *tracking2 = [data withClass:self withAppName:@"test_app_name2" withEventName:@"test_event_name2" withMonitorId:@"test_monitor_id2"];
    
    // 前提：ユーザーがオプトアウトしている。２つのインスタンスが初期化が完了している
    // 想定：tracking1とtracking2が同じインスタンスではないことを確認
    XCTAssertTrue(tracking1 != tracking2);
}



#pragma mark (id)initWithTracker:(NSString *)class withAppName:(NSString *)appName withEventName:(NSString *)eventName withMonitorId:(NSString *)monitorId finishInitBlock:(FinishInitBlock)finishInitBlock;


/**
 目的：オプトアウトしている状態で、初期化したインスタンスがエラーなく実行されているかを確認する
 */
- (void)testInitWithTracker2Normal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：ユーザーがオプトアウトしている。初期化が完了している
        // 想定：初期化コールバック結果がtrueであることを確認
        XCTAssertTrue(result);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：オプトアウトしている状態で、初期化時の引数にnullを入れた場合でも、インスタンが生成されることを確認する
 */
- (void)testInitWithTracker2IrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:nil withEventName:nil withMonitorId:nil finishInitBlock:^(BOOL result) {
        
        // 前提：ユーザーがオプトアウトしている。初期化が完了している
        // 想定：初期化コールバック結果がtrueであることを確認
        XCTAssertTrue(result);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
    
}

/**
 目的：オプトアウトしている状態で、初期化時の引数に空文字を入れた場合でも、インスタンが生成されることを確認する
 */
- (void)testInitWithTracker2IrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    [data withClass:self withAppName:@"" withEventName:@"" withMonitorId:@"" finishInitBlock:^(BOOL result) {
        
        // 前提：ユーザーがオプトアウトしている。初期化が完了している
        // 想定：初期化コールバック結果がtrueであることを確認
        XCTAssertTrue(result);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：オプトアウトしている状態で、２つのインスタンが別のインスタンスであることを確認する
 */
- (void)testInitWithTracker2IrregularEquivalence {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking1;
    tracking1 = [data withClass:self withAppName:@"test_app_name1" withEventName:@"test_event_name1" withMonitorId:@"test_monitor_id1" finishInitBlock:^(BOOL result) {
        
        // 前提：ユーザーがオプトアウトしている。初期化が完了している
        // 想定：初期化コールバック結果がtrueであることを確認
        XCTAssertTrue(result);
        
        //        [expectation fulfill];
    }];
    __block VrInteractiveTracking *tracking2;
    tracking2 = [data withClass:self withAppName:@"test_app_name2" withEventName:@"test_event_name2" withMonitorId:@"test_monitor_id2" finishInitBlock:^(BOOL result) {
        
        // 前提：ユーザーがオプトアウトしている。初期化が完了している
        // 想定：初期化コールバック結果がtrueであることを確認
        XCTAssertTrue(result);
        
        [expectation fulfill];
    }];
    
    // 前提：ユーザーがオプトアウトしている。２つのインスタンスが初期化が完了している
    // 想定：tracking1とtracking2が同じインスタンスではないことを確認
    XCTAssertTrue(tracking1 != tracking2);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}




#pragma mark (id)initWithTracker:(NSString *)class withAppName:(NSString *)appName withEventName:(NSString *)eventName withMonitorId:(NSString *)monitorId withOptFlg:(BOOL)optFlg withOutsideConfigURL:(NSString *)outsideConfigURL;


/**
 目的：オプトアウトしている状態で、初期化したインスタンスがエラーなく実行されているかを確認する
 */
- (void)testInitWithTracker3Normal {
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" withOptFlg:YES withOutsideConfigURL:@"http://config.jp/"];
    
    // 前提：ユーザーがオプトアウトしている。初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
    
}

/**
 目的：オプトアウトしている状態で、初期化したインスタンスのインスタンスフラグがNOの場合でもインスタンスが生成できているかを確認
 */
- (void)testInitWithTracker3NormalOptflagNO {
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" withOptFlg:NO withOutsideConfigURL:@"http://config.jp/"];
    
    // 前提：ユーザーがオプトアウトしている。初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
}

/**
 目的：オプトアウトしている状態で、初期化時の引数にnullを入れた場合でも、インスタンが生成されることを確認する
 */
- (void)testInitWithTracker3IrregularNull {
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking = [data withClass:self withAppName:nil withEventName:nil withMonitorId:nil withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提：ユーザーがオプトアウトしている。初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
}

/**
 目的：オプトアウトしている状態で、初期化時の引数に空文字を入れた場合でも、インスタンが生成されることを確認する
 */
- (void)testInitWithTracker3IrregularEmpty {
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking = [data withClass:self withAppName:@"" withEventName:@"" withMonitorId:@"" withOptFlg:YES withOutsideConfigURL:@""];
    
    // 前提：ユーザーがオプトアウトしている。初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
}

/**
 目的：オプトアウトしている状態で、２つのインスタンが別のインスタンスであることを確認する
 */
- (void)testInitWithTracker3IrregularEquivalence {
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking1 = [data withClass:self withAppName:@"test_app_name1" withEventName:@"test_event_name1" withMonitorId:@"test_monitor_id1" withOptFlg:YES withOutsideConfigURL:nil];
    VrInteractiveTracking *tracking2 = [data withClass:self withAppName:@"test_app_name2" withEventName:@"test_event_name2" withMonitorId:@"test_monitor_id2" withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提：ユーザーがオプトアウトしている。２つのインスタンスが初期化が完了している
    // 想定：tracking1とtracking2が同じインスタンスではないことを確認
    XCTAssertTrue(tracking1 != tracking2);
}


/**
 目的：オプトアウトしている状態で、不正な設定ファイルのURLを設定した場合でも、インスタンスが生成できているかを確認する
 */
- (void)testInitWithTracker3IrregularWrongURL {
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" withOptFlg:YES withOutsideConfigURL:@"ht://config.jp/"];
    
    // 前提：ユーザーがオプトアウトしている。初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
}



#pragma mark (id)initWithTracker:(NSString *)class withAppName:(NSString *)appName withEventName:(NSString *)eventName withMonitorId:(NSString *)monitorId finishInitBlock:(FinishInitBlock)finishInitBlock withOptFlg:(BOOL)optFlg withOutsideConfigURL:(NSString *)outsideConfigURL;

/**
 目的：オプトアウトしている状態で、初期化したインスタンスがエラーなく実行されているかを確認する
 */
- (void)testInitWithTracker4Normal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：ユーザーがオプトアウトしている。初期化が完了している
        // 想定：初期化コールバック結果がtrueであることを確認
        XCTAssertTrue(result);
        
        [expectation fulfill];
    } withOptFlg:YES withOutsideConfigURL:@"http://config.jp/"];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：オプトアウトしている状態で、初期化したインスタンスがインスタンスフラグがNOの場合でも生成できているかを確認する
 */
- (void)testInitWithTracker4NormalOptflagNO {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：ユーザーがオプトアウトしている。OptflgがNoで初期化が完了している
        // 想定：初期化コールバック結果がfalseであることを確認
        XCTAssertFalse(result);
        
        [expectation fulfill];
    } withOptFlg:NO withOutsideConfigURL:@"http://config.jp/"];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：オプトアウトしている状態で、初期化時の引数にnullを入れた場合でも、インスタンが生成されることを確認する
 */
- (void)testInitWithTracker4IrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    @try {
        __block VrInteractiveTracking *tracking;
        tracking = [data withClass:self withAppName:nil withEventName:nil withMonitorId:nil finishInitBlock:^(BOOL result) {
            
            // 前提：ユーザーがオプトアウトしている。初期化が完了している
            // 想定：初期化コールバック結果がtrueであることを確認
            XCTAssertTrue(result);
            
            [expectation fulfill];
        } withOptFlg:YES withOutsideConfigURL:nil];
        
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
        XCTFail(@"%@", [exception reason]);
    }
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：オプトアウトしている状態で、初期化時の引数に空文字を入れた場合でも、インスタンが生成されることを確認する
 */
- (void)testInitWithTracker4IrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    @try {
        __block VrInteractiveTracking *tracking;
        tracking = [data withClass:@"" withAppName:@"" withEventName:@"" withMonitorId:@"" finishInitBlock:^(BOOL result) {
            
            // 前提：ユーザーがオプトアウトしている。初期化が完了している
            // 想定：初期化コールバック結果がtrueであることを確認
            XCTAssertTrue(result);
            
            [expectation fulfill];
        } withOptFlg:YES withOutsideConfigURL:nil];
        
        // 前提：ユーザーがオプトアウトしている。初期化が完了している
        // 想定：インスタンスがnilではないことを確認
        XCTAssertNotNil(tracking);
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
        XCTFail(@"%@", [exception reason]);
    }
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：オプトアウトしている状態で、２つのインスタンが別のインスタンスであることを確認する
 */
- (void)testInitWithTracker4IrregularEquivalence {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking1;
    tracking1 = [data withClass:self withAppName:@"test_app_name1" withEventName:@"test_event_name1" withMonitorId:@"test_monitor_id1" finishInitBlock:^(BOOL result) {
        // 前提：ユーザーがオプトアウトしている。初期化が完了している
        // 想定：初期化コールバック結果がtrueであることを確認
        XCTAssertTrue(result);
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    __block VrInteractiveTracking *tracking2;
    tracking2 = [data withClass:self withAppName:@"test_app_name2" withEventName:@"test_event_name2" withMonitorId:@"test_monitor_id2" finishInitBlock:^(BOOL result) {
        // 前提：ユーザーがオプトアウトしている。初期化が完了している
        // 想定：初期化コールバック結果がtrueであることを確認
        XCTAssertTrue(result);
        
        [expectation fulfill];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    // 前提：ユーザーがオプトアウトしている。２つのインスタンスが初期化が完了している
    // 想定：tracking1とtracking2が同じインスタンスではないことを確認
    XCTAssertTrue(tracking1 != tracking2);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：オプトアウトしている状態で、不正なURLを引数に入れた場合、初期化コールバックでNOが返ってくることを確認する。
 */
- (void)testInitWithTracker4IrregularWrongURL {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：不正なURLを使用して初期化が終了している
        // 想定：不正なURLはエラーを吐き出した上で、nilに丸められるので、初期化コールバック結果がtrueであることを確認（別途エラーを吐き出している）
        XCTAssertTrue(result);
        // 想定：コールバックが後に返されるので、初期化処理が終わっているのではnilになっていない事を確認
        XCTAssertNotNil(tracking);
        
        [expectation fulfill];
    } withOptFlg:YES withOutsideConfigURL:@"ht://config.jp/"];
    
    // 前提：ユーザーがオプトアウトしている。初期化が完了している
    // 想定：インスタンスがnilではないことを確認
    XCTAssertNotNil(tracking);
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}



#pragma mark - UUID


#pragma mark (NSString*) uuId; TODO 同値性テスト、代入テスト、

/**
 目的：オプトアウトしている状態で、UUIDを取得した際に、nilではあることを確認する
 */
- (void)testUuIdNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        NSLog(@"init block is finished : %@", result?@"YES":@"NO");
        
        // 前提：ユーザーがオプトアウトしている。UUIDを初期化している
        // 想定：UUIDがnilであることを確認
//        XCTAssertTrue([[tracking uuid] isEqualToString:@"optout"]);
        XCTAssertTrue([@"optout" isEqualToString:[tracking uuId]]);
        
        [expectation fulfill];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (void) updateUUID:(NSString*) uuid;

/**
 目的：オプトアウトしている状態で、UUIDの更新をした場合でsもエラーを吐かないことを確認する
 */
- (void)testupdateUUIDNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    @try {
        __block VrInteractiveTracking *tracking;
        tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
            
            @try {
                // 前提：ユーザーがオプトアウトしている。UUIDを"test_uuid"で上書きしている
                // 想定：エラーが発生しない事を確認
                XCTAssertNoThrow([tracking updateUUID:@"test_uuid"]);
                
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
 目的：オプトアウトしている状態でUUIDを更新した場合でもUUIDが空文字でもエラーを吐かないことを確認する
 */
- (void)testupdateUUIDIrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：ユーザーがオプトアウトしている。UUIDを空文字で上書きしている
        // 想定：エラーが発生しない事を確認
        XCTAssertNoThrow([tracking updateUUID:@""]);
        
        [expectation fulfill];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
//
/**
 目的：オプトアウトしている状態で、UUIDにnullを上書きした際にエラーを吐かないことを確認する
 */
- (void)testupdateUUIDIrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        @try {
            // 前提：ユーザーがオプトアウトしている。UUIDをnilで上書きしている
            // 想定：エラーが発生しない事を確認
            XCTAssertNoThrow([tracking updateUUID:nil]);
            
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


#pragma mark (void)replaceUUID;

/**
 目的：オプトアウトしている状態で、UUIDのUpdateを行ってもエラーを吐かないことを確認する
 */
- (void)testreplaceUUIDNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        @try {
            // 前提：ユーザーがオプトアウトしている。UUIDを削除し、新規生成している
            // 想定：エラーを吐かないことを確認
            XCTAssertNoThrow([tracking replaceUUID]);
            
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
 目的：オプトアウトしている状態で、Opt値をクリアしてもエラーを吐かないかを確認する
 */
- (void)testClearAllVrOptValueWithAppNameNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        @try {
            
            // 前提：ユーザーがオプトアウトしている。セットしたOpt値をクリアしている
            // 想定：エラーを吐かないことを確認
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


/**
 目的：オプトアウトしている状態で、opt値のクリアを複数回呼び出してもエラーが発生しないかを確認する
 */
- (void)testClearAllVrOptValueWithAppNameIrregularStress {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        @try {
            XCTAssertNotNil(tracking);
            
            // 前提：ユーザーがオプトアウトしている。何もない状態でOpt値をクリアしている
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
                // 前提：ユーザーがオプトアウトしている。"vr_opt1"〜"vr_opt20"までを登録している
                // 想定：エラーを吐かない事を確認する
                XCTAssertNoThrow([tracking setVrOptValue:value forOptId:i]);
            }
            
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
                // 前提：ユーザーがオプトアウトしている。"vr_opt1"〜"vr_opt20"までnilを登録している
                // 想定：エラーを吐かない事を確認する
                XCTAssertNoThrow([tracking setVrOptValue:nil forOptId:i]);
            }
            
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
            
            for (int i = 1; i < 21; i++) {
                // 前提：ユーザーがオプトアウトしている。"vr_opt1"〜"vr_opt20"まで空文字を登録している
                // 想定：エラーを吐かない事を確認する
                XCTAssertNoThrow([tracking setVrOptValue:@"" forOptId:i]);
            }
            
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
 目的：想定している値以上の数字を引数に指定した場合でもエラーを吐かずにnilを返すことを確認する
 */
- (void)testOptValueByIntegerIrregularHundred {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"CallApiBlocks"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        @try {
            XCTAssertNotNil(tracking);
            
            // 前提：ユーザーがオプトアウトしている。"vr_opt0"〜"vr_opt21"までを登録している
            // 想定：100を引数に指定した場合、エラーを吐かないかを確認
            XCTAssertNoThrow([tracking optValueByInteger:100]);
            
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
            
            // 前提：ユーザーがオプトアウトしている。"vr_opt0"〜"vr_opt21"までを登録している
            // 想定：nilを引数に指定した場合、エラーを吐かないかを確認
            XCTAssertNoThrow([tracking optValueByString:nil]);
            
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
            
            // 前提：ユーザーがオプトアウトしている。"vr_opt0"〜"vr_opt21"までを登録している
            // 想定：空文字を引数に指定した場合、エラーを吐かないかを確認
            XCTAssertNoThrow([tracking optValueByString:@""]);
            
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
        
        // 前提：ユーザーがオプトアウトしている。SDKの初期化がを成功している
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
        
        // 前提：ユーザーがオプトアウトしている。SDKの初期化がを成功している
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
        
        // 前提：ユーザーがオプトアウトしている。SDKの初期化がを成功している
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
        
        [tracking sendBeaconWithEventName:@"testSendBeaconNormal" monitorId:@"test_monitor_id" finishBlock:^(BOOL result) {
            // 前提：ユーザーがオプトアウトしている。ビーコンを送信している
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
            // 前提：ユーザーがオプトアウトしている。引数がnullでビーコンを送信している
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
            // 前提：ユーザーがオプトアウトしている。引数が空文字でビーコンを送信している
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
        
        // 前提：ユーザーがオプトアウトしている。SDKの初期化がを成功している
        // 想定：送信時にエラーが吐き出されないことを確認
        XCTAssertNoThrow([tracking sendBeaconWithEventName:@"testSendBeaconNormal" monitorId:@"test_monitor_id" url:@"https://panelstg.interactive-circle.jp/ver01/measure"]);
        
        [expectation fulfill];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
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
        
        // 前提：ユーザーがオプトアウトしている。SDKの初期化がを成功している
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
        
        // 前提：ユーザーがオプトアウトしている。SDKの初期化がを成功している
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
            // 前提：ユーザーがオプトアウトしている。ビーコンを送信している
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
            // 前提：ユーザーがオプトアウトしている。ビーコンを送信している
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
            // 前提：ユーザーがオプトアウトしている。ビーコンを送信している
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
        
        // 前提：ユーザーがオプトアウトしている。SDKの初期化がを成功している
        // 想定：送信時にエラーが吐き出されないことを確認
        XCTAssertNoThrow([tracking sendBeaconWithEventName:@"testSendBeaconNormal" monitorId:@"test_monitor_id" identity:@"default"]);
        
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
        
        // 前提：ユーザーがオプトアウトしている。SDKの初期化がを成功している
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
        
        // 前提：ユーザーがオプトアウトしている。SDKの初期化がを成功している
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
            // 前提：ユーザーがオプトアウトしている。ビーコンを送信している
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
            // 前提：ユーザーがオプトアウトしている。ビーコンを送信している
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
            // 前提：ユーザーがオプトアウトしている。ビーコンを送信している
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
        
        // 前提：ユーザーがオプトアウトしている。SDKの初期化がを成功している
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
        
        // 前提：ユーザーがオプトアウトしている。SDKの初期化がを成功している
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
        
        // 前提：ユーザーがオプトアウトしている。SDKの初期化がを成功している
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
            // 前提：ユーザーがオプトアウトしている。ビーコンを送信している
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
            // 前提：ユーザーがオプトアウトしている。ビーコンを送信している
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
            // 前提：ユーザーがオプトアウトしている。ビーコンを送信している
            // 想定：送信が成功したことを示すresult=trueであることを確認
            XCTAssertTrue(result == YES);
            
            [expectation fulfill];
        }];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

#pragma mark (void)sendBeaconDirect:(NSString *)directUrl;

/**
 目的：直接URLを設定するsendBeaconで送信が完了したかを確認する
 */
- (void)testSendBeaconDirectNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：ユーザーがオプトアウトしている。SDKの初期化がを成功している
        // 想定：送信時にエラーが吐き出されないことを確認
        XCTAssertNoThrow([tracking sendBeaconDirect:@"https://panelstg.interactive-circle.jp/ver01/measure?vr_tagid1=9997&vr_tagid2=1001&vr_opt1=direct_test"]);
        
        [expectation fulfill];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：直接URLを設定するsendBeaconで、引数がnullでも送信が完了したかを確認する
 */
- (void)testSendBeaconDirectIrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：ユーザーがオプトアウトしている。SDKの初期化がを成功している
        // 想定：送信時にエラーが吐き出されないことを確認
        XCTAssertNoThrow([tracking sendBeaconDirect:nil]);
        
        [expectation fulfill];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：直接URLを設定するsendBeaconで、引数が空文字でも送信が完了したかを確認する
 */
- (void)testSendBeaconDirectIrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：ユーザーがオプトアウトしている。SDKの初期化がを成功している
        // 想定：送信時にエラーが吐き出されないことを確認
        XCTAssertNoThrow([tracking sendBeaconDirect:@""]);
        
        [expectation fulfill];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

#pragma mark (void)sendBeaconDirect:(NSString *)directUrl finishBlock:(FinishSendBeaconBlock)finishBlock;

/**
 目的：直接URLを設定するsendBeaconで送信が完了したかを確認する
 */
- (void)testSendBeaconDirectCallbackNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking sendBeaconDirect:@"https://panelstg.interactive-circle.jp/ver01/measure?vr_tagid1=9997&vr_tagid2=1001&vr_opt1=direct_test" finishBlock:^(BOOL result) {
            // 前提：ユーザーがオプトアウトしている。ビーコンを送信している
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
 目的：直接URLを設定するsendBeaconで、引数がnullでも送信が失敗したかを確認する
 */
- (void)testSendBeaconDirectCallbackIrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking sendBeaconDirect:nil finishBlock:^(BOOL result) {
            // 前提：ユーザーがオプトアウトしている。ビーコンを送信している
            // 想定：送信が失敗したことを示すresult=falseであることを確認
            XCTAssertTrue(result == NO);
            
            [expectation fulfill];
        }];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


/**
 目的：直接URLを設定するsendBeaconで、引数が空文字でも送信が失敗したかを確認する
 */
- (void)testSendBeaconDirectCallbackIrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking sendBeaconDirect:@"" finishBlock:^(BOOL result) {
            // 前提：ユーザーがオプトアウトしている。ビーコンを送信している
            // 想定：送信が失敗したことを示すresult=falseであることを確認
            XCTAssertTrue(result == NO);
            
            [expectation fulfill];
        }];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (void)setForceBeaconURLStringOnce:(NSDictionary*) forceValue;

/**
 目的：設定したsendBeaconの内容を強制的に上書きできているかを確認する
 */
- (void)testSetForceBeaconURLStringOnceNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        NSDictionary *dic = @{@"vr_opt1":@"force_value_opt1",
                              @"vr_tid":@"forced_tid"
                              };
        [tracking setForceBeaconURLStringOnce:dic];
        
        [tracking sendBeaconWithEventName:@"testSendBeaconNormal" monitorId:@"test_monitor_id" finishBlock:^(BOOL result) {
            // 前提：ユーザーがオプトアウトしている。ビーコンを送信している
            // 想定：送信が成功したことを示すresult=trueであることを確認
            XCTAssertTrue(result == YES);
            
            [expectation fulfill];
        }];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

// TODO 要検討項目
/**
 目的：パラメータの値にnullが含まれている場合では、送信できないことを確認する
 */
- (void)testSetForceBeaconURLStringOnceIrregularValueNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        NSDictionary *dic = @{@"vr_opt1":@"force_value_opt1",
                              @"vr_tid":@"forced_tid",
                              @"uid":[NSNull null]
                              };
        [tracking setForceBeaconURLStringOnce:dic];
        
        [tracking sendBeaconWithEventName:@"testSendBeaconNormal" monitorId:@"test_monitor_id" finishBlock:^(BOOL result) {
            // 前提：ユーザーがオプトアウトしている。ビーコンを送信している
            // 想定：送信が失敗したことを示すresult=falseであることを確認
            XCTAssertTrue(result == NO);
            
            [expectation fulfill];
        }];
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：パラメータのキーが空文字の場合でも、エラーが発生せずに送信できるかを確認する（キーは空文字のまま。ex:"https://xxx.xxx?vr_tagid1=0000&=force_value"）
 */
- (void)testSetForceBeaconURLStringOnceIrregularKeyEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        NSDictionary *dic = @{@"vr_opt1":@"force_value_opt1",
                              @"vr_tid":@"force_tid",
                              @"":@"force_value"
                              };
        [tracking setForceBeaconURLStringOnce:dic];
        
        [tracking sendBeaconWithEventName:@"testSendBeaconNormal" monitorId:@"test_monitor_id" finishBlock:^(BOOL result) {
            // 前提：ユーザーがオプトアウトしている。ビーコンを送信している
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
 目的：パラメータの値が空文字の場合でも、設定したsendBeaconの内容を強制的に上書きできているかを確認する
 */
- (void)testSetForceBeaconURLStringOnceIrregular {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        NSDictionary *dic = @{@"vr_opt1":@"force_value_opt1",
                              @"vr_tid":@"forced_tid",
                              @"test_key":@""
                              };
        [tracking setForceBeaconURLStringOnce:dic];
        
        [tracking sendBeaconWithEventName:@"testSendBeaconNormal" monitorId:@"test_monitor_id" finishBlock:^(BOOL result) {
            // 前提：ユーザーがオプトアウトしている。ビーコンを送信している
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
        
        NSLog(@"testOptInNormal before %@", [tracking isOptout]?@"YES":@"NO");
        
        // 前提：ユーザーがオプトアウトしている。オプトアウトしている
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
        
        BOOL before = [tracking isOptout];
        
        // 前提：ユーザーがオプトアウトしている。オプトアウトしている
        // 想定：オプトインできていることを確認
        [tracking setOptin:^(BOOL result) {
            XCTAssertTrue(result == before);
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
        
        // 前提：ユーザーがオプトアウトしている。
        // 想定：エラーを吐かないことを確認
        XCTAssertNoThrow([tracking setOptout]);
        
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
        
        // 前提：ユーザーがオプトアウトしている。オプトインしている
        // 想定：エラーを吐かないことを確認
        [tracking setOptout:^(BOOL result) {
            XCTAssertFalse(result);
            
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
        
        // 前提：ユーザーがオプトアウトしている。"test"というidentityで設定ファイルを読み込んでいる
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
    
    // 前提：ユーザーがオプトアウトしている。"test"というidentityで設定ファイルを読み込んでいる
    // 想定：読み込みが完了するかを確認
    [tracking loadConfig:@"test" fileName:@"TestVrTrackingConfig" finishBlock:^(BOOL result) {
        XCTAssertTrue(result == YES);
        
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
        
        // 前提：ユーザーがオプトアウトしている。"test"というidentityで設定ファイルを読み込んでいる
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
        
        // 前提：ユーザーがオプトアウトしている。"test"というidentityで設定ファイルを読み込んでいる
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
            
            // 前提：ユーザーがオプトアウトしている。"test"というidentityで設定ファイルを読み込んでいる
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
            
            // 前提：ユーザーがオプトアウトしている。nilのidentityで設定ファイルを読み込んでいる
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
            
            // 前提：ユーザーがオプトアウトしている。空文字のidentityで設定ファイルを読み込んでいる
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
        
        [tracking loadConfig:@"test" fileName:@"vrTrackingConfig" finishBlock:^(BOOL result) {
            NSLog(@"isCheckedLoadConfigRunning result : %@", result?@"YES":@"NO");
            // 前提：ユーザーがオプトアウトしている。"test"というidentityで設定ファイルを読みが完了している
            // 想定：読み込みが完了しているので、isCheckedLoadConfigRunning=falseなのを確認
            XCTAssertTrue([tracking isCheckedLoadConfigRunning:@"test"] == NO);
            
            [expectation fulfill];
        }];
        // 前提：ユーザーがオプトアウトしている。"test"というidentityで設定ファイルを読み込んでいる
        // 想定：非同期にてリモート設定ファイルを読み込み中なので、isCheckedLoadConfigRunning=trueなのを確認
        XCTAssertTrue([tracking isCheckedLoadConfigRunning:@"test"] == YES);
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}
#pragma mark (NSDictionary *)configParams;


/**
 目的：読み込んだ設定ファイルの取得を行うとnilが返ってくる事を確認する
 */
- (void)testConfigParamsNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：ユーザーがオプトアウトしている。デフォルトの設定ファイルの読みが完了している
        // 想定：設定値がnilではない事を確認
        XCTAssertNotNil([tracking configParams]);
        
        [expectation fulfill];
        
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (NSDictionary *)configParams:(NSString *)identity;

/**
 目的：identityを指定しても読み込んだ設定ファイルの取得を行うとnilが返ってくる事を確認する
 */
- (void)testConfigParamsWithIdentityNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking loadConfig:@"test" fileName:@"TestVrTrackingConfig" finishBlock:^(BOOL result) {
            NSLog(@"isCheckedLoadConfigRunning result : %@", result?@"YES":@"NO");
            
            // 前提：ユーザーがオプトアウトしている。"test"というidentityで設定ファイルを読みが完了している
            // 想定：設定値がnilではない事を確認
            XCTAssertNotNil([tracking configParams:@"test"]);
            
            [expectation fulfill];
        }];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：設定ファイルの取得するキーがnilであっても設定ファイルが取得できる事を確認する
 */
- (void)testConfigParamsWithIdentityIrregularNull {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking loadConfig:@"test" fileName:@"TestVrTrackingConfig" finishBlock:^(BOOL result) {
            NSLog(@"isCheckedLoadConfigRunning result : %@", result?@"YES":@"NO");
            
            // 前提：ユーザーがオプトアウトしている。"test"というidentityで設定ファイルを読みが完了している
            // 想定：設定値がnilではない事を確認
            XCTAssertNotNil([tracking configParams:nil]);
            
            [expectation fulfill];
        }];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}

/**
 目的：設定ファイルの取得するキーが空文字であっても設定ファイルが取得できる事を確認する
 */
- (void)testConfigParamsWithIdentityIrregularEmpty {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        [tracking loadConfig:@"test" fileName:@"TestVrTrackingConfig" finishBlock:^(BOOL result) {
            NSLog(@"isCheckedLoadConfigRunning result : %@", result?@"YES":@"NO");
            
            // 前提：ユーザーがオプトアウトしている。"test"というidentityで設定ファイルを読みが完了している
            // 想定：設定値がnilでない事を確認
            XCTAssertNotNil([tracking configParams:@""]);
            
            [expectation fulfill];
        }];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}


#pragma mark (void)setConfig:(NSDictionary *)config; TODO 間違ったURL、存在しないidentity、dictionary自体がempty

/**
 目的：設定ファイルの一部だけを上書きできしようとしてもエラーが発生しない事を確認する
 */
- (void)testSetConfigNormal {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"testSendBeaconNormal"];
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    __block VrInteractiveTracking *tracking;
    tracking = [data withClass:self withAppName:@"test_app_name" withEventName:@"test_event_name" withMonitorId:@"test_monitor_id" finishInitBlock:^(BOOL result) {
        
        // 前提：ユーザーがオプトアウトしている。デフォルトの設定ファイルに"vr_tagid2"に"1002"という文字列を上書きしている
        // 想定：エラーを吐かない事を確認
        NSDictionary *override = @{@"vr_tagid2":@"1002"};
        XCTAssertNoThrow([tracking setConfig:override]);
        
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
        
        // 前提：ユーザーがオプトアウトしている。デフォルトの設定ファイルに"vr_tagid2"に空文字で上書きしている
        // 想定：エラーを吐かない事を確認
        NSDictionary *override = @{@"vr_tagid2":@""};
        XCTAssertNoThrow([tracking setConfig:override]);
        
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
        
        // 前提：ユーザーがオプトアウトしている。デフォルトの設定ファイルにnilの配列で上書きしている
        // 想定：エラーを吐かない事を確認
        XCTAssertNoThrow([tracking setConfig:nil]);
        
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
            
            // 前提：ユーザーがオプトアウトしている。"test"というidentityの設定ファイルに"vr_tagid2"に"1002"という文字列を上書きしている
            // 想定：エラーを吐かない事を確認
            NSDictionary *override = @{@"vr_tagid2":@"1001"};
            XCTAssertNoThrow([tracking setConfig:override identity:@"test"]);
            
            [expectation fulfill];
        }];
        
    } withOptFlg:YES withOutsideConfigURL:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"has error.");
    }];
}




@end
