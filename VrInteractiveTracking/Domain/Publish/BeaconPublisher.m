//
//  BeaconPublisher.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/08.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "BeaconPublisher.h"

@interface BeaconPublisher()

@property (nonatomic) NSMutableArray *sendQueue;
@property (nonatomic) BOOL isRunning;

@end

@implementation BeaconPublisher

/**
 * コンストラクタ
 *
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        _sendType = [SendType new];
        _sendQueue = [NSMutableArray array];
    }
    return self;
}


/**
 送信キューへ登録

 @param uri 送信先情報
 @param eventName 送信タイプ
 */
- (void)add:(URI*) uri eventName:(NSString *)eventName {
    
    // BeaconEventを作成し登録
    [_sendQueue addObject:[[BeaconEvent alloc] initWithParam:[EventIdentity new] uri:uri eventName:eventName]];
    
    // 送信
    [self publish];
}

/**
 登録されているキューを送信

 */
- (void)publish{
    
    if ([_sendQueue count] == 0 || _isRunning) {
        return;
    }
    
    // 作業フラグを立てる
    _isRunning = YES;
    
    // 送信情報の取得
    BeaconEvent *event = [_sendQueue firstObject];
    
    // 送信先指定
    NSLog(@"BeaconPublisher publish : event name is %@", event.eventName);
    [_sendType sendTypeOf:event.eventName];
    
    // 送信
    [_sendType send:event callback:^(NSString *url) {
        // キューの削除
        if ([_sendQueue count] != 0) {
            [_sendQueue removeObjectAtIndex:0];
        }
        
        // 作業フラグを下ろす
        _isRunning = NO;
        
        // 次の送信キューを実行
        [self publish];
    }];
}

@end
