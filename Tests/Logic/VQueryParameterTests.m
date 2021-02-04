//
//  VQueryParameterTests.m
//  Tests
//
//  Created by 髙橋和成 on 2/3/21.
//  Copyright © 2021 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../../VrInteractiveTracking/VrInteractiveTrackingSpec.h"
#import "../../VrInteractiveTracking/VrInteractiveBeaconSpec.h"
#import "../../VrInteractiveTracking/Logic/VQueryParameter.h"
#import "../../VrInteractiveTracking/Domain/Config/ConfigFile.h"
#import "../../VrInteractiveTracking/Domain/Model/QueryParameters.h"

@interface VQueryParameterTests : XCTestCase

@end

@implementation VQueryParameterTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

#pragma mark - (QueryParameters *)toQueryParametersWithVrInteractiveTrackingSpec:(VrInteractiveTrackingSpec *)trackingSpec beaconSpec:(VrInteractiveBeaconSpec *)beaconSpec sessionID:(SessionID *)sessionID


/**
 目的：セットしたSpecをもとに正しくQueryParameterが設定されるか確認する
 */
- (void)testInitNormal {
    SessionID *sessionID = [SessionID new];
    QueryParameters *params = [[VQueryParameter alloc] toQueryParametersWithVrInteractiveTrackingSpec:[self getTrackingSpec] beaconSpec:[self getBeaconSpecMin] sessionID:sessionID];
    NSLog(@"%@", [params getValue:@"dcosver"].value);
    NSLog(@"%@", [params getValue:@"seq"].value);
    NSLog(@"%@", [params getValue:@"vrsdk"].value);
    NSLog(@"%@", [params getValue:@"luid"].value);
    NSLog(@"%@", [params getValue:@"seid"].value);
    
    
    // 前提：trackingSpecとsessionIDを設定
    // 想定：Specに設定した値が設定されている
    XCTAssertNotNil([params getValue:@"dcosver"].value);
    XCTAssertTrue([@"1" isEqual:[params getValue:@"seq"].value]);
    XCTAssertTrue([@"test_app,VrTrackingSDK6.0" isEqual:[params getValue:@"vrsdk"].value]);
    XCTAssertNotNil([params getValue:@"luid"].value);
    XCTAssertTrue([[sessionID getSessionID] isEqual:[params getValue:@"seid"].value]);
    
}

#pragma mark - (QueryParameters *)toQueryParametersWithConfigFile:(ConfigFile *)config

/**
 目的：セットしたSpecをもとに正しくQueryParameterが設定されるか確認する（Override）
 */
- (void)testInitViaConfig {
    QueryParameters *params = [[VQueryParameter alloc] toQueryParametersWithConfigFile:[self getConfig]];
    NSLog(@"%@", [params getValue:@"a"].value);
    NSLog(@"%@", [params getValue:@"dcos"].value);
    
    // 前提：テスト用の設定ファイルを読み込んでいる
    // 想定：設定ファイルの値が設定されている
    XCTAssertTrue([@"12345" isEqual:[params getValue:@"a"].value]);
    XCTAssertTrue([@"ios_test" isEqual:[params getValue:@"dcos"].value]);
    
}





#pragma mark Specs

- (VrInteractiveTrackingSpec *) getTrackingSpec {
    VrInteractiveTrackingSpecBuilder *builder = [VrInteractiveTrackingSpecBuilder new];
    builder.appName = @"test_app";
    builder.eventName = @"tracking_event";
    builder.monitorId = @"tracking_monitor_id";
    return [[VrInteractiveTrackingSpec alloc] initWithBuilder: builder];
}

- (VrInteractiveBeaconSpec *) getBeaconSpecMin {
    VrInteractiveBeaconSpecBuilder *builder = [VrInteractiveBeaconSpecBuilder new];
    builder.eventName = @"";
    builder.monitorId = @"";
    return [[VrInteractiveBeaconSpec alloc] initWithBuilder:builder];
}

- (VrInteractiveBeaconSpec *) getBeaconSpecMax {
    VrInteractiveBeaconSpecBuilder *builder = [VrInteractiveBeaconSpecBuilder new];
    builder.eventName = @"beacon_event";
    builder.monitorId = @"beacon_monitor_id";
    return [[VrInteractiveBeaconSpec alloc] initWithBuilder:builder];
}

- (ConfigFile *) getConfig {
    ConfigFile *config = [ConfigFile new];
    [config setTagType:@"v"];
    [config setA:@"12345"];
    [config setDcos:@"ios_test"];
    return config;
}

@end
