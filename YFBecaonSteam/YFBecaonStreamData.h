//
//  YFBecaonStreamData.h
//  YFBeaconSteamCollecter
//
//  Created by ky on 16/3/30.
//  Copyright © 2016年 ky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YFBecaonStreamData : NSObject

@property (nonatomic, retain) NSString *emitterID;
@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat r;
@property (nonatomic, assign) CGFloat A;
@property (nonatomic, assign) CGFloat M;
@property (nonatomic, assign) BOOL bM;

@end
