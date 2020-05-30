//
//  XMLPull.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/01.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "XMLPull.h"

#import "../Domain/VRIException.h"

@interface XMLPull()
@property (nonatomic) NSString *date;
@property (nonatomic) NSURLSession *configConnection;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, copy) NSString *identity;
@property (nonatomic, copy) NSString *configFilePath;
@end

@implementation XMLPull


- (void) getXml:(NSString*) url identity:(NSString*) identity configTimeout:(NSString *)configTimeout callback:(XmlPullCallback) callback {
    
    _listener = callback;
    _filePath = url;
    _identity = identity;
    
    _filePathComponent = @"Remote";
    
    NSLog(@"configUrl:%@",_filePath);
    
    @try {
        NSURL *encodedUrl = [NSURL URLWithString:[_filePath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:encodedUrl
                                                 cachePolicy:NSURLRequestReloadIgnoringCacheData
                                             timeoutInterval:[configTimeout doubleValue]];
        
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        sessionConfiguration.timeoutIntervalForRequest = [configTimeout doubleValue];
        sessionConfiguration.timeoutIntervalForResource = [configTimeout doubleValue];
        _configConnection = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                         delegate:self
                                                    delegateQueue:[NSOperationQueue currentQueue]];
        NSURLSessionDataTask *task = [_configConnection dataTaskWithRequest:request];
        
        [task resume];
        
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
        @throw [VRIException exceptionWithMessage:@"Remote config url has problem"];
        return;
    }

}



#pragma mark NSURLSession Delegate

/**
 * HTTPリクエストのデリゲートメソッド(データ受け取り初期処理)
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    long statusCode = [((NSHTTPURLResponse *)response) statusCode];
    NSLog(@"ステータスコード：%ld", statusCode);

    // ステータスコード200以外
    if (statusCode != 200) {
        [dataTask cancel];
        
    } else {
        // 設定ファイルの取得に成功した場合、HTTPHeaderの日付を取得する
        NSHTTPURLResponse *hres = (NSHTTPURLResponse *)response;
        NSDictionary *dict = [hres allHeaderFields];
        NSLog(@"HTTP Header Date : %@", [dict objectForKey:@"Date"]);
        
        // configファイルの取得日時をセットする（dataに設定）
        _date = [dict objectForKey:@"Date"];
    }
    
    // didReceivedData と didCompleteWithError が呼ばれるように、通常継続の定数をハンドラーに渡す
    completionHandler(NSURLSessionResponseAllow);
}

/**
 * HTTPリクエストのデリゲートメソッド(受信の度に実行)
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    // このConfigFileから送られたかを判断
    if (session == _configConnection) {
        // Documentsディレクトリパス
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        NSString *documentsDirPath = [paths objectAtIndex:0];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = NO;
        if ([fileManager fileExistsAtPath:[documentsDirPath stringByAppendingPathComponent:_filePathComponent] isDirectory:&isDir] == NO) {
            [fileManager createDirectoryAtPath:[documentsDirPath stringByAppendingPathComponent:_filePathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString *configPath = [[documentsDirPath stringByAppendingPathComponent:_filePathComponent] stringByAppendingPathComponent:@"vrTrackingConfig.xml"];
        // 設定ファイルが存在しなければ作成する
        if (![fileManager fileExistsAtPath:configPath]) {
            [fileManager createFileAtPath:configPath contents:[NSData data] attributes:nil];
        }
        
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSRange range = [dataStr rangeOfString:@"<Error>"];
        // エラーが見つかったらコールバックして終了
        if (range.location != NSNotFound) {
            
            if (_listener) {
                NSLog(@"3");
                _listener(nil, nil, _identity, nil);
            }
            return;
        }
        
        // 設定ファイルの書き込み
        [data writeToFile:configPath atomically:YES];
        dataStr = nil;
        NSLog(@"save config6 : %@",configPath);
        _configFilePath = configPath;
    }
}

/**
 * HTTPリクエストのデリゲートメソッド(完了処理)
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error) {
        // 接続失敗処理
        NSLog(@"%@", error);
        if (_listener) {
            NSLog(@"4");
            _listener(nil, nil, _identity, nil);
        }
    } else {
        if (_listener) {
            _listener(_configFilePath, _date, _identity, _filePath);
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // HTTPリクエスト失敗処理
    NSLog(@"URL connection is faild with error. %@", error);
    if (_listener) {
        _listener(nil, nil, _identity, nil);
    }
}

@end
