//
//  Status.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/03.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Response用Statusクラス
 */
@interface Status : NSObject

/**
 イニシャライザ

 @param status 状態
 @return self
 */
- (instancetype) initWithStatus:(NSString*) status;

/**
 状態取得

 @return 状態
 */
- (NSString*) getStatus;

@end
