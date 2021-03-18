//
//  BeaconProvider.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/08.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QuerySpec.h"
#import "ConfigProvider.h"
#import "BeaconPublisher.h"

/**
 ビーコン提供クラス
 */
@interface BeaconProvider : NSObject

typedef void (^FinishSendBeaconBlock) (BOOL result);

/**
 ビーコン追加

 @param baseUrl 上書き用URL
 @param spec QuerySpec
 @param config 設定ファイル
 @param forceValue 強制上書き用の情報
 @param isOK 更新状態
 @param finishBlock コールバック
 @return 追加結果
 */
- (BOOL) addWithQuerySpec:(NSString *)baseUrl spec:(QuerySpec *)spec configFile:(ConfigFile *)config forceValue:(QueryParameters *)forceValue state:(BOOL)isOK finishBlock:(FinishSendBeaconBlock )finishBlock;

/**
 ダイレクトURL用のビーコン追加

 @param directUrl ダイレクトURL
 @param config 設定ファイル
 @param isOK 更新状態
 @param finishBlock コールバック
 @return 追加結果
 */
- (BOOL) addDirect:(NSString*) directUrl configFile:(ConfigFile *)config state:(BOOL)isOK finishBlock:(FinishSendBeaconBlock )finishBlock;

/**
 更新ファイル反映（ファイル更新コールバック後に実行）

 @param configFile 設定ファイル
 */
- (void) sendQueue:(ConfigFile *)configFile;

/**
 ビーコン送信

 @param uri URI
 @return 送信結果
 */
- (BOOL) pop:(URI *)uri ;

/**
 設定ファイルの更新待ちリストの取得

 @return 設定ファイルの更新待ちリスト
 */
- (NSMutableArray*) getBeaconQue;

@end
