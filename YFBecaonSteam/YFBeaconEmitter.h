//
//  YFBeaconEmitter.h
//  YFBecaonSteam
//
//  Created by ky on 16/3/30.
//  Copyright © 2016年 ky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YFBeaconEmitter : NSObject

@property (nonatomic, copy) NSString *emitterId;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@end
