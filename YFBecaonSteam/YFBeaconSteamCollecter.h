//
//  YFBeaconSteamCollecter.h
//  YFBeaconSteamCollecter
//
//  Created by ky on 16/3/30.
//  Copyright © 2016年 ky. All rights reserved.

#import <Foundation/Foundation.h>

/*
 YFBeaconSteamCollecter
 
 说明：蓝牙发射器数据采集
 */

@class YFBeaconEmitter;
@class YFBecaonStreamData;
@class YFBeaconSteamCollecter;

@protocol YFBeaconSteamCollecterDelegate <NSObject>

- (void)onReceiveBeaconData:(NSArray<YFBecaonStreamData*>*)outputData sender:(YFBeaconSteamCollecter*)sender;

@end

@interface YFBeaconSteamCollecter : NSObject

@property (nonatomic, weak) id<YFBeaconSteamCollecterDelegate> delegate;

- (instancetype)initWithSource:(NSArray<YFBeaconEmitter*>*)emitters delegate:(id<YFBeaconSteamCollecterDelegate>)delegate;

@end
