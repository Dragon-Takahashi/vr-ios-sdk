//
//  SendAcceptor.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/13/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 送信Acceptorクラス
 */
@interface SendAcceptor : NSObject

/**
 状態更新
 
 @param identity Identity
 @param isOK 状態
 */
- (void)updateWithIdentity:(NSString *)identity state:(BOOL)isOK ;

/**
 送信判定
 
 @param identity Identity
 @return true:送信OK,false:送信NG
 */
- (BOOL)isOkWithIdentity:(NSString *)identity;

/**
 状態を文字列で返却
 
 @return 状態
 */
- (NSString *)toString;

@end
