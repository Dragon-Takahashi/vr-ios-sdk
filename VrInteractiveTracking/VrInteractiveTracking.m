//
//  VrInteractiveTracking.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/14.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "VrInteractiveTracking.h"

#import "VrInteractiveBeaconSpec.h"
#import "Logic/VrInteractiveTrackingAdapter.h"
#import "Logic/VrOptValidator.h"
#import "Logic/TrackingEnableStrategy.h"
#import "Common/URLValidator.h"
#import "Common/URLValidationHandler.h"
#import "Domain/VRIException.h"

//NSString *const VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY = @"default";

@interface VrInteractiveTracking()
@property (nonatomic) VrInteractiveTrackingAdapter *adapter;
@end

@implementation VrInteractiveTracking


#pragma mark - initialize

/**
 * イニシャライザ
 *
 * @param appName アプリ名
 * @param eventName イベント名
 * @param monitorId モニターID
 *
 * @return VrInteractiveTracking
 */
- (id)initWithAppName:(NSString *)appName eventName:(NSString *)eventName monitorId:(NSString *)monitorId
{
    return [self initWithAppName:appName eventName:eventName monitorId:monitorId finishInitBlock:nil
                      withOptFlg:true withOutsideConfigURL:nil];
}

/**
 * イニシャライザ
 *
 * @param class クラス
 * @param appName アプリ名
 * @param eventName イベント名
 * @param monitorId モニターID
 *
 * @return VrInteractiveTracking
 */
- (id)initWithTracker:(NSString *)class
          withAppName:(NSString *)appName
        withEventName:(NSString *)eventName
        withMonitorId:(NSString *)monitorId
{
    return [self initWithAppName:appName eventName:eventName monitorId:monitorId finishInitBlock:nil withOptFlg:true withOutsideConfigURL:nil];
}

/**
 * イニシャライザ
 *
 * @param class クラス
 * @param appName アプリ名
 * @param eventName イベント名
 * @param monitorId モニターID
 * @param finishInitBlock コールバック
 *
 * @return VrInteractiveTracking
 */
- (id)initWithTracker:(NSString *)class
          withAppName:(NSString *)appName
        withEventName:(NSString *)eventName
        withMonitorId:(NSString *)monitorId
      finishInitBlock:(FinishInitBlock)finishInitBlock
{
    return [self initWithAppName:appName eventName:eventName monitorId:monitorId finishInitBlock:(FinishInitBlock)finishInitBlock withOptFlg:true withOutsideConfigURL:nil];
}

/**
 * イニシャライザ
 *
 * @param class クラス
 * @param appName アプリ名
 * @param eventName イベント名
 * @param monitorId モニターID
 * @param optFlg インスタンス生成フラグ
 * @param outsideConfigURL リモートの設定ファイルパス
 *
 * @return VrInteractiveTracking
 */
- (id)initWithTracker:(NSString *)class
          withAppName:(NSString *)appName
        withEventName:(NSString *)eventName
        withMonitorId:(NSString *)monitorId
           withOptFlg:(BOOL)optFlg
 withOutsideConfigURL:(NSString *)outsideConfigURL
{
    return [self initWithAppName:appName eventName:eventName monitorId:monitorId
                 finishInitBlock:nil withOptFlg:optFlg withOutsideConfigURL:outsideConfigURL];
}


/**
 * イニシャライザ
 *
 * @param class クラス
 * @param appName アプリ名
 * @param eventName イベント名
 * @param monitorId モニターID
 * @param finishInitBlock コールバック
 * @param optFlg インスタンス生成フラグ
 * @param outsideConfigURL リモートの設定ファイルパス
 *
 * @return VrInteractiveTracking
 */
- (id)initWithTracker:(NSString *)class
          withAppName:(NSString *)appName
        withEventName:(NSString *)eventName
        withMonitorId:(NSString *)monitorId
      finishInitBlock:(FinishInitBlock)finishInitBlock
           withOptFlg:(BOOL)optFlg
 withOutsideConfigURL:(NSString *)outsideConfigURL
{
    return [self initWithAppName:appName eventName:eventName monitorId:monitorId
                 finishInitBlock:finishInitBlock withOptFlg:optFlg withOutsideConfigURL:outsideConfigURL];
}


/**
 * イニシャライザ
 *
 * @param appName アプリ名
 * @param eventName イベント名
 * @param monitorId モニターID
 * @param finishInitBlock コールバック
 * @param optFlg インスタンス生成フラグ
 * @param outsideConfigURL リモートの設定ファイルパス
 *
 * @return VrInteractiveTracking
 */
