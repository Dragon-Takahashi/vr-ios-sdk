//
//  Config.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/20.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#ifndef Config_h
#define Config_h

/**
 * 設定ファイル情報Interface
 */
@protocol Config <NSObject>
@required

@property (nonatomic, copy, getter=getVr_TagId1, setter=setVr_TagId1:) NSString *vr_TagId1;
@property (nonatomic, copy, getter=getVr_TagId2, setter=setVr_TagId2:) NSString *vr_TagId2;
@property (nonatomic, copy, getter=getTag_Url, setter=setTag_Url:) NSString *tag_Url;
@property (nonatomic, copy, getter=getConfig_Url, setter=setConfig_Url:) NSString *config_Url;
@property (nonatomic, copy, getter=getConfig_timeout, setter=setConfig_timeout:) NSString *config_timeout;
@property (nonatomic, copy, getter=getBeacon_timeout, setter=setBeacon_timeout:) NSString *beacon_timeout;
@property (nonatomic, copy, getter=getBeacon_url, setter=setBeacon_url:) NSString *beacon_url;

@end


#endif /* Config_h */
