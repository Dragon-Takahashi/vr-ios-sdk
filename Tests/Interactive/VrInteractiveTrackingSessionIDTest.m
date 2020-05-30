//
//  VrInteractiveTrackingSessionIDTest.m
//  Tests
//
//  Created by 髙橋和成 on 3/15/20.
//  Copyright © 2020 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "../../VrInteractiveTracking/VrInteractiveData.h"
#import "../../VrInteractiveTracking/VrInteractiveTracking.h"
#import "VrInteractiveTrackingStub.h"
#import "../../VrInteractiveTracking/Domain/Opt.h"

@interface VrInteractiveTrackingSessionIDTest : XCTestCase
@end

@implementation VrInteractiveTrackingSessionIDTest

- (void)setUp {
    [super setUp];
    [VrInteractiveTrackingStub initConfig];
    [Opt in];
}

- (void)tearDown {
    [super tearDown];
}

/**
 * 目的：セッションIDを取得した際に、空文字やnullではないこと
 * メソッドを呼び出すごとに新規作成されることを確認する
 */
- (void)testGetSessionIdEnableStrategy {
    
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking = [data withClass:self withAppName:@"appName" withEventName:@"eventName" withMonitorId:@"monitorId"];

    // 前提：セッションIDを初期化している
    // 想定：セッションIDが空文字またはnullでないことを確認
    XCTAssertFalse([@"" isEqual:tracking.getSessionID]);
    XCTAssertNotNil(tracking.getSessionID);
    

    // 前提：セッションIDを初期化している
    // 想定：セッションID取得を呼び出すことに新規作成されることを確認
    XCTAssertNotEqual(tracking.getSessionID, tracking.getSessionID);
}

/**
 * 目的：インスタンス無効化フラグがFalseの場合
 * セッションIDを呼び出しを行ってもNULLが返却されることを確認する
 */
- (void)testGetSessionIdDisableStrategy {
    
    VrInteractiveData *data = [VrInteractiveData sharedInstance];
    VrInteractiveTracking *tracking = [data withClass:self withAppName:@"appName" withEventName:@"eventName" withMonitorId:@"monitorId" withOptFlg:NO withOutsideConfigURL:@""];

    // 前提：セッションIDを初期化している
    // 想定：セッションIDがnullであることを確認
    XCTAssertFalse([@"" isEqual:tracking.getSessionID]);
    XCTAssertNil(tracking.getSessionID);
}

@end
