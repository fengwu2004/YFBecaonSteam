//
//  YFBecaonSteam.m
//  YFBecaonSteam
//
//  Created by ky on 16/3/30.
//  Copyright © 2016年 ky. All rights reserved.
//

#import "YFBeaconSteamCollecter.h"
#import <CoreLocation/CoreLocation.h>
#import "YFBeaconEmitter.h"
#import "YFBecaonStreamData.m"

@interface YFBeaconSteamCollecter()<CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager * locationManager;
@property (nonatomic, retain) NSMutableDictionary *allEmitters;

@end

@implementation YFBeaconSteamCollecter

- (instancetype)initWithSource:(NSArray<__kindof YFBeaconEmitter*>*)emitters delegate:(id<YFBeaconSteamCollecterDelegate>)delegate {
    
    self = [super init];
    
    if (!self) {
        
        return nil;
    }
    
    _delegate = delegate;
    
    _locationManager = [[CLLocationManager alloc] init];
    
    [_locationManager setDelegate:self];
    
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        [_locationManager requestWhenInUseAuthorization];
        
        [_locationManager requestAlwaysAuthorization];
    }
    
    _allEmitters = [[NSMutableDictionary alloc] init];
    
    for (YFBeaconEmitter *emitter in emitters) {
        
        [_allEmitters setObject:emitter forKey:emitter.emitterId];
    }
    
    return self;
}

#pragma mark --CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager*)manager didRangeBeacons:(NSArray*)beacons inRegion:(CLBeaconRegion*)region {

    NSArray *output = [self transBeaconData:beacons];
    
    [_delegate onReceiveBeaconData:output sender:self];
}

- (NSArray*)transBeaconData:(NSArray<__kindof CLBeacon*>*)beacons {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSTimeInterval time = [NSDate date].timeIntervalSince1970;
    
    for (CLBeacon *beacon in beacons) {
        
        YFBecaonStreamData *data = [[YFBecaonStreamData alloc] init];
        
        NSString *emitterID = beacon.proximityUUID.UUIDString;
        
        YFBeaconEmitter *emitter = [_allEmitters objectForKey:emitterID];
        
        data.emitterID = emitterID;
        
        data.time = time;
        
        data.x = emitter.x;
        
        data.y = emitter.y;
        
        data.r = beacon.rssi;
        
        data.M = [beacon.minor floatValue];
        
        data.bM = YES;
        
        [array addObject:data];
    }
    
    return [array copy];
}


@end
