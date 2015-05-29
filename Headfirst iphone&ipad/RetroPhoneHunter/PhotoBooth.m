//
//  PhotoBooth.m
//  RetroPhoneHunter
//
//  Created by tangbin on 5/24/15.
//  Copyright (c) 2015 Element 84, LLC. All rights reserved.
//

#import "PhotoBooth.h"


@implementation PhotoBooth

@dynamic city;
@dynamic imagePath;
@dynamic lat;
@dynamic lon;
@dynamic name;
@dynamic notes;
@dynamic coordinate;

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake([self.lat doubleValue],
                                      [self.lon doubleValue]);
}

- (NSString *)title
{
    return self.name;
}

- (NSString *)subtitle
{
    return self.notes;
}

@end
