//
//  TrackingDisableStrategy.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/17/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "TrackingDisableStrategy.h"

@interface TrackingDisableStrategy()
@property (nonatomic, copy)VrInteractiveTrackingSpec *spec;
@end

@implementation TrackingDisableStrategy

#pragma mark - initialize

- (instancetype)initWithAppName:(VrInteractiveTrackingSpec *)spec {
    self = [super init];
    if (self) {
        _spec = spec;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // コールバックを初期化後に行うため、あえて0.5秒止めてからコールバックを行う
            usleep(0.3 * 1000000);
            if (spec.finishInitBlock) {
                spec.finishInitBlock(NO);
                [spec setFinishInitBlock:nil];
            }
        });
    }
    return self;
}

#pragma mark - UUID

// UUIDを取得する
- (NSString *)uuId {
    return nil;
}
// UUIDの上書き
- (void) updateUUID:(NSString*) uuid {
    // 何もしない
}
// 新しいUUIDを割り当て
- (void)replaceUUID {
    // 何もしない
}


#pragma mark - VrOptValue

// 拡張フィールド用変数の初期化
- (void)clearAllVrOptValueWithAppName; {
    // 何もしない
}
// 拡張フィールド用変数を設定する
- (BOOL)setVrOptValue:(NSString *)optValue forOptKey:(NSString *)optKey {
    return NO;
}
// 拡張フィールド用変数を直感的に設定する
- (void)setVrOptValue:(void (^)(OptValues *)) builder {
    // 何もしない
}
// 拡張フィールド用変数を取得する
- (NSString *)optValueByString:(NSString *)optValue {
    return nil;
}


#pragma mark - SendBeacon

// ビーコンを送信する
- (void)sendBeaconWithEventName:(VrInteractiveBeaconSpec *)beaconSpec {
    // 何もしない
    if (beaconSpec.finishSendBeaconBlock) {
        beaconSpec.finishSendBeaconBlock(NO);
    }
}
// ビーコンを送信する（フルURL）
- (void)sendBeaconDirect:(NSString *)directUrl identity:(NSString *)identity finishBlock:(FinishSendBeaconBlock)finishBlock {
    // 何もしない
    if (finishBlock) {
        finishBlock(NO);
    }
}
// 強制的に適用するビーコンのパラメータを設定
- (void)setForceBeaconURLStringOnce:(NSDictionary*) forceValue {
    // 何もしない
}


#pragma mark - Opt

// オプトインを設定する（コールバックなし）
- (BOOL)setOptIn {
    // 何もしない
    return NO;
}
// オプトアウトを設定する（コールバックなし）
- (BOOL)setOptOut{
    // 何もしない
    return NO;
}
// オプトアウト状態
- (BOOL)isOptOut {
    return NO;
}


#pragma mark - ConfigFile

// デフォルト以外の設定ファイルを読み込む
- (void)loadConfig:(NSString *)identity fileName:(NSString *)fileName finishBlock:(FinishLoadBlock)finishBlock {
    // 何もしない
    if (finishBlock) {
        finishBlock(NO);
    }
}
// 設定ファイルの読み込み状態
- (BOOL)isCheckedLoadConfigRunning:(NSString *)identity {
    return NO;
}
// 設定ファイルの定義値を返す
- (NSDictionary *)configParams:(NSString *)identity {
    return nil;
}
// 設定ファイルを書き込む
- (void)setConfig:(NSDictionary *)config identity:(NSString *)identity {
    // 何もしない
}

// セッションIDを返却
- (NSString *)getSessionID {
    return nil;
}

@end
