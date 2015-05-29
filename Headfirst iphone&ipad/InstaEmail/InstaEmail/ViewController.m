//
//  ViewController.m
//  InstaEmail
//
//  Created by tangbin on 4/21/15.
//  Copyright (c) 2015 tangbin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *sendEmailButton;

@end

@implementation ViewController


@synthesize emailPicker=_emailPicker;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.activities=[[NSArray alloc] initWithObjects:@"sleeping",@"eating",@"working",@"thinking",@"crying", @"begging",@"leaving",@"shopping",@"hello worlding" ,nil];
    self.feelings = [[NSArray alloc] initWithObjects:@"awesome",@"sad",@"happy",@"ambivalent",@"nauseous",@"psyched", nil];
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}
#pragma mark Actions
- (IBAction)sendButtonTapped:(id)sender {
    NSLog(@"Email button tapped!");
    NSString* theMessage = [NSString stringWithFormat:@"%@ I'm %@ and feeling %@ about it.",self.textField.text?self.textField.text:@"",
    [self.activities objectAtIndex:[_emailPicker selectedRowInComponent:0]],
    [self.feelings objectAtIndex:[_emailPicker selectedRowInComponent:1]]];
    NSLog(@"%@",theMessage);
    
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController* mailController=[[MFMailComposeViewController alloc]init];
        mailController.mailComposeDelegate=self;
        [mailController setSubject:@"Hello Renee"];
        [mailController setMessageBody:theMessage isHTML:NO];
        [self presentViewController:mailController animated:YES completion:nil];
    
    }else
    {
        NSLog(@"Sorry, you need to setup mail first!");
    }
}

#pragma mark Mail composer delegate method

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error;
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component==0)
        return [self.activities count];
    else
    {
        return [self.feelings count];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0)
    {
        return [self.activities objectAtIndex:row];
    }else
    {
        return [self.feelings objectAtIndex:row];
    }
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
