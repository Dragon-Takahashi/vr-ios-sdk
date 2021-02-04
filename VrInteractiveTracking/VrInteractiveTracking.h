//
//  VrInteractiveTracking.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/14.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OptValues.h"
#import "VValues.h"

typedef void (^FinishInitBlock) (BOOL result);
typedef void (^FinishReloadBlock) (BOOL result);
typedef void (^FinishLoadCustomConfigBlock) (NSString *param, int result);
typedef void (^FinishSendBeaconBlock) (BOOL result);
typedef void (^FinishSetOptoutBlock) (BOOL result);
typedef void (^FinishSetOptinBlock) (BOOL result);
typedef void (^FinishBeaconlogCountBlock) (long result);
typedef void (^FinishLoadBlock) (BOOL result);

/**
 VrInteractiveTrackingクラス
 */
@interface VrInteractiveTracking : NSObject


@property (nonatomic, copy) NSString *outsideConfigURL;
@property (nonatomic, copy) FinishReloadBlock finishReloadBlock;
@property (nonatomic, copy) FinishSetOptoutBlock finishSetOptoutBlock;
@property (nonatomic, copy) FinishSetOptinBlock finishSetOptinBlock;
@property (nonatomic, copy) FinishBeaconlogCountBlock finishBeaconlogCountBlock;
@property (nonatomic, copy) FinishSendBeaconBlock finishSendBeaconBlock;
@property (nonatomic, copy) FinishLoadCustomConfigBlock finishReloadCustomConfig;

#pragma mark - initialize

/**
 イニシャライザ

 @param appName アプリ名
 @param eventName イベント名
 @param monitorId モニターID
 @return VrInteractiveTracking
 */
- (id)initWithAppName:(NSString *)appName
            eventName:(NSString *)eventName
            monitorId:(NSString *)monitorId;
/**
 イニシャライザ
 
 @param class クラス
 @param appName アプリ名
 @param eventName イベント名
 @param monitorId モニターID
 @return VrInteractiveTracking
 */
- (id)initWithTracker:(NSString *)class
          withAppName:(NSString *)appName
        withEventName:(NSString *)eventName
        withMonitorId:(NSString *)monitorId;

/**
 イニシャライザ
 
 @param class クラス
 @param appName アプリ名
 @param eventName イベント名
 @param monitorId モニターID
 @param finishInitBlock コールバック
 @return VrInteractiveTracking
 */
- (id)initWithTracker:(NSString *)class
          withAppName:(NSString *)appName
        withEventName:(NSString *)eventName
        withMonitorId:(NSString *)monitorId
      finishInitBlock:(FinishInitBlock)finishInitBlock;

/**
 イニシャライザ
 
 @param class クラス
 @param appName アプリ名
 @param eventName イベント名
 @param monitorId モニターID
 @param optFlg インスタンス生成フラグ
 @param outsideConfigURL リモートの設定ファイルパス
 @return VrInteractiveTracking
 */
- (id)initWithTracker:(NSString *)class
          withAppName:(NSString *)appName
        withEventName:(NSString *)eventName
        withMonitorId:(NSString *)monitorId
           withOptFlg:(BOOL)optFlg
 withOutsideConfigURL:(NSString *)outsideConfigURL;

/**
 イニシャライザ
 
 @param class クラス
 @param appName アプリ名
 @param eventName イベント名
 @param monitorId モニターID
 @param finishInitBlock コールバック
 @param optFlg インスタンス生成フラグ
 @param outsideConfigURL リモートの設定ファイルパス
 @return VrInteractiveTracking
 */
- (id)initWithTracker:(NSString *)class
          withAppName:(NSString *)appName
        withEventName:(NSString *)eventName
        withMonitorId:(NSString *)monitorId
      finishInitBlock:(FinishInitBlock)finishInitBlock
           withOptFlg:(BOOL)optFlg
 withOutsideConfigURL:(NSString *)outsideConfigURL;


#pragma mark - UUID

/**
 UUID取得
 @return uuid
 */
- (NSString*) uuId;

