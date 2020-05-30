//
//  OldTableRepository.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/18.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#ifndef OldTableRepository_h
#define OldTableRepository_h

/**
 旧テーブル削除Interface
 */
@protocol OldTableRepository <NSObject>
@required
+(void)drop;
@end

#endif /* OldTableRepository_h */


