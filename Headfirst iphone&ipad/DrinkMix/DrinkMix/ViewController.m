//
//  ViewController.m
//  DrinkMix
//
//  Created by tangbin on 4/27/15.
//  Copyright (c) 2015 tangbin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (assign) id <UISplitViewControllerDelegate> delegate;
@end

@implementation ViewController
@synthesize drinks=_drinks;


- (void)viewDidLoad {
    [super viewDidLoad];
    //_drinks=[[NSMutableArray alloc]initWithObjects:@"Firecaracker",@"Lemon Drop",@"Mojito", nil];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DrinkDirections"
                                                     ofType:@"plist"];
    _drinks=[[NSMutableArray alloc]initWithContentsOfFile:path];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(receivedApplicationEnterBackgroundNotification:)
                                                name:UIApplicationDidEnterBackgroundNotification
                                              object:nil];
    self.navigationItem.leftBarButtonItem=self.editButtonItem;
    
    // Do any additional setup after loading the view, typically from a nib.
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.drinks count];
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSMutableDictionary *drink= [self.drinks objectAtIndex:sourceIndexPath.row];
    [self.drinks removeObject:drink];
    [self.drinks insertObject:drink atIndex:destinationIndexPath.row];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text=[[self.drinks objectAtIndex:indexPath.row] objectForKey:@"name"];
    return cell;
}
-(void)receivedApplicationEnterBackgroundNotification:(NSNotification*)notify
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DrinkDirections" ofType:@"plist"];
    [self.drinks writeToFile:path atomically:YES];
}
#pragma mark Actions
- (IBAction)addButtonPressed:(id)sender {
    NSLog(@"Add button pressed!!");
    AddViewController *addViewController=[[AddViewController alloc]initWithNibName:@"AddViewController" bundle:nil];
    addViewController.drinkArray=self.drinks;
    UINavigationController *addNavController = [[UINavigationController alloc] initWithRootViewController:addViewController];
    
    [self presentViewController:addNavController animated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id detail=self.splitViewController.viewControllers[1];
    if(self.editing)
    {
        AddViewController *addViewController=[[AddViewController alloc]initWithNibName:@"AddViewController" bundle:nil];
        addViewController.drinkArray=self.drinks;
        addViewController.drink=[self.drinks objectAtIndex:indexPath.row];
        UINavigationController *addNavController = [[UINavigationController alloc] initWithRootViewController:addViewController];

        [self presentViewController:addNavController animated:YES completion:nil];
    }else
    {
        if([detail isKindOfClass:[UINavigationController class]])
        {
            UINavigationController *detailview=detail;
            if([detailview.childViewControllers[0] isKindOfClass:[DetailViewController class]])
            {
                DetailViewController *ctrl=detailview.childViewControllers[0];
                ctrl.drink=[self.drinks objectAtIndex:indexPath.row];

            }
        }
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(!self.editing)
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if([segue.destinationViewController isKindOfClass:[DetailViewController class]])
        {
            DetailViewController *detailViewController=segue.destinationViewController ;
            detailViewController.drink=[self.drinks objectAtIndex:indexPath.row];
        }
    }else
    {
        return;
    }
    
    // prepare segue.destinationController to display based on information
    // about my Model corresponding to indexPath.row in indexPath.section
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
