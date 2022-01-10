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
@property (nonatomic, copy) NSString *vr_opt21;
@property (nonatomic, copy) NSString *vr_opt22;
@property (nonatomic, copy) NSString *vr_opt23;
@property (nonatomic, copy) NSString *vr_opt24;
@property (nonatomic, copy) NSString *vr_opt25;
@property (nonatomic, copy) NSString *vr_opt26;
@property (nonatomic, copy) NSString *vr_opt27;
@property (nonatomic, copy) NSString *vr_opt28;
@property (nonatomic, copy) NSString *vr_opt29;
@property (nonatomic, copy) NSString *vr_opt30;
@property (nonatomic, copy) NSString *vr_opt31;
@property (nonatomic, copy) NSString *vr_opt32;
@property (nonatomic, copy) NSString *vr_opt33;
@property (nonatomic, copy) NSString *vr_opt34;
@property (nonatomic, copy) NSString *vr_opt35;
@property (nonatomic, copy) NSString *vr_opt36;
@property (nonatomic, copy) NSString *vr_opt37;
@property (nonatomic, copy) NSString *vr_opt38;
@property (nonatomic, copy) NSString *vr_opt39;
@property (nonatomic, copy) NSString *vr_opt40;

/**
 要素取得

 @return 要素
 */
- (NSMutableDictionary*) getParams;

@end
