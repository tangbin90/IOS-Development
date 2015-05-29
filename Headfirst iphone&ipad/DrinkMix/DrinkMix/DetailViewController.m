//
//  DetailViewController.m
//  DrinkMix
//
//  Created by tangbin on 4/28/15.
//  Copyright (c) 2015 tangbin. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *IngredientText;
@property (weak, nonatomic) IBOutlet UITextView *DirectionsText;
@end

@implementation DetailViewController
@synthesize IngredientText=_IngredientText,DirectionsText=_DirectionsText,drink=_drink;

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
}
#pragma mark splitviewpopover
- (BOOL)splitViewController:(UISplitViewController *)sender shouldHideViewController:(UIViewController *)master
              inOrientation:(UIInterfaceOrientation)orientation
{
    return UIInterfaceOrientationIsPortrait(orientation);
}

- (void)splitViewController:(UISplitViewController *)sender
     willHideViewController:(UIViewController *)master
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)popover
{
    barButtonItem.title = master.title;
    self.navigationItem.leftBarButtonItem=barButtonItem;
    // this next line would only work in the Detail
    // and only if it was in a UINavigationController self.navigationItem.leftBarButton = barButtonItem;
}

-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    self.navigationItem.leftBarButtonItem=nil;
}
-(void)setDrink:(NSDictionary *)drink
{
    _drink=drink;
    self.IngredientText.text=[self.drink objectForKey:@"ingredients"];
    self.DirectionsText.text=[self.drink objectForKey:@"directions"];
    NSLog(@"%@",[self.drink objectForKey:@"directions"]);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)awakeFromNib
{
    self.splitViewController.delegate=self;
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
