//
//  PhotoBooth.h
//  RetroPhoneHunter
//
//  Created by tangbin on 5/24/15.
//  Copyright (c) 2015 Element 84, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>



@interface PhotoBooth : NSManagedObject<MKAnnotation>

@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * imagePath;
@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * lon;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (NSString *)title;
- (NSString *)subtitle;

@end