/**
 UUID更新
 @param uuid UUID
 */
- (void) updateUUID:(NSString*) uuid;

/**
 UUID再設定
 */
- (void) replaceUUID;


#pragma mark - VrOptValue

/**
 拡張フィールド用変数の初期化
 */
- (void)clearAllVrOptValueWithAppName;

/**
 拡張フィールド用変数を設定する
 
 @param optValue 拡張フィールド用の値
 @param optId 拡張フィールド用の変数番号（"vr_opt{{optId}}"）
 @return 結果(YES = 成功, NO = 失敗)
 */
- (BOOL)setVrOptValue:(NSString *)optValue forOptId:(int)optId;

/**
 拡張フィールド用変数を直感的に設定する
 
 @param builder 拡張フィールド用の変数番号1〜9を設定できるビルダー
 */
- (void)setVrOptValue:(void (^)(OptValues *)) builder;

/**
 拡張フィールド用変数を取得する
 
 @param optId 拡張フィールド用の変数番号
 @return 拡張フィールド用の値
 */
- (NSString *)optValueByInteger:(int)optId;

/**
 拡張フィールド用変数を取得する
 
 @param optValue 拡張フィールド用の変数
 @return 拡張フィールド用の値
 */
- (NSString *)optValueByString:(NSString *)optValue;

/**
 Vタグ拡張フィールド初期化
 
 @param appName アプリ名
 */
- (void)clearAllVValue:(NSString *)appName;

/**
 Vタグ拡張フィールド一括設定
 
 @param vValues 拡張フィールド用のビルダー
 */
- (void)setVValue:(void (^)(VValues *))vValues;

/**
 Vタグ拡張フィールド取得
 
 @param fieldName 拡張フィールド名
 @return 拡張フィールドの値
 */
- (NSString *)getVValue:(NSString *)fieldName;


#pragma mark - SendBeacon

/**
 ビーコンを送信する
 
 @param eventName イベント名
 @param monitorId モニターID
 */