- (id)initWithAppName:(NSString *)appName eventName:(NSString *)eventName monitorId:(NSString *)monitorId finishInitBlock:(FinishInitBlock)finishInitBlock withOptFlg:(BOOL)optFlg withOutsideConfigURL:(NSString *)outsideConfigURL
{
    self = [super init];
    if (self) {
        NSLog(@"Interface class is started");
        @try {
            NSString *inOutsideConfigURL = [outsideConfigURL copy];
            if ([inOutsideConfigURL length] != 0) {
                URLValidator *validator = [[URLValidator alloc] initWithURL:inOutsideConfigURL handler:[URLValidationHandler new]];
                [validator validate];
                if ([validator.handler errors]) {
                    DLog(@"%@", validator.handler.toString);
                    inOutsideConfigURL = nil;
                }
            }
            
            _adapter = [[VrInteractiveTrackingAdapter alloc] initWithAppName:[VrInteractiveTrackingSpec makeWithBuilder:^(VrInteractiveTrackingSpecBuilder *builder) {
                builder.appName = appName;
                builder.eventName = eventName;
                builder.monitorId = monitorId;
                builder.finishInitBlock = finishInitBlock;
                builder.optFlg = optFlg;
                builder.outsideConfigURL = inOutsideConfigURL;
            }]];
        } @catch (NSException *exception) {
            DLog(@"%@", [exception reason]);
            if (finishInitBlock) {
                finishInitBlock(NO);
            }
        }
        NSLog(@"Interface class is finished");
    }
    return self;
}

#pragma mark - UUID

/**
 * UUIDを取得する
 *
 */
- (NSString *)uuId {
    @try {
        return [_adapter uuId];
    } @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
    }
    return nil;
}

/**
 * UUIDを強制的に上書き
 *
 * @param uuid UUID
 */
- (void) updateUUID:(NSString*) uuid {
    @try {
        [_adapter updateUUID:uuid];
    } @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
    }
}

/**
 * 新しいUUIDを割り当て
 *
 */
- (void)replaceUUID {
    @try {
        [_adapter replaceUUID];
    } @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
    }
}


#pragma mark - VrOptValue

/**
 * 拡張フィールド用変数の初期化
 */
- (void)clearAllVrOptValueWithAppName {
    @try {
        [_adapter clearAllVrOptValueWithAppName];
    } @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
    }
}

/**
 * 拡張フィールド用変数を設定する
 *
 * @param optValue 拡張フィールド用の値
 * @param optId 拡張フィールド用の変数番号（"vr_opt{{optId}}"）
 *
 * @return 結果(YES = 成功, NO = 失敗)
 */
- (BOOL)setVrOptValue:(NSString *)optValue forOptId:(int)optId {
    @try {
        NSLog(@"setVrOptValue in Interface start");
        VrOptValidator *validator = [[VrOptValidator alloc] initWithOptId:optId handler:[VrOptValidatoionHandler new]];
        [validator validate];
        if ([validator.handler errors]) {
            @throw [NSException
                    exceptionWithName:@"OptIdOutOfRangeException"
                    reason:[validator.handler toString]
                    userInfo:nil];
        }
        
        NSString *vrOptKey = [NSString stringWithFormat:@"vr_opt%d",optId];
        NSLog(@"setVrOptValue in Interface end key=%@",vrOptKey);
        
        return [_adapter setVrOptValue:optValue forOptKey:vrOptKey];
    } @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
    }
    return NO;
}

/**
 * 拡張フィールド用変数を直感的に設定する
 *
 * @param builder 拡張フィールド用の変数番号1〜9を設定できるビルダー
 *
 */
- (void)setVrOptValue:(void (^)(OptValues *)) builder {
    @try {
        [_adapter setVrOptValue:builder];
    } @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
    }
}

/**
 * 拡張フィールド用変数を取得する
 *
 * @param optId 拡張フィールド用の変数番号
 *
 * @return 拡張フィールド用の値
 */
- (NSString *)optValueByInteger:(int)optId {
    @try {
        VrOptValidator *validator = [[VrOptValidator alloc] initWithOptId:optId handler:[VrOptValidatoionHandler new]];
        [validator validate];
        if ([validator.handler errors]) {
            @throw [NSException
                    exceptionWithName:@"OptIdOutOfRangeException"
                    reason:[validator.handler toString]
                    userInfo:nil];
        }
        
        NSString *optKey = [NSString stringWithFormat:@"vr_opt%d",optId];
        
        return [_adapter optValueByString:optKey];
    } @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
    }
    return nil;
}


