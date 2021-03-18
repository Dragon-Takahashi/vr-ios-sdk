//
//  HouseKeeper.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/18.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OldTableRepository.h"

/**
 HouseKeeperクラス
 */
@interface HouseKeeper : NSObject <OldTableRepository>
/**
 旧SDKのDB削除をコントロール
 */
+ (void)drop;
@end
