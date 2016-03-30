//
//  YFBeaconDataCollecter.m
//  YFBeaconDataCollecter
//
//  Created by ky on 16/3/30.
//  Copyright © 2016年 ky. All rights reserved.
//

#import "YFBeaconDataCollecter.h"
#import <CoreLocation/CoreLocation.h>
#import "YFBecaonStreamData.m"
#include "YFBeaconData.h"


@interface YFBeaconDataCollecter()<CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager * locationManager;
@property (nonatomic, retain) NSMutableDictionary *allEmitters;

@end

@implementation YFBeaconDataCollecter

+ (instancetype)sharedInstance {
    
    static YFBeaconDataCollecter *_instance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _instance = [[YFBeaconDataCollecter alloc] init];
    });
    
    return _instance;
}

- (instancetype)init {
    
    self = [super init];
    
    if (!self) {
        
        return nil;
    }
    
    beaconProcesser = nil;
    
    _locationManager = [[CLLocationManager alloc] init];
    
    [_locationManager setDelegate:self];
    
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        [_locationManager requestWhenInUseAuthorization];
        
        [_locationManager requestAlwaysAuthorization];
    }
    
    _allEmitters = [[NSMutableDictionary alloc] init];
    
    return self;
}

- (void)setBeaconProcesser:(YFBeaconDataProcesser*)processer {
    
    beaconProcesser = processer;
}

#pragma mark --CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager*)manager didRangeBeacons:(NSArray*)beacons inRegion:(CLBeaconRegion*)region {

    std::vector<YFBeaconData> allData;
    
    for (CLBeacon *beacon in beacons) {
        
        NSString *emitterID = beacon.proximityUUID.UUIDString;
        
        std::string strId = [emitterID UTF8String];
        
        double x = 0, y = 0;
        
        if (beaconProcesser->GetPos(strId, x, y)) {
            
            allData.push_back(dataAdapter(beacon, x, y));
        }
    }
    
    if (beaconProcesser) {
        
        beaconProcesser->ProcessData(allData);
    }
}

YFBeaconData dataAdapter(CLBeacon* beacon, double x, double y) {
    
    NSString *emitterID = beacon.proximityUUID.UUIDString;
    
    YFBeaconData data;
    
    data.strId = [emitterID UTF8String];
    
    data.x = x;
    
    data.y = y;
    
    data.r = beacon.rssi;
    
    data.M = [beacon.minor floatValue];
    
    data.bM = true;
    
    return data;
}

@end
