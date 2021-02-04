//
//  VQueryParameter.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2/3/21.
//  Copyright © 2021 VideoResearch. All rights reserved.
//

#import "VQueryParameter.h"

@interface VQueryParameter()

@property (nonatomic) Counter *counter;

@end

NSString *const VR_TRACKING_SDK_VERSION = @"VrTrackingSDK6.0";

@implementation VQueryParameter

- (instancetype)init
{
    self = [super init];
    if (self) {
        _counter = [Counter new];
    }
    return self;
}


- (QueryParameters *)toQueryParametersWithVrInteractiveTrackingSpec:(VrInteractiveTrackingSpec *)trackingSpec
                                                         beaconSpec:(VrInteractiveBeaconSpec *)beaconSpec
                                                          sessionID:(SessionID *)sessionID {
    QueryParameters *parameters = [QueryParameters new];
    
    // アプリバージョン
    [parameters add:@"dcosver" value:[self getOSInfo]];
    // 連番
    [parameters add:@"seq" value:[self getSendIndex]];
    // アプリ名称
    [parameters add:@"vrsdk" value:[NSString stringWithFormat:@"%@,%@",trackingSpec.appName, VR_TRACKING_SDK_VERSION]];
    // luid
    [parameters add:@"luid" value:[UUID load]];
    // seid
    [parameters add:@"seid" value:[sessionID getSessionID]];
    
    
    return parameters;
}


- (QueryParameters *)toQueryParametersWithConfigFile:(ConfigFile *)config {
    
     QueryParameters *parameters = [QueryParameters new];
    
    // a
    [parameters add:@"a" value:[config getA]];
    // dcos
    [parameters add:@"dcos" value:[config getDcos]];
    
    return parameters;
}




/**
 連番を取得（加算処理含む）
 
 @return 連番
 */
- (NSString *)getSendIndex {
    if (!_counter) {
        _counter = [Counter new];
    }
    [_counter increment];
    // 返却
    return [NSString stringWithFormat:@"%lld", _counter.getValue];
}

/**
 送信日時を取得
 
 @return 現在時刻
 */
- (NSString *)getDate {
    NSTimeInterval timestamp = [[NSDate date]timeIntervalSince1970];
    int unixTime = floor(timestamp);
    return [NSString stringWithFormat:@"%d", unixTime];
}

/**
 OS情報を取得
 
 @return OS情報の文字列
 */
- (NSString *)getOSInfo {
    NSArray *versionArray = [[[UIDevice currentDevice]systemVersion]componentsSeparatedByString:@"."];
    int majorVersion = [[versionArray objectAtIndex:0]intValue];
    int minorVersion = [[versionArray objectAtIndex:1]intValue];
    return [NSString stringWithFormat:@"iOS%d.%d",majorVersion,minorVersion];
}


@end
