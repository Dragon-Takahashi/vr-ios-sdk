//
//  VValues.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2/3/21.
//  Copyright © 2021 VideoResearch. All rights reserved.
//

#import "VValues.h"

@implementation VValues

- (instancetype)init
{
    self = [super init];
    if (self) {
        _c = nil;
        _r = nil;
        _t = nil;
        _appid = nil;
        _dcid = nil;
        _dnt = nil;
        _dctype = nil;
        _ref = nil;
        _url = nil;
        _pf = nil;
        _pcf = nil;
        _pcs = nil;
        _pct = nil;
        _etime = nil;
        _event = nil;
        _player = nil;
        _ad = nil;
        _roll = nil;
        _pod = nil;
        _adev = nil;
        _metrics = nil;
        _senderid = nil;
        _senderuuid = nil;
        _snederdcos = nil;
        _speed = nil;
        _screen = nil;
        _p = nil;
        _appver = nil;
        _projectid = nil;
        _snsflg = nil;
        _u1 = nil;
        _u2 = nil;
        _u3 = nil;
        _u4 = nil;
        _u5 = nil;
        _u6 = nil;
        _u7 = nil;
        _u8 = nil;
        _u9 = nil;
        _ptag = nil;
        _hci = nil;
        _hca = nil;
        _hce = nil;
        _hpc = nil;
        _hcr = nil;
        _hld = nil;
    }
    return self;
}

- (NSMutableDictionary *) build {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            _c, @"c",
            _r, @"r",
            _t, @"t",
            _appid, @"appid",
            _dcid, @"dcid",
            _dnt, @"dnt",
            _dctype, @"dctype",
            _ref, @"ref",
            _url, @"url",
            _pf, @"pf",
            _pcf, @"pcf",
            _pcs, @"pcs",
            _pct, @"pct",
            _etime, @"etime",
            _event, @"event",
            _player, @"player",
            _ad, @"ad",
            _roll, @"roll",
            _pod, @"pod",
            _adev, @"adev",
            _metrics, @"metrics",
            _senderid, @"senderid",
            _senderuuid, @"senderuuid",
            _snederdcos, @"snederdcos",
            _speed, @"speed",
            _screen, @"screen",
            _p, @"p",
            _appver, @"appver",
            _projectid, @"projectid",
            _snsflg, @"snsflg",
            _u1, @"u1",
            _u2, @"u2",
            _u3, @"u3",
            _u4, @"u4",
            _u5, @"u5",
            _u6, @"u6",
            _u7, @"u7",
            _u8, @"u8",
            _u9, @"u9",
            _ptag, @"ptag",
            _hci, @"hci",
            _hca, @"hca",
            _hce, @"hce",
            _hpc, @"hpc",
            _hcr, @"hcr",
            _hld, @"hld",
            nil];
    
}

@end
