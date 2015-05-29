//
//  DetailViewController.h
//  RetroPhoneHunter
//
//  Created by Paul Pilone on 5/5/13.
//  Copyright (c) 2013 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "PhotoBooth.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate,UIActionSheetDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) PhotoBooth *detailItem;
@end
