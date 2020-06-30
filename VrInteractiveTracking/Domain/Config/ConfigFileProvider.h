//
//  ConfigFileProvider.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/20.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigProvider.h"
#import "ConfigFile.h"


typedef void (^ConfigStatusCallback) (BOOL isRunning, NSString *identity);

/**
 設定ファイル提供クラス
 */
@interface ConfigFileProvider : NSObject <ConfigProvider>

// 設定ファイルの更新コールバックリスナー
@property (nonatomic, copy) ConfigStatusCallback listener;

/**
 イニシャライザ

 @param outsideConfigURL 外部設定ファイル
 @param callback コールバック
 @return self
 */
- (id)initWithOutsideConfigURL:(NSString *)outsideConfigURL callback:(ConfigStatusCallback) callback;

/**
 追加設定ファイル

 @param identity Identity
 @param fileName ファイル名
 */
- (void) addConfigWithIdentity:(NSString*) identity fileName:(NSString *)fileName;

/**
 設定ファイルの読み込み（デフォルト用）

 @return ConfigFile
 */
- (ConfigFile*) loadConfig;

/**
 設定ファイルの読み込み

 @param identity Identity
 @return ConfigFile
 */
- (ConfigFile*) loadConfig:(NSString*) identity;

/**
 設定ファイルの上書き

 @param configFileValue 要素群
 @param identity Identity
 */
- (void) setConfig:(NSDictionary*) configFileValue identity:(NSString *)identity;

/**
 設定ファイルの有無

 @param identity Identity
 @return 有無
 */
- (BOOL)hasConfigFileWithIdentity:(NSString *)identity;

@end
