//
//  SendNullRepository.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/08.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "SendNullRepository.h"

@implementation SendNullRepository

/**
 * このクラスの役割を再度確認させてください。
 *
 *
 *
 */
+ (Response*) send:(BeaconEvent*) event callback:(BeaconCallback) callback {
    if (callback) {
        // 送信URIを返す
        callback([[[event getURI] toURI] absoluteString]);
    }
    return [Response new];
}

+ (BOOL) ensure {
    return NO;
}

@end
