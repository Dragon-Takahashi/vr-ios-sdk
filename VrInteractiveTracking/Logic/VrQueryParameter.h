//
//  VrQueryParameter.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 12/6/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QueryParameters.h"
#import "VrInteractiveTrackingSpec.h"
#import "VrInteractiveBeaconSpec.h"
#import "ConfigFile.h"

/**
 固有クエリパラメータ生成クラス
 */
@interface VrQueryParameter : NSObject


/**
 QueryParameters変換
 
 @param trackingSpec VrInteractiveTrackingSpec
 @param beaconSpec VrInteractiveBeaconSpec
 @return QueryParameters
 */
- (QueryParameters *)toQueryParametersWithVrInteractiveTrackingSpec:(VrInteractiveTrackingSpec *)trackingSpec beaconSpec:(VrInteractiveBeaconSpec *)beaconSpec;

/**
 QueryParameters変換
 
 @param config 設定ファイル
 @return QueryParameters
 */
- (QueryParameters *)toQueryParametersWithConfigFile:(ConfigFile *)config;

@end
