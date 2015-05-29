//
//  ViewController.h
//  InstaEmail
//
//  Created by tangbin on 4/21/15.
//  Copyright (c) 2015 tangbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageUI/MFMailComposeViewController.h"

@interface ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic) NSArray* activities;
@property (nonatomic) NSArray* feelings;
@property (weak, nonatomic) IBOutlet UIPickerView *emailPicker;
//@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *textField;


@end

