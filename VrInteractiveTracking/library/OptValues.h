//
//  OptValues.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/11.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 クエリパラメータ情報一括格納クラス
 */
@interface OptValues : NSObject

@property (nonatomic, copy) NSString *vr_opt1;
@property (nonatomic, copy) NSString *vr_opt2;
@property (nonatomic, copy) NSString *vr_opt3;
@property (nonatomic, copy) NSString *vr_opt4;
@property (nonatomic, copy) NSString *vr_opt5;
@property (nonatomic, copy) NSString *vr_opt6;
@property (nonatomic, copy) NSString *vr_opt7;
@property (nonatomic, copy) NSString *vr_opt8;
@property (nonatomic, copy) NSString *vr_opt9;
//@property (nonatomic, copy) NSString *vr_opt10;
//@property (nonatomic, copy) NSString *vr_opt11;
//@property (nonatomic, copy) NSString *vr_opt12;
//@property (nonatomic, copy) NSString *vr_opt13;
@property (nonatomic, copy) NSString *vr_opt14;
@property (nonatomic, copy) NSString *vr_opt15;
@property (nonatomic, copy) NSString *vr_opt16;
@property (nonatomic, copy) NSString *vr_opt17;
@property (nonatomic, copy) NSString *vr_opt18;
@property (nonatomic, copy) NSString *vr_opt19;
@property (nonatomic, copy) NSString *vr_opt20;

/**
 要素取得

 @return 要素
 */
- (NSMutableDictionary*) getParams;

@end
