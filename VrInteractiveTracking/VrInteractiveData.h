//
//  VrInteractiveData.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/14.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VrInteractiveTracking.h"

/**
 VrInteractiveDataクラス
 */
@interface VrInteractiveData : NSObject


/**
 シングルトンのSelfを返却

 @return self
 */
+ (VrInteractiveData *)sharedInstance;

/**
 VrInteractiveTrackingクラスの生成メソッド

 @param classObject クラス
 @param appName アプリ名
 @param eventName イベント名
 @param monitorId モニターID
 @return VrInteractiveTracking
 */
- (VrInteractiveTracking *)withClass:(NSObject *)classObject
                         withAppName:(NSString *)appName
                       withEventName:(NSString *)eventName
                       withMonitorId:(NSString *)monitorId;

/**
 VrInteractiveTrackingクラスの生成メソッド

 @param classObject クラス
 @param appName アプリ名
 @param eventName イベント名
 @param monitorId モニターID
 @param finishInitBlock コールバック
 @return VrInteractiveTracking
 */
- (VrInteractiveTracking *)withClass:(NSObject *)classObject
                         withAppName:(NSString *)appName
                       withEventName:(NSString *)eventName
                       withMonitorId:(NSString *)monitorId
                     finishInitBlock:(FinishInitBlock)finishInitBlock;


/**
 VrInteractiveTrackingクラスの生成メソッド

 @param classObject クラス
 @param appName アプリ名
 @param eventName イベント名
 @param monitorId モニターID
 @param optFlg インスタンス生成フラグ
 @param outsideConfigURL リモートの設定ファイル
 @return VrInteractiveTracking
 */
- (VrInteractiveTracking *)withClass:(NSObject *)classObject
                         withAppName:(NSString *)appName
                       withEventName:(NSString *)eventName
                       withMonitorId:(NSString *)monitorId
                          withOptFlg:(BOOL)optFlg
                withOutsideConfigURL:(NSString *)outsideConfigURL;

/**
 VrInteractiveTrackingクラスの生成メソッド

 @param classObject クラス
 @param appName アプリ名
 @param eventName イベント名
 @param monitorId モニターID
 @param finishInitBlock コールバック
 @param optFlg インスタンス生成フラグ
 @param outsideConfigURL リモートの設定ファイル
 @return VrInteractiveTracking
 */
- (VrInteractiveTracking *)withClass:(NSObject *)classObject
                         withAppName:(NSString *)appName
                       withEventName:(NSString *)eventName
                       withMonitorId:(NSString *)monitorId
                     finishInitBlock:(FinishInitBlock)finishInitBlock
                          withOptFlg:(BOOL)optFlg
                withOutsideConfigURL:(NSString *)outsideConfigURL;


@end

