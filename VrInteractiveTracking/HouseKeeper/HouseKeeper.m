//
//  HouseKeeper.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/18.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "HouseKeeper.h"
#import "../Infra/OldTableRepositoryImpl.h"


@implementation HouseKeeper
/**
 * 旧SDKのDB削除をコントロール
 * 一度だけ実行
 */
+ (void)drop {
    [OldTableRepositoryImpl drop];
}

@end


