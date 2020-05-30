//
//  VrInteractiveData.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/14.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//


#import "VrInteractiveData.h"
#import "VrInteractiveTracking.h"

@implementation VrInteractiveData

static VrInteractiveData *sharedInstance = nil;
NSMutableDictionary *trackerDict;

#pragma mark - Synchronized Class Methods

+ (VrInteractiveData *)sharedInstance
{
    @synchronized(self) {
        if (sharedInstance == nil) {
            trackerDict = [NSMutableDictionary dictionary];
            (void)[[self alloc] init];
        }
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

#pragma mark - Instance Methods

- (VrInteractiveTracking *)withClass:(NSObject *)classObject
                         withAppName:(NSString *)appName
                       withEventName:(NSString *)eventName
                       withMonitorId:(NSString *)monitorId
{
    return [[VrInteractiveTracking alloc] initWithTracker:NSStringFromClass([classObject class])
                                              withAppName:appName
                                            withEventName:eventName
                                            withMonitorId:monitorId];
}


- (VrInteractiveTracking *)withClass:(NSObject *)classObject
                         withAppName:(NSString *)appName
                       withEventName:(NSString *)eventName
                       withMonitorId:(NSString *)monitorId
                     finishInitBlock:(FinishInitBlock)finishInitBlock
{
    return [[VrInteractiveTracking alloc] initWithTracker:NSStringFromClass([classObject class])
                                              withAppName:appName
                                            withEventName:eventName
                                            withMonitorId:monitorId
                                          finishInitBlock:finishInitBlock];
}


- (VrInteractiveTracking *)withClass:(NSObject *)classObject
                         withAppName:(NSString *)appName
                       withEventName:(NSString *)eventName
                       withMonitorId:(NSString *)monitorId
                          withOptFlg:(BOOL)optFlg
                withOutsideConfigURL:(NSString *)outsideConfigURL
{
    return [[VrInteractiveTracking alloc] initWithTracker:NSStringFromClass([classObject class])
                                              withAppName:appName
                                            withEventName:eventName
                                            withMonitorId:monitorId
                                               withOptFlg:optFlg
                                     withOutsideConfigURL:outsideConfigURL];
}


- (VrInteractiveTracking *)withClass:(NSObject *)classObject
                         withAppName:(NSString *)appName
                       withEventName:(NSString *)eventName
                       withMonitorId:(NSString *)monitorId
                     finishInitBlock:(FinishInitBlock)finishInitBlock
                          withOptFlg:(BOOL)optFlg
                withOutsideConfigURL:(NSString *)outsideConfigURL
{
    return [[VrInteractiveTracking alloc] initWithTracker:NSStringFromClass([classObject class])
                                              withAppName:appName
                                            withEventName:eventName
                                            withMonitorId:monitorId
                                          finishInitBlock:finishInitBlock
                                               withOptFlg:optFlg
                                     withOutsideConfigURL:outsideConfigURL];
}

@end

