//
//  Fugitive.h
//  Fugitives
//
//  Created by tangbin on 5/9/15.
//  Copyright (c) 2015 tangbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Fugitive : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * bounty;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * fugitiveID;
@property (nonatomic, retain) NSString * desc;

@end