/**
 拡張フィールド用変数を取得する

 @param optValue 拡張フィールド用の変数
 @return 拡張フィールド用の値
 */
- (NSString *)optValueByString:(NSString *)optValue {
    @try {
        return [_adapter optValueByString:optValue];
    } @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
    }
    return nil;
}


#pragma mark - SendBeacon

/**
 * ビーコンを送信する
 *
 * @param eventName イベント名
 * @param monitorId モニターID
 *
 */
- (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId {
    [self sendBeaconWithEventName:[eventName copy] monitorId:[monitorId copy] url:nil identity:nil finishBlock:nil];
}

/**
 * ビーコンを送信する（コールバック有）
 *
 * @param eventName イベント名
 * @param monitorId モニターID
 * @param finishBlock コールバック
 *
 */
- (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId finishBlock:(FinishSendBeaconBlock)finishBlock {
    _finishSendBeaconBlock = finishBlock;
    [self sendBeaconWithEventName:[eventName copy] monitorId:[monitorId copy] url:nil identity:nil finishBlock:_finishSendBeaconBlock];
}

/**
 * ビーコンを送信する
 *
 * @param eventName イベント名
 * @param monitorId モニターID
 * @param url 上書き用のURL
 *
 */
- (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId url:(NSString *)url {
    [self sendBeaconWithEventName:[eventName copy] monitorId:[monitorId copy] url:[url copy] identity:nil finishBlock:nil];
}

/**
 * ビーコンを送信する（コールバック有）
 *
 * @param eventName イベント名
 * @param monitorId モニターID
 * @param url 上書き用のURL
 * @param finishBlock コールバック
 *
 */
- (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId url:(NSString *)url finishBlock:(FinishSendBeaconBlock)finishBlock {
    _finishSendBeaconBlock = finishBlock;
    [self sendBeaconWithEventName:[eventName copy] monitorId:[monitorId copy] url:[url copy] identity:nil finishBlock:_finishSendBeaconBlock];
}

/**
 * ビーコンを送信する（Identity有）
 *
 * @param eventName イベント名
 * @param monitorId モニターID
 * @param identity Identity
 *
 */
- (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId identity:(NSString *)identity {
    [self sendBeaconWithEventName:[eventName copy] monitorId:[monitorId copy] url:nil identity:[identity copy] finishBlock:nil];
}

/**
 * ビーコンを送信する（Identity有）（コールバック有）
 *
 * @param eventName イベント名
 * @param monitorId モニターID
 * @param identity Identity
 * @param finishBlock コールバック
 *
 */
- (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId identity:(NSString *)identity finishBlock:(FinishSendBeaconBlock)finishBlock {
    _finishSendBeaconBlock = finishBlock;
    [self sendBeaconWithEventName:[eventName copy] monitorId:[monitorId copy] url:nil identity:[identity copy] finishBlock:_finishSendBeaconBlock];
}

/**
 * ビーコンを送信する（Identity有）
 *
 * @param eventName イベント名
 * @param monitorId モニターID
 * @param url 上書き用のURL
 * @param identity Identity
 *
 */
- (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId url:(NSString *)url identity:(NSString *)identity {
    [self sendBeaconWithEventName:[eventName copy] monitorId:[monitorId copy] url:[url copy] identity:[identity copy] finishBlock:nil];
}

/**
 * ビーコンを送信する（Identity有）（コールバック有）
 *
 * @param eventName イベント名
 * @param monitorId モニターID
 * @param url 上書き用のURL
 * @param identity Identity
 * @param finishBlock コールバック
 *
 */
- (void)sendBeaconWithEventName:(NSString *)eventName monitorId:(NSString *)monitorId url:(NSString *)url identity:(NSString *)identity finishBlock:(FinishSendBeaconBlock)finishBlock {
    @try {
        _finishSendBeaconBlock = finishBlock;
        URLValidator *validator = [[URLValidator alloc] initWithURL:url handler:[URLValidationHandler new]];
        [validator validate];
        if ([validator.handler errors]) {
            DLog(@"%@", validator.handler.toString);
            url = nil;
        }
        
        [_adapter sendBeaconWithEventName:[VrInteractiveBeaconSpec makeWithBuilder:^(VrInteractiveBeaconSpecBuilder *builder) {
            builder.eventName = eventName;
            builder.monitorId = monitorId;
            builder.url = url;
            builder.identity = [self isCheckedIdentity:identity];
            builder.finishSendBeaconBlock = finishBlock;
        }]];
    } @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
        if (_finishSendBeaconBlock) {
            _finishSendBeaconBlock(NO);
        }
    }
}

/**
 * ビーコンを送信する（フルURL）
 *
 * @param directUrl 送信する最終URL
 */
- (void)sendBeaconDirect:(NSString *)directUrl {
    [self sendBeaconDirect:directUrl identity:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY finishBlock:nil];
}

/**
 ビーコンを送信する（フルURL）（コールバック有）

 @param directUrl 送信する最終URL
 @param finishBlock コールバック
 */
- (void)sendBeaconDirect:(NSString *)directUrl finishBlock:(FinishSendBeaconBlock)finishBlock {
    [self sendBeaconDirect:directUrl identity:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY finishBlock:finishBlock];
}

/**
 * ビーコンを送信する（フルURL）（identity有）
 *
 * @param directUrl 送信する最終URL
 * @param identity Identity
 */
- (void)sendBeaconDirect:(NSString *)directUrl identity:(NSString *)identity {
    [self sendBeaconDirect:directUrl identity:identity finishBlock:nil];
}

/**
 * ビーコンを送信する（フルURL）（identity有）（コールバック有）
 *
 * @param directUrl 送信する最終URL
 * @param identity Identity
 * @param finishBlock コールバック
 */
- (void)sendBeaconDirect:(NSString *)directUrl identity:(NSString *)identity finishBlock:(FinishSendBeaconBlock)finishBlock {
    @try {
        URLValidator *validator = [[URLValidator alloc] initWithURL:directUrl handler:[URLValidationHandler new]];
        [validator validate];
        if ([validator.handler errors]) {
            DLog(@"%@", validator.handler.toString);
            @throw [VRIException exceptionWithMessage:@"url is invalid."];
        }
        [_adapter sendBeaconDirect:directUrl identity:identity finishBlock:finishBlock];
    } @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
        if (finishBlock) {
            finishBlock(NO);
        }
    }
}

/**
 * 強制的に適用するビーコンのパラメータを設定
 *
 * @param forceValue 次回実行するsendBeaconの値を上書きするパラメーター群
 */
- (void)setForceBeaconURLStringOnce:(NSDictionary*) forceValue {
    @try {
        [_adapter setForceBeaconURLStringOnce:forceValue];
    } @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
    }
}


#pragma mark - Opt

/**
 * オプトイン
 *
 */
- (void)setOptin {
    [self setOptin:nil];
}

/**
 * オプトイン（コールバック有）
 *
 * @param finishBlock コールバック
 */
- (void)setOptin:(FinishSetOptinBlock)finishBlock {
    @try {
        _finishSetOptinBlock = finishBlock;
        [_adapter setOptIn:_finishSetOptinBlock];
    } @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
        if (finishBlock) {
            finishBlock(NO);
        }
    }
}

/**
 * オプトアウト
 *
 */
- (void)setOptout {
    [self setOptout:nil];
}

/**
 * オプトアウト（コールバック有）
 *
 * @param finishBlock コールバック
 */
- (void)setOptout:(FinishSetOptoutBlock)finishBlock {
    @try {
        _finishSetOptoutBlock = finishBlock;
        [_adapter setOptOut:_finishSetOptoutBlock];
    } @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
        if (finishBlock) {
            finishBlock(NO);
        }
    }
}

/**
 * オプトアウト状態を返却
 *
 */
- (BOOL)isOptout {
    @try {
        return [_adapter isOptOut];
    } @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
    }
    return NO;
}


#pragma mark - ConfigFile

/**
 * デフォルト以外の設定ファイルを読み込む
 *
 * @param identity Identity
 * @param fileName ファイル名
 */
- (void)loadConfig:(NSString *)identity fileName:(NSString *)fileName {
    [self loadConfig:identity fileName:fileName finishBlock:nil];
}

/**
 デフォルト以外の設定ファイルを読み込む

 @param identity Identity
 @param fileName ファイル名
 @param finishBlock コールバック
 */
- (void)loadConfig:(NSString *)identity fileName:(NSString *)fileName finishBlock:(FinishLoadBlock)finishBlock {
    @try {
        [_adapter loadConfig:[self isCheckedIdentity:identity] fileName:fileName finishBlock:finishBlock];
    } @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
        if (finishBlock) {
            finishBlock(NO);
        }
    }
}


