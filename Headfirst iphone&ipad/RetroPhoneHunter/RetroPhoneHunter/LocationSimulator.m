//
//  LocationSimulator.m
//  RetroPhoneHunter
//
//  Created by tangbin on 5/29/15.
//  Copyright (c) 2015 Element 84, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#ifdef TARGET_IPHONE_SIMULATOR
@interface CLLocationManager (Simulator)
@end

@implementation CLLocationManager (Simulator)

-(void)startUpdatingLocation
{
    float latitude = 32.061;
    float longitude = 118.79125;
    CLLocation *setLocation= [[[CLLocation alloc] initWithLatitude:latitude longitude:longitude] autorelease];
    [self.delegate locationManager:self didUpdateToLocation:setLocation
                      fromLocation:setLocation];
}
@end
#endif // TARGET_IPHONE_SIMULATOR
