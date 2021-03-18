//
//  VrInteractiveTrackingAdapter.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/24.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "VrInteractiveTrackingAdapter.h"

#import "TrackingFactory.h"
#import "TrackingDisableStrategy.h"
#import "TrackingEnableStrategy.h"

@interface VrInteractiveTrackingAdapter()
@property (nonatomic, copy)VrInteractiveTrackingSpec * trackingSpec;
@property (nonatomic) id strategy;
@end

@implementation VrInteractiveTrackingAdapter

#pragma mark - initialize

/**
 イニシャライザ
 既存メソッド

 @param trackingSpec spec
 @return self
 */
- (instancetype)initWithAppName:(VrInteractiveTrackingSpec *)trackingSpec {
    
    self = [super init];
    if (self) {
        
        if (!trackingSpec) {
            @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:@"invalid construct error! is nil" userInfo:nil];
        }
        
        _trackingSpec = trackingSpec;
        _strategy = [TrackingFactory of:trackingSpec];
        
    }
    return self;
}


#pragma mark - UUID
    
/**
 UUIDを取得する
 既存メソッド

 @return UUID
 */
- (NSString *)uuId {
    return [_strategy uuId];
}

/**
 UUIDを強制的に上書き
 追加メソッド

 @param uuid UUID
 */
- (void) updateUUID:(NSString*) uuid {
    [_strategy updateUUID:uuid];
    _strategy = [TrackingFactory update:_strategy spec:_trackingSpec];
}

/**
 * 新しいUUIDを割り当て
 *
 */
- (void)replaceUUID {
    [_strategy replaceUUID];
    _strategy = [TrackingFactory update:_strategy spec:_trackingSpec];
}


/**
 拡張フィールド用変数の初期化
 既存メソッド（引数を除去済み）
 */
- (void)clearAllVrOptValueWithAppName {
    // TODO rename
    [_strategy clearAllVrOptValueWithAppName];
}

/**
 拡張フィールド用変数を設定する
 既存メソッド

 @param optValue 拡張フィールド用の値
 @param optKey 拡張フィールド用のキー
 @return 結果(YES = 成功, NO = 失敗)
 */
- (BOOL)setVrOptValue:(NSString *)optValue forOptKey:(NSString *)optKey {
    NSLog(@"setVrOptValue in Adapter");
    return [_strategy setVrOptValue:optValue forOptKey:optKey];
}

/**
 拡張フィールド用変数を直感的に設定する
 追加メソッド

 @param builder 拡張フィールド用の変数番号1〜9を設定できるビルダー
 */
- (void)setVrOptValue:(void (^)(OptValues *)) builder {
    [_strategy setVrOptValue:builder];
}

/**
 拡張フィールド用変数を取得する
 既存メソッド

 @param optId 拡張フィールド用の変数番号
 @return 拡張フィールド用の値
 */
- (NSString *)optValueByInteger:(int)optId {
    return [_strategy optValueByInteger:optId];
}


/**
 拡張フィールド用変数を取得する
 新規メソッド

 @param optValue 拡張フィールド用の変数
 @return 拡張フィールド用の値
 */
- (NSString *)optValueByString:(NSString *)optValue {
    return [_strategy optValueByString:optValue];
}


#pragma mark - SendBeacon

/**
 ビーコンを送信する（Identity有）（コールバック有）
 既存＋追加メソッド

 @param beaconSpec BeaconSpec
 */
- (void)sendBeaconWithEventName:(VrInteractiveBeaconSpec *)beaconSpec {
    [_strategy sendBeaconWithEventName:beaconSpec];
}

/**
 ビーコンを送信する（フルURL）
 追加メソッド

 @param directUrl 送信する最終URL
 */
- (void)sendBeaconDirect:(NSString *)directUrl identity:(NSString *)identity finishBlock:(FinishSendBeaconBlock)finishBlock {
    [_strategy sendBeaconDirect:directUrl identity:identity finishBlock:finishBlock];
}

/**
 強制的に適用するビーコンのパラメータを設定
 追加メソッド

 @param forceValue 次回実行するsendBeaconの値を上書きするパラメーター群
 */
- (void)setForceBeaconURLStringOnce:(NSMutableDictionary*) forceValue {
    [_strategy setForceBeaconURLStringOnce:forceValue];
}

#pragma mark - Opt

/**
 オプトイン（コールバック有）
 既存メソッド

 @param finishBlock コールバック
 */
- (void)setOptIn:(FinishSetOptinBlock)finishBlock {
    BOOL result = [_strategy setOptIn];
    // コールバック
    if (finishBlock) {
        finishBlock(result);
    }
}

/**
 オプトアウト（コールバック有）
 既存メソッド

 @param finishBlock コールバック
 */
- (void)setOptOut:(FinishSetOptoutBlock)finishBlock {
    BOOL result = [_strategy setOptOut];
    // コールバック
    if (finishBlock) {
        finishBlock(result);
    }
}

/**
 オプトアウト状態を返却
 既存メソッド

 @return オプトアウト状態
 */
- (BOOL)isOptOut {
    return [_strategy isOptOut];
}



#pragma mark - ConfigFile

/**
 デフォルト以外の設定ファイルを読み込む
 追加メソッド

 @param identity Identity
 @param fileName ファイル名
 */
- (void)loadConfig:(NSString *)identity fileName:(NSString *)fileName finishBlock:(FinishLoadBlock)finishBlock {
    [_strategy loadConfig:identity fileName:fileName finishBlock:finishBlock];
}

/**
 設定ファイルの読み込み状態を返す
 
 @param identity Identity
 @return 結果（YES = 読み込み中, NO = 設定完了）
 */
- (BOOL)isCheckedLoadConfigRunning:(NSString *)identity {
    return [_strategy isCheckedLoadConfigRunning:identity];
}

/**
 設定ファイルの定義値を返す（Identity有）
 追加メソッド

 @param identity Identity
 @return 設定ファイルの定義値
 */
- (NSDictionary *)configParams:(NSString *)identity {
    return [_strategy configParams:identity];
}

/**
 設定ファイルを書き込む
 新規メソッド

 @param config 設定ファイルの定義値
 */
- (void)setConfig:(NSDictionary *)config identity:(NSString *)identity {
    [_strategy setConfig:config identity:identity];
}


/**
 * セッションID取得
 * @return セッションID
 */
- (NSString *)getSessionID {
    return [_strategy getSessionID];
}

@end
