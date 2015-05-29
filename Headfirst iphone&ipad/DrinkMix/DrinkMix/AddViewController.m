//
//  AddViewController.m
//  DrinkMix
//
//  Created by tangbin on 5/5/15.
//  Copyright (c) 2015 tangbin. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
@property (nonatomic) bool keyboardVisible;
@end

@implementation AddViewController
@synthesize keyboardVisible=_keyboardVisible,drinkArray=_drinkArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    self.scrollView.contentSize=self.view.frame.size;
    if(self.drink!=nil)
    {
        self.nameTextField.text=[self.drink objectForKey:NAME_KEY];
        self.ingredientTextField.text=[self.drink objectForKey:INGREDIENTS_KEY];
        self.directionTextField.text=[self.drink objectForKey:DIRECTION_KEY];
    }
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardAppearance:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    _keyboardVisible=NO;
}
#pragma mark Keyboard handlers
-(void)keyboardAppearance:(NSNotification*)notif
{
    if(self.keyboardVisible)
    {
        NSLog(@"%@",@"Keyboard is already visible. Ignoring notification.");
        return;
    }
    NSLog(@"Resizing smaller for keyboard");
    NSDictionary *info=[notif userInfo];
    NSValue *aValue=[info objectForKey:UIKeyboardFrameEndUserInfoKey];//animation end
    CGRect keyboardRect=[aValue CGRectValue];
    keyboardRect=[self.view convertRect:keyboardRect fromView:nil];
    CGFloat keyboardTop=keyboardRect.origin.y;
    
    CGRect viewFrame=self.view.bounds;
    viewFrame.size.height=keyboardTop-self.view.bounds.origin.y;
    self.scrollView.frame=viewFrame;
    _keyboardVisible=YES;
    NSLog(@"Received UIKeyboardDidShowNotification.");
}

-(void)keyboardDidHide:(NSNotification*)notif
{
    if(!self.keyboardVisible)
    {
        NSLog(@"Keyboard already hidden. Ignoring notification.");
        return;
    }
    self.scrollView.frame=self.view.bounds;
    NSLog(@"Received UIKeyboardDidHideNotification.");
    _keyboardVisible=NO;

}



-(IBAction)save:(id)sender
{
    NSLog(@"Save pressed");
    if(self.drink!=nil)
    {
        [self.drinkArray removeObject:self.drink];
        self.drink=nil;
    }
    NSMutableDictionary *newDrink=[[NSMutableDictionary alloc]init];
    [newDrink setValue:self.nameTextField.text forKey:NAME_KEY];
    [newDrink setValue:self.ingredientTextField.text forKey:INGREDIENTS_KEY];
    [newDrink setValue:self.directionTextField.text forKey:DIRECTION_KEY];
    
    [_drinkArray addObject:newDrink];
    
    NSSortDescriptor *nameSorter=[[NSSortDescriptor alloc]initWithKey:NAME_KEY ascending:YES selector:nil];
    [_drinkArray sortUsingDescriptors:[NSArray arrayWithObjects:nameSorter, nil]];
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(IBAction)cancel:(id)sender
{
    NSLog(@"Cancel pressed!1");
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
