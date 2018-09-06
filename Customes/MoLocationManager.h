//
//  MoLocationManager.h
//  money
//
//  Created by fancymf on 2018/8/15.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
typedef void(^MoLocationSuccess) (double lat, double lng);
typedef void(^MoLocationFailed) (NSError *error);

@interface MoLocationManager : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager *manager;
    MoLocationSuccess successCallBack;
    MoLocationFailed failedCallBack;
}

+ (MoLocationManager *) sharedGpsManager;

+ (void) getMoLocationWithSuccess:(MoLocationSuccess)success Failure:(MoLocationFailed)failure;

+ (void) stop;

@end
