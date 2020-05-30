//
//  VrInteractiveTrackingSpec.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/13/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FinishInitBlock) (BOOL result);

@interface VrInteractiveTrackingSpecBuilder : NSObject
@property (nonatomic, copy) NSString *appName;
@property (nonatomic, copy) NSString *eventName;
@property (nonatomic, copy) NSString *monitorId;
@property (nonatomic, copy) NSString *outsideConfigURL;
@property (nonatomic) BOOL optFlg;
@property (nonatomic, copy) FinishInitBlock finishInitBlock;
@end

/**
 インスタンス初期化情報格納クラス
 */
@interface VrInteractiveTrackingSpec : NSObject

@property (nonatomic, copy, readonly) NSString *appName;
@property (nonatomic, copy, readonly) NSString *eventName;
@property (nonatomic, copy, readonly) NSString *monitorId;
@property (nonatomic, copy, readonly) NSString *outsideConfigURL;
@property (nonatomic, readonly) BOOL optFlg;
@property (nonatomic, copy) FinishInitBlock finishInitBlock;


/**
 ビルダー

 @param builder block
 @return self
 */
- (instancetype)initWithBuilder:(VrInteractiveTrackingSpecBuilder *)builder;

/**
 Static Factory Method

 @param updateBlock block
 @return self
 */
+ (instancetype)makeWithBuilder:(void (^)(VrInteractiveTrackingSpecBuilder *))updateBlock;

/**
 インスタンス続行フラグ取得

 @return インスタンス続行フラグ
 */
- (BOOL)getEnabled;

@end