/**
 設定ファイルの読み込み状態を返す

 @param identity Identity
 @return 結果（YES = 読み込み中, NO = 設定完了）
 */
- (BOOL)isCheckedLoadConfigRunning:(NSString *)identity {
    @try {
        BOOL result = [_adapter isCheckedLoadConfigRunning:identity];
        return result;
    } @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
    }
    return NO;
}

/**
 * 設定ファイルの定義値を返す（デフォルト）
 *
 * @return 設定ファイルの定義値
 */
- (NSDictionary *)configParams {
    return [self configParams:nil];
}

/**
 * 設定ファイルの定義値を返す（Identity有）
 *
 * @param identity Identity
 *
 * @return 設定ファイルの定義値
 */
- (NSDictionary *)configParams:(NSString *)identity {
    @try {
        return [_adapter configParams:[self isCheckedIdentity:identity]];
    } @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
    }
    return nil;
}


// 設定ファイルを書き込む（デフォルト）
- (void)setConfig:(NSDictionary *)config {
    [self setConfig:config identity:VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY];
}

/**
 * 設定ファイルを書き込む
 *
 * @param config 設定ファイルの定義値
 */
- (void)setConfig:(NSDictionary *)config identity:(NSString *)identity {
    @try {
        [self isCheckedIdentity:identity];
        [_adapter setConfig:config identity:identity];
    } @catch (NSException *exception) {
        DLog(@"%@", [exception reason]);
    }
}

