//
//  BeaconProvider.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/08.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "BeaconProvider.h"

#import "../Opt.h"

@interface BeaconProvider()
@property (nonatomic) BeaconPublisher *beaconPublisher;
@property (nonatomic) NSMutableArray *queue;

@end

@implementation BeaconProvider

/**
 * コンストラクタ
 *
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        _queue = [NSMutableArray array];
        _beaconPublisher = [BeaconPublisher new];
    }
    return self;
}

/**
 キューに追加

 @param spec パラメータ群
 @param config 設定ファイル情報
 @return 結果（YES = 成功, NO = 失敗）
 */
- (BOOL) addWithQuerySpec:(NSString *)baseUrl spec:(QuerySpec *)spec configFile:(ConfigFile *)config forceValue:(QueryParameters *)forceValue state:(BOOL)isOK finishBlock:(FinishSendBeaconBlock )finishBlock {
    
    // URI生成
    URI *uri = [[URI alloc] initWithQuerySpec:baseUrl spec:spec configFile:config forceValue:forceValue finishBlock:finishBlock];
    
    // 設定ファイルのステータス判断
    if (isOK) {
        NSLog(@"Add send queue");
        // キューを実行
        [self pop:uri];
    }else {
        NSLog(@"Add config queue");
        // キューに追加
        [_queue addObject:uri];
    }
    
    return YES;
    
}
- (BOOL) addDirect:(NSString*) directUrl configFile:(ConfigFile *)config state:(BOOL)isOK finishBlock:(FinishSendBeaconBlock )finishBlock {
    
    // URI生成
    URI *uri = [[URI alloc] initWithDirectURL:directUrl configFile:config finishBlock:finishBlock];
    
    // URLが生成出来ているか判断
    if (![[uri toURI] absoluteString]) {
        NSLog(@"URI is not prepared");
        return NO;
    }
    
    // 設定ファイルのステータス判断
    if (isOK) {
        NSLog(@"Add send queue for direct");
        // キューを実行
        [self pop:[uri copy]];
    }else {
        NSLog(@"Add config queue for direct");
        // キューに追加
        [_queue addObject:[uri copy]];
    }
    
    return YES;
}

- (void) sendQueue:(ConfigFile *)configFile {
    
    // キューの数を判断
    if ([_queue count] == 0) {
        return;
    }
    
    // 該当のidentityのキューのみを実行
    NSMutableArray *discards = [NSMutableArray array];
    for (int i = 0; i < [_queue count]; i++) {
        if ([[_queue[i] getIdentity] isEqualToString:[configFile getIdentity]]) {
            [discards insertObject:[NSNumber numberWithInt:i] atIndex:0];
            URI *uri = _queue[i];
            [uri setConfigFile:configFile];
            [self pop:uri];
        }
    }
    
    // 送信済みキューの削除
    for (NSNumber *num in discards) {
        [_queue removeObjectAtIndex:[num integerValue]];
    }
}

/**
 * ビーコンを送信
 *
 */

/**
 送信キューに登録

 @param uri 送信情報
 @return 結果
 */
- (BOOL) pop:(URI *)uri {
    // 送信先の指定
    NSString *eventName = [self getEventName:[uri getDisabled]];
    
    // 送信
    NSLog(@"BeaconProvider pop : event name is %@", eventName);
    [_beaconPublisher add:uri eventName:eventName];
    
    return YES;
}

- (NSString *)getEventName:(BOOL) disabled {
    NSLog(@"getEventName disabled = %@", disabled?@"YES":@"NO");
    if (disabled) {
        NSLog(@"getEventName type STAND_BY");
        return _beaconPublisher.sendType.STAND_BY;
    }else {
        NSLog(@"getEventName type RUNNING");
        return _beaconPublisher.sendType.RUNNING;
    }
}


- (NSMutableArray*) getBeaconQue {
    return _queue;
}

@end
