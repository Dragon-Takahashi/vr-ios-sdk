//
//  TrackingStrategy.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/17/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#ifndef TrackingStrategy_h
#define TrackingStrategy_h

#import "TrackingStrategy.h"
#import "VrInteractiveTrackingSpec.h"
#import "OptValues.h"
#import "VrInteractiveBeaconSpec.h"

typedef void (^FinishSendBeaconBlock) (BOOL result);
typedef void (^FinishSetOptoutBlock) (BOOL result);
typedef void (^FinishSetOptinBlock) (BOOL result);
typedef void (^FinishLoadBlock) (BOOL result);

/**
 TrackingStrategyInterface
 */
@protocol TrackingStrategy <NSObject>
@required

#pragma mark - initialize

/**
 イニシャライザ
 
 @param params spec
 @return self
 */
- (instancetype)initWithAppName:(VrInteractiveTrackingSpec *)params;


#pragma mark - UUID

/**
 UUIDを取得する
 
 @return UUID
 */
- (NSString *)uuId;

/**
 UUIDを強制的に上書き
 
 @param uuid UUID
 */
- (void) updateUUID:(NSString*) uuid;

/**
 新しいUUIDを割り当て
 */
- (void)replaceUUID;


#pragma mark - VrOptValue

/**
 拡張フィールド用変数の初期化
 */
- (void)clearAllVrOptValueWithAppName;

/**
 拡張フィールド用変数を設定する
 
 @param optValue 拡張フィールド用の値
 @param optKey 拡張フィールド用のキー
 @return 結果(YES = 成功, NO = 失敗)
 */
- (BOOL)setVrOptValue:(NSString *)optValue forOptKey:(NSString *)optKey;

/**
 拡張フィールド用変数をBlockを使用して設定する
 
 @param builder 拡張フィールド用の変数番号1〜9を設定できるビルダー
 */
- (void)setVrOptValue:(void (^)(OptValues *)) builder;

/**
 拡張フィールド用変数を取得する
 
 @param optValue 拡張フィールド用の変数
 @return 拡張フィールド用の値
 */
- (NSString *)optValueByString:(NSString *)optValue;


#pragma mark - SendBeacon

/**
 ビーコンを送信する
 
 @param beaconSpec BeaconSpec
 */
- (void)sendBeaconWithEventName:(VrInteractiveBeaconSpec *)beaconSpec;

/**
 ビーコンを送信する（フルURL）
 
 @param directUrl 送信する最終URL
 */
- (void)sendBeaconDirect:(NSString *)directUrl identity:(NSString *)identity finishBlock:(FinishSendBeaconBlock)finishBlock;

/**
 強制的に適用するビーコンのパラメータを設定
 
 @param forceValue 次回実行するsendBeaconの値を上書きするパラメーター群
 */
- (void)setForceBeaconURLStringOnce:(NSDictionary*) forceValue;


#pragma mark - Opt


/**
 オプトイン
 */
- (BOOL)setOptIn;

/**
 オプトアウト
 */
- (BOOL)setOptOut;

/**
 オプトアウト状態を返却
 
 @return オプトアウト状態
 */
- (BOOL)isOptOut;


#pragma mark - ConfigFile

/**
 デフォルト以外の設定ファイルを読み込む
 
 @param identity Identity
 @param fileName ファイル名
 */
- (void)loadConfig:(NSString *)identity fileName:(NSString *)fileName finishBlock:(FinishLoadBlock)finishBlock;

/**
 設定ファイルの読み込み状態を返す
 
 @param identity Identity
 @return 結果（YES = 読み込み中, NO = 設定完了）
 */
- (BOOL)isCheckedLoadConfigRunning:(NSString *)identity;

/**
 設定ファイルの定義値を返す（Identity有）
 
 @param identity Identity
 @return 設定ファイルの定義値
 */
- (NSDictionary *)configParams:(NSString *)identity;

/**
 設定ファイルを書き込む
 新規メソッド
 
 @param config 設定ファイルの定義値
 */
- (void)setConfig:(NSDictionary *)config identity:(NSString *)identity;

/**
 * セッションID取得
 * @return セッションID
 */
- (NSString *)getSessionID;

@end

#endif /* TrackingStrategy_h */
