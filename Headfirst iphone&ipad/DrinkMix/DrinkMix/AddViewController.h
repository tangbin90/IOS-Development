//
//  AddViewController.h
//  DrinkMix
//
//  Created by tangbin on 5/5/15.
//  Copyright (c) 2015 tangbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#define INGREDIENTS_KEY @"ingredients"
#define NAME_KEY @"name"
#define DIRECTION_KEY @"directions"
@interface AddViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain)NSMutableArray *drinkArray;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextView *ingredientTextField;
@property (weak, nonatomic) IBOutlet UITextView *directionTextField;
@property (nonatomic, retain) NSDictionary *drink;
@end
