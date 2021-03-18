//
//  VrInteractiveBeaconSpec.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/18/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FinishSendBeaconBlock) (BOOL result);

@interface VrInteractiveBeaconSpecBuilder : NSObject
@property (nonatomic, copy) NSString *eventName;
@property (nonatomic, copy) NSString *monitorId;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *identity;
@property (nonatomic, weak) FinishSendBeaconBlock finishSendBeaconBlock;
@end

/**
 ビーコン送信情報格納クラス
 */
@interface VrInteractiveBeaconSpec : NSObject

@property (nonatomic, copy, readonly) NSString *eventName;
@property (nonatomic, copy, readonly) NSString *monitorId;
@property (nonatomic, copy, readonly) NSString *url;
@property (nonatomic, copy, readonly) NSString *identity;
@property (nonatomic, weak, readonly) FinishSendBeaconBlock finishSendBeaconBlock;


/**
 初期化メソッド(makeWithBuilderメソッドから呼ばれる)

 @param builder ビルダー
 @return self
 */
- (instancetype)initWithBuilder:(VrInteractiveBeaconSpecBuilder *)builder;


/**
 Static Factory Method

 @param updateBlock パラメータ
 @return self
 */
+ (instancetype)makeWithBuilder:(void (^)(VrInteractiveBeaconSpecBuilder *))updateBlock;

@end
