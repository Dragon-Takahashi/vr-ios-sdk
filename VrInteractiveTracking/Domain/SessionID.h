//
//  SessionID.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 3/15/20.
//  Copyright © 2020 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
* SessionIDクラス
*/
@interface SessionID : NSObject

/**
 * セッションIDを取得する
 * @return セッションID
 */
- (NSString *) getSessionID;

/**
 * セッションIDを作成する
 * @return セッションID
 */
- (NSString *) createUUID;

/**
 * セッションIDを新規に生成する
 * @return セッションIDインスタンス
 */
- (SessionID *) newSessionID;


- (BOOL) equals:(NSObject*)o;

@end

NS_ASSUME_NONNULL_END