/**
 * セッションID取得
 * @return セッションID
 */
- (NSString *)getSessionID {
    return [_adapter getSessionID];
}



#pragma mark - Deprecated methods


// ポーリング有効化
- (void) __attribute__((deprecated(""))) setPollingEnabled {
    return;
}
// ポーリング無効化
- (void) __attribute__((deprecated(""))) setPollingDisabled {
    return;
}
// ポーリング開始
- (void) __attribute__((deprecated(""))) startPolling {
    return;
}
// ポーリング開始秒数指定
- (void) __attribute__((deprecated(""))) startPolling:(NSTimeInterval)pollingInterval {
    return;
}
// ポーリング停止
- (void) __attribute__((deprecated(""))) stopPolling {
    return;
}
// ポーリング中状態
- (BOOL) __attribute__((deprecated(""))) isDuringPolling {
    return NO;
}
// ポーリング有効化状態
- (BOOL) __attribute__((deprecated(""))) isPollingEnabled {
    return NO;
}
// 開発者カスタムタグ設定値を取得する
- (void) __attribute__((deprecated(""))) customConfigParamWithTag:(NSString *)tag withUrl:(NSString *)url finishLoadCustomConfigBlock:(FinishLoadCustomConfigBlock)finishReloadCustomConfig {
    if (finishReloadCustomConfig) {
        finishReloadCustomConfig(nil, 0);
    }
    return;
}
// サーバ設定ファイル設定状態
- (BOOL) __attribute__((deprecated(""))) isServerConfigSetting {
    return NO;
}
// 設定ファイル取得時間
- (NSDate *) __attribute__((deprecated(""))) configAcquisitionTime {
    return nil;
}
// 設定ファイル取得経過時間
- (int) __attribute__((deprecated(""))) elapsedTimeFromConfigAcquisition {
    return 0;
}
// 設定ファイル取得
- (void) __attribute__((deprecated(""))) reloadConfig {
    return;
}
// 設定ファイル取得（コールバック有）
- (void) __attribute__((deprecated(""))) reloadConfig:(FinishReloadBlock)finishReloadBlock {
    if (finishReloadBlock) {
        finishReloadBlock(NO);
    }
    return;
}
// 未送信ログ数
- (long) __attribute__((deprecated(""))) beaconlogCount {
    return 0;
}
// 未送信ログ数（コールバック有）
- (void) __attribute__((deprecated(""))) beaconlogCount:(FinishBeaconlogCountBlock)finishBeaconlogCountBlock {
    if (finishBeaconlogCountBlock) {
        finishBeaconlogCountBlock(0);
    }
    return;
}




/**
 空文字、nilのIdentityを丸める

 @param identity Identity
 */
- (NSString *)isCheckedIdentity:(NSString *)identity {
    if ([identity length] == 0) {
        return VR_LIB_DEFAULT_LOCAL_FILE_IDENTITY;
    }
    return identity;
}

@end

