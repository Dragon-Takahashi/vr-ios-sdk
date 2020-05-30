//
//  ConfigAcceptor.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/13/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Acceptor.h"
#import "State.h"

/**
 AcceptorInterface
 */
@interface ConfigAcceptor : NSObject <Acceptor>

// key = identity, value = state
@property (nonatomic, readonly) NSMutableDictionary *stateList;

/**
 送信判定

 @param identity Identity
 @return true:送信OK,false:送信NG
 */
- (BOOL)isOKWithIdentity:(NSString *)identity;

/**
 状態更新

 @param identity Identity
 @param state 状態
 */
- (void)updateWithIdentity:(NSString *)identity state:(NSString *)state;

/**
 状態を文字列で返却

 @return 状態
 */
- (NSString *)toString;

@end
