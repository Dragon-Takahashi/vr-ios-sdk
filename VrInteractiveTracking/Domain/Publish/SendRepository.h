//
//  SendRepository.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/08.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#ifndef SendRepository_h
#define SendRepository_h

#import "Response.h"
#import "BeaconEvent.h"

typedef void (^BeaconCallback) (NSString *url);

/**
 ビーコン送信処理Interface
 */
@protocol SendRepository
@required


+ (void) send:(BeaconEvent*) event callback:(BeaconCallback) callback;

+ (BOOL) ensure;

@end

#endif /* SendRepository_h */
