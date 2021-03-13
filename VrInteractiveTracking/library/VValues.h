//
//  VValues.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2/3/21.
//  Copyright © 2021 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VValues : NSObject

@property (nonatomic, copy) NSString *c;
@property (nonatomic, copy) NSString *r;
@property (nonatomic, copy) NSString *t;
@property (nonatomic, copy) NSString *appid;
@property (nonatomic, copy) NSString *dcid;
@property (nonatomic, copy) NSString *dnt;
@property (nonatomic, copy) NSString *dctype;
@property (nonatomic, copy) NSString *ref;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *pf;
@property (nonatomic, copy) NSString *site;
@property (nonatomic, copy) NSString *pc;
@property (nonatomic, copy) NSString *pcs;
@property (nonatomic, copy) NSString *pct;
@property (nonatomic, copy) NSString *etime;
@property (nonatomic, copy) NSString *event;
@property (nonatomic, copy) NSString *player;
@property (nonatomic, copy) NSString *ad;
@property (nonatomic, copy) NSString *roll;
@property (nonatomic, copy) NSString *pod;
@property (nonatomic, copy) NSString *adev;
@property (nonatomic, copy) NSString *metrics;
@property (nonatomic, copy) NSString *senderid;
@property (nonatomic, copy) NSString *senderuuid;
@property (nonatomic, copy) NSString *senderdcos;
@property (nonatomic, copy) NSString *speed;
@property (nonatomic, copy) NSString *screen;
@property (nonatomic, copy) NSString *p;
@property (nonatomic, copy) NSString *appver;
@property (nonatomic, copy) NSString *projectid;
@property (nonatomic, copy) NSString *snsflg;
@property (nonatomic, copy) NSString *u1;
@property (nonatomic, copy) NSString *u2;
@property (nonatomic, copy) NSString *u3;
@property (nonatomic, copy) NSString *u4;
@property (nonatomic, copy) NSString *u5;
@property (nonatomic, copy) NSString *u6;
@property (nonatomic, copy) NSString *u7;
@property (nonatomic, copy) NSString *u8;
@property (nonatomic, copy) NSString *u9;
@property (nonatomic, copy) NSString *ptag;
@property (nonatomic, copy) NSString *hci;
@property (nonatomic, copy) NSString *hca;
@property (nonatomic, copy) NSString *hce;
@property (nonatomic, copy) NSString *hpc;
@property (nonatomic, copy) NSString *hcr;
@property (nonatomic, copy) NSString *hld;

- (NSMutableDictionary *) build;

@end
