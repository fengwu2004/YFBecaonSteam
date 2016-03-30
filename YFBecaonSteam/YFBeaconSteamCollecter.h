//
//  YFBecaonSteam.h
//  YFBecaonSteam
//
//  Created by ky on 16/3/30.
//  Copyright © 2016年 ky. All rights reserved.
//

#import <Foundation/Foundation.h>


@class YFBeaconEmitter;
@class YFBecaonStreamData;
@class YFBeaconSteamCollecter;

@protocol YFBeaconSteamCollecterDelegate <NSObject>

- (void)onReceiveBeaconData:(NSArray<__kindof YFBecaonStreamData*>*)datalist sender:(YFBeaconSteamCollecter*)sender;

@end

@interface YFBeaconSteamCollecter : NSObject

@property (nonatomic, weak) id<YFBeaconSteamCollecterDelegate> delegate;

- (instancetype)initWithSource:(NSArray<__kindof YFBeaconEmitter*>*)emitters delegate:(id<YFBeaconSteamCollecterDelegate>)delegate;

@end
