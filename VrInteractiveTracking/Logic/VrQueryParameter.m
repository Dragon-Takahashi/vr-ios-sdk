//
//  VrQueryParameter.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 12/6/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "VrQueryParameter.h"

#import <UIKit/UIKit.h>
#import "../Domain/Counter.h"
#import "../Domain/UUID.h"


@interface VrQueryParameter()

@property (nonatomic) Counter *counter;

@end

NSString *const VR_TRACKING_SDK_VERSION = @"VrTrackingSDK5.2.1";

@implementation VrQueryParameter


- (instancetype)init
{
    self = [super init];
    if (self) {
        _counter = [Counter new];
    }
    return self;
}


- (QueryParameters *)toQueryParametersWithVrInteractiveTrackingSpec:(VrInteractiveTrackingSpec *)trackingSpec
                                                         beaconSpec:(VrInteractiveBeaconSpec *)beaconSpec {
    QueryParameters *parameters = [QueryParameters new];
    
    // イベント名
    [parameters add:@"url" value:[beaconSpec.eventName length]!=0?beaconSpec.eventName:trackingSpec.eventName];
    // 連番
    [parameters add:@"vr_opt10" value:[self getSendIndex]];
    // 送信日時
    [parameters add:@"vr_opt11" value:[self getDate]];
    // OS情報
    [parameters add:@"vr_opt12" value:[self getOSInfo]];
    // アプリ名称
    [parameters add:@"vr_opt13" value:[NSString stringWithFormat:@"%@,%@",trackingSpec.appName, VR_TRACKING_SDK_VERSION]];
    // モニターID
    [parameters add:@"vr_tid" value:[beaconSpec.monitorId length]!=0?beaconSpec.monitorId:trackingSpec.monitorId];
    
    
    return parameters;
}


- (QueryParameters *)toQueryParametersWithConfigFile:(ConfigFile *)config {
    
     QueryParameters *parameters = [QueryParameters new];
    
    // vr_tagid1
    [parameters add:@"vr_tagid1" value:[config getVr_TagId1]];
    // vr_tagid2
    [parameters add:@"vr_tagid2" value:[config getVr_TagId2]];
    // UUID
    [parameters add:@"id1" value:[UUID load]];
    
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
