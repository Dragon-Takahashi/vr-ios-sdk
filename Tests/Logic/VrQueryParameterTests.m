//
//  VrQueryParameterTests.m
//  Tests
//
//  Created by 髙橋和成 on 2/3/21.
//  Copyright © 2021 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../../VrInteractiveTracking/VrInteractiveTrackingSpec.h"
#import "../../VrInteractiveTracking/VrInteractiveBeaconSpec.h"
#import "../../VrInteractiveTracking/Logic/VrQueryParameter.h"
#import "../../VrInteractiveTracking/Domain/Config/ConfigFile.h"
#import "../../VrInteractiveTracking/Domain/Model/QueryParameters.h"

@interface VrQueryParameterTests : XCTestCase

@end

@implementation VrQueryParameterTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

#pragma mark - (QueryParameters *)toQueryParametersWithVrInteractiveTrackingSpec:(VrInteractiveTrackingSpec *)trackingSpec beaconSpec:(VrInteractiveBeaconSpec *)beaconSpec


/**
 目的：セットしたSpecをもとに正しくQueryParameterが設定されるか確認する
 */
- (void)testInitNormal {
    QueryParameters *params = [[VrQueryParameter alloc] toQueryParametersWithVrInteractiveTrackingSpec:[self getTrackingSpec] beaconSpec:[self getBeaconSpecMin]];
    NSLog(@"%@", [params getValue:@"url"].value);
    NSLog(@"%@", [params getValue:@"vr_opt10"].value);
    NSLog(@"%@", [params getValue:@"vr_opt13"].value);
    NSLog(@"%@", [params getValue:@"vr_tid"].value);
    
    
    // 前提：空のBeaconSpecを使用
    // 想定：TrackingSpecの値が設定されている
    XCTAssertTrue([@"tracking_event" isEqual:[params getValue:@"url"].value]);
    XCTAssertTrue([@"1" isEqual:[params getValue:@"vr_opt10"].value]);
    XCTAssertNotNil([params getValue:@"vr_opt11"].value);
    XCTAssertNotNil([params getValue:@"vr_opt12"].value);
    XCTAssertTrue([@"test_app,VrTrackingSDK6.0" isEqual:[params getValue:@"vr_opt13"].value]);
    XCTAssertTrue([@"tracking_monitor_id" isEqual:[params getValue:@"vr_tid"].value]);
    
}

/**
 目的：セットしたSpecをもとに正しくQueryParameterが設定されるか確認する（Override）
 */
- (void)testInitOverride {
    QueryParameters *params = [[VrQueryParameter alloc] toQueryParametersWithVrInteractiveTrackingSpec:[self getTrackingSpec] beaconSpec:[self getBeaconSpecMax]];
    NSLog(@"%@", [params getValue:@"url"].value);
    NSLog(@"%@", [params getValue:@"vr_opt10"].value);
    NSLog(@"%@", [params getValue:@"vr_opt13"].value);
    NSLog(@"%@", [params getValue:@"vr_tid"].value);
    
    
    // 前提：値の入っているのBeaconSpecを使用
    // 想定：BeaconSpecの値が設定されている
    XCTAssertTrue([@"beacon_event" isEqual:[params getValue:@"url"].value]);
    XCTAssertTrue([@"1" isEqual:[params getValue:@"vr_opt10"].value]);
    XCTAssertNotNil([params getValue:@"vr_opt11"].value);
    XCTAssertNotNil([params getValue:@"vr_opt12"].value);
    XCTAssertTrue([@"test_app,VrTrackingSDK6.0" isEqual:[params getValue:@"vr_opt13"].value]);
    XCTAssertTrue([@"beacon_monitor_id" isEqual:[params getValue:@"vr_tid"].value]);
    
}

#pragma mark - (QueryParameters *)toQueryParametersWithConfigFile:(ConfigFile *)config

/**
 目的：セットしたSpecをもとに正しくQueryParameterが設定されるか確認する（Override）
 */
- (void)testInitViaConfig {
    QueryParameters *params = [[VrQueryParameter alloc] toQueryParametersWithConfigFile:[self getConfig]];
    NSLog(@"%@", [params getValue:@"vr_tagid1"].value);
    NSLog(@"%@", [params getValue:@"vr_tagid2"].value);
    NSLog(@"%@", [params getValue:@"id1"].value);
    
    // 前提：テスト用の設定ファイルを読み込んでいる
    // 想定：設定ファイルの値が設定されている
    XCTAssertTrue([@"test_tag1" isEqual:[params getValue:@"vr_tagid1"].value]);
    XCTAssertTrue([@"test_tag2" isEqual:[params getValue:@"vr_tagid2"].value]);
    XCTAssertNotNil([params getValue:@"id1"].value);
    
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
    [config setVr_TagId1:@"test_tag1"];
    [config setVr_TagId2:@"test_tag2"];
    return config;
}

@end
