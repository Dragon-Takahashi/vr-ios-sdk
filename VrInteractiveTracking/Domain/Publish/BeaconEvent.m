//
//  BeaconEvent.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/04.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "BeaconEvent.h"

@interface BeaconEvent() {
    
}
@end

@implementation BeaconEvent

/**
 * コンストラクタ
 *
 * @param eventId ユニークなID
 * @param uri URL情報
 *
 */
- (instancetype) initWithParam:(EventIdentity*) eventId uri:(URI*) uri eventName:(NSString *)eventName {
    if((self = [super init])){
        _eventId = eventId;
        _uri = uri;
        _eventName = eventName;
        [self occurredOn];
    }
    return self;
}

/**
 * Identityクラスを返却
 *
 * @return 初期化時に設定されたIdentityクラス
 */
- (NSString*) getEventIdentity {
    // ユニークなIDを返却
    return [_eventId getEventIdentity];
}

/**
 * 現在時刻を取得して返却
 *
 * @return 現在時刻（基準地点=en_US）
 */
- (NSDate*) occurredOn {
    if (!_date) {
        // 現在時刻取得
        _date = [NSDate date];
    }
    return _date;
}

/**
 * URIクラスを返却
 *
 * @return 初期化時に設定したURIクラス
 */
- (URI*) getURI {
    return _uri;
}


@end