- (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId;

/**
 ビーコンを送信する（コールバック有）

 @param eventName イベント名
 @param monitorId モニターID
 @param finishBlock コールバック
 */
- (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId finishBlock:(FinishSendBeaconBlock)finishBlock;

/**
 ビーコンを送信する
 
 @param eventName イベント名
 @param monitorId モニターID
 @param url 上書き用のURL
 */
- (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId url:(NSString *)url;

/**
 ビーコンを送信する（コールバック有）

 @param eventName イベント名
 @param monitorId モニターID
 @param url 上書き用のURL
 @param finishBlock コールバック
 */
- (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId url:(NSString *)url finishBlock:(FinishSendBeaconBlock)finishBlock;

/**
 ビーコンを送信する（Identity有）
 
 @param eventName イベント名
 @param monitorId モニターID
 @param identity Identity
 */
- (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId identity:(NSString *)identity;

/**
 ビーコンを送信する（Identity有）（コールバック有）

 @param eventName イベント名
 @param monitorId モニターID
 @param identity Identity
 @param finishBlock コールバック
 */
- (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId identity:(NSString *)identity finishBlock:(FinishSendBeaconBlock)finishBlock;

/**
 ビーコンを送信する（Identity有）
 
 @param eventName イベント名
 @param monitorId モニターID
 @param url 上書き用のURL
 @param identity Identity
 */
- (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId url:(NSString *)url identity:(NSString *)identity;

/**
 ビーコンを送信する（Identity有）（コールバック有）

 @param eventName イベント名
 @param monitorId モニターID
 @param url 上書き用のURL
 @param identity Identity
 @param finishBlock コールバック
 */
- (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId url:(NSString *)url identity:(NSString *)identity finishBlock:(FinishSendBeaconBlock)finishBlock;


#pragma mark - Opt


/**
 オプトイン
 */
- (void)setOptin;

/**
 オプトイン（コールバック有）

 @param finishBlock コールバック
 */
- (void)setOptin:(FinishSetOptinBlock)finishBlock;

/**
 オプトアウト
 */
- (void)setOptout;

/**
 オプトアウト（コールバック有）
 
 @param finishBlock コールバック
 */
- (void)setOptout:(FinishSetOptoutBlock)finishBlock;

/**
 オプトアウト状態を返却
 */
- (BOOL)isOptout;


#pragma mark - ConfigFile

/**
 設定ファイル読み込み（ファイルパス指定）
 @param fileName ファイル名
 @param identity 設定ファイル識別子
 */
- (void)loadConfig:(NSString *)identity fileName:(NSString *)fileName;


/**
 設定ファイル読み込み（ファイルパス指定）
 @param fileName ファイル名
 @param identity 設定ファイル識別子
 @param finishBlock コールバック用リスナー
 */
- (void)loadConfig:(NSString *)identity fileName:(NSString *)fileName finishBlock:(FinishLoadBlock)finishBlock;

/**
 設定ファイルの読み込み状態を返す
 
 @param identity Identity
 @return 結果（YES = 読み込み中, NO = 設定完了）
 */
- (BOOL)isCheckedLoadConfigRunning:(NSString *)identity;

/**
 VRタグ用の設定ファイル取得（デフォルト）
 @return 設定ファイル
 */
- (NSDictionary *)configParams;

/**
 Vタグ用の設定ファイル取得（デフォルト）
 @return 設定ファイル
 */
- (NSDictionary *)getVConfigParams;

/**
 設定ファイル取得（identity指定）
 @param identity 設定ファイル識別子
 @return 設定ファイル
 */
- (NSDictionary *)configParams:(NSString *)identity;

/**
 VRタグ用の設定ファイル設定（デフォルト）
 @param config config
 */
- (void)setConfig:(NSDictionary *)config;

/**
 Vタグ用の設定ファイル設定（デフォルト）
 @param config config
 */
- (void)setVConfig:(NSDictionary *)config;

/**
 設定ファイル設定（ファイルパス指定）
 @param identity 設定ファイル識別子
 @param config config
 */
- (void)setConfig:(NSDictionary *)config identity:(NSString *)identity;

/**
 * セッションID取得
 * @return セッションID
 */
- (NSString *)getSessionID;


#pragma mark - Deprecated methods

// ポーリング有効化
- (void) __attribute__((deprecated(""))) setPollingEnabled;
// ポーリング無効化
- (void) __attribute__((deprecated(""))) setPollingDisabled;
// ポーリング開始
- (void) __attribute__((deprecated(""))) startPolling;
// ポーリング開始秒数指定
- (void) __attribute__((deprecated(""))) startPolling:(NSTimeInterval)pollingInterval;
// ポーリング停止
- (void) __attribute__((deprecated(""))) stopPolling;
// ポーリング中状態
- (BOOL) __attribute__((deprecated(""))) isDuringPolling;
// ポーリング有効化状態
- (BOOL) __attribute__((deprecated(""))) isPollingEnabled;
// 開発者カスタムタグ設定値を取得する
- (void) __attribute__((deprecated(""))) customConfigParamWithTag:(NSString *)tag withUrl:(NSString *)url finishLoadCustomConfigBlock:(FinishLoadCustomConfigBlock)finishReloadCustomConfig;
// サーバ設定ファイル設定状態
- (BOOL) __attribute__((deprecated(""))) isServerConfigSetting;
// 設定ファイル取得時間
- (NSDate *) __attribute__((deprecated(""))) configAcquisitionTime;
// 設定ファイル取得経過時間
- (int) __attribute__((deprecated(""))) elapsedTimeFromConfigAcquisition;
// 設定ファイル取得
- (void) __attribute__((deprecated(""))) reloadConfig;
// 設定ファイル取得（コールバック有）
- (void) __attribute__((deprecated(""))) reloadConfig:(FinishReloadBlock)finishReloadBlock;
// 未送信ログ数
- (long) __attribute__((deprecated(""))) beaconlogCount;
// 未送信ログ数（コールバック有）
- (void) __attribute__((deprecated(""))) beaconlogCount:(FinishBeaconlogCountBlock)finishBeaconlogCountBlock;

@end

