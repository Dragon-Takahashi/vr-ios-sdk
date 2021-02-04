//
//  VQueryParameter.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2/3/21.
//  Copyright © 2021 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QueryParameters.h"
#import "VrInteractiveTrackingSpec.h"
#import "VrInteractiveBeaconSpec.h"
#import "ConfigFile.h"
#import <UIKit/UIKit.h>
#import "../Domain/Counter.h"
#import "../Domain/UUID.h"
#import "../Domain/SessionID.h"

/**
 固有クエリパラメータ生成クラス
 */
@interface VQueryParameter : NSObject


/**
 QueryParameters変換
 
 @param trackingSpec VrInteractiveTrackingSpec
 @param beaconSpec VrInteractiveBeaconSpec
 @return QueryParameters
 */
- (QueryParameters *)toQueryParametersWithVrInteractiveTrackingSpec:(VrInteractiveTrackingSpec *)trackingSpec beaconSpec:(VrInteractiveBeaconSpec *)beaconSpec sessionID:(SessionID *)sessionID ;

/**
 QueryParameters変換
 
 @param config 設定ファイル
 @return QueryParameters
 */
- (QueryParameters *)toQueryParametersWithConfigFile:(ConfigFile *)config;

@end
