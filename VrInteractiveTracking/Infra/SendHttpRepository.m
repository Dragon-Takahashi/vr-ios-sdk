//
//  SendHttpRepository.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/08.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "SendHttpRepository.h"

#import "../Domain/VRIException.h"

@implementation SendHttpRepository

/**
 * サーバーへ送信し、レスポンスを返却する
 *
 * @param event 送信情報
 *
 */
+ (void) send:(BeaconEvent*) event callback:(BeaconCallback) callback {
    
    @try {
        
        NSLog(@"SendHttpRepository send start url = %@",[[event getURI] toURI]);
        NSURL *beaconURL = [[event getURI] toURI];
        NSLog(@"エンコード後ビーコン送信URL：%@", [beaconURL absoluteString]);
        
        // 設定ファイルからタイムアウト時間を取得
        NSTimeInterval interval = [[[event getURI] getBeaconTimeout] doubleValue];
        
        // リクエスト作成
        NSURLRequest *request = [NSURLRequest requestWithURL:beaconURL
                                                 cachePolicy:NSURLRequestUseProtocolCachePolicy
                                             timeoutInterval:interval];
        
        __block FinishSendBeaconBlock finishBlock = [[event getURI] getFinishBlock];
        
        // Configuration設定
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        // Timeout設定
        sessionConfiguration.timeoutIntervalForRequest = interval;
        sessionConfiguration.timeoutIntervalForResource = interval;
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                              delegate:nil
                                                         delegateQueue:nil];
        NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *taskResponse, NSError *taskError) {
            Response *response = nil;
            @try {
                
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)taskResponse;
                Status *status = [[Status alloc] initWithStatus:[NSString stringWithFormat:@"%ld", (long)httpResponse.statusCode]];
                Text *text = [[Text alloc] initWithText:[taskError localizedFailureReason]];
                NSLog(@"finish http connection : %@", [status getStatus]);
                
                response = [[Response alloc] initWithResult:status text:text];
                
                // エラー処理
                if (![[status getStatus] isEqualToString:@"200"]) {
                    @throw [NSException exceptionWithName:@"VrInteractiveTrackingException" reason:[NSString stringWithFormat:@"Beacon send status is %@", [status getStatus]] userInfo:nil];
                }
            } @catch (NSException *exception) {
                DLog(@"%@", [exception reason]);
            } @finally {
                // コールバック
                if (finishBlock) {
                    finishBlock([[[response getStatus] getStatus] isEqualToString:@"200"]);
                }
                if (callback) {
                    callback([beaconURL absoluteString]);
                }
            }
            
            

            
        }];
        [task resume];

    } @catch (NSException *exception) {
        @throw [VRIException exceptionWithMessage:[exception reason]];
    }
}

/**
 * 何を確保する意図でしょうか？
 *
 *
 */
+ (BOOL) ensure {
    return NO;
}

@end
