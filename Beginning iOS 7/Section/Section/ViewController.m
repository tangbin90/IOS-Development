//
//  ViewController.m
//  Section
//
//  Created by tangbin on 6/2/15.
//  Copyright (c) 2015 tangbin. All rights reserved.
//

#import "ViewController.h"
static NSString *sectionsTableIdentifier=@"SectionsTableIdentifier";
@interface ViewController ()
@property (copy, nonatomic) NSDictionary *names;
@property (copy, nonatomic) NSArray *keys;
@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic,retain) UITableViewController *tableViewController;
@end

@implementation ViewController{// instance private
    NSMutableArray *filteredNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITableView *tableView = (id)[self.view viewWithTag:1];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:sectionsTableIdentifier];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"sortednames" ofType:@"plist"];
    self.names=[NSDictionary dictionaryWithContentsOfFile:path];
    self.keys=[[self.names allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    if(tableView.style==UITableViewStylePlain)
    {
        UIEdgeInsets contentInset=tableView.contentInset;
        contentInset.top=20;
        [tableView setContentInset:contentInset];
        
        UIView *barBackground=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        barBackground.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
        [self.view addSubview:barBackground];
    }
    
    filteredNames = [NSMutableArray array];
    self.tableViewController=[[UITableViewController alloc]initWithStyle:UITableViewStylePlain];
    self.tableViewController.tableView=[[UITableView alloc]initWithFrame:tableView.frame];
    [self.tableViewController.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:sectionsTableIdentifier];

    self.searchController=[[UISearchController alloc]initWithSearchResultsController:self.tableViewController];
    [self.searchController.searchBar sizeToFit];
    tableView.tableHeaderView=self.searchController.searchBar;
    self.tableViewController.tableView.delegate=self;
    self.tableViewController.tableView.dataSource=self;
    self.searchController.delegate=self;
    self.searchController.searchResultsUpdater=self;
    self.searchController.searchBar.delegate = self;
    
    tableView.sectionIndexBackgroundColor=[UIColor blackColor];
    tableView.sectionIndexTrackingBackgroundColor=[UIColor darkGrayColor];
    tableView.sectionIndexColor=[UIColor whiteColor];
    

}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}


#pragma mark - UISearchControllerDelegate

// Called after the search controller's search bar has agreed to begin editing or when
// 'active' is set to YES.
// If you choose not to present the controller yourself or do not implement this method,
// a default presentation is performed on your behalf.
//
// Implement this method if the default presentation is not adequate for your purposes.
//
- (void)presentSearchController:(UISearchController *)searchController {
    
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    // do something before the search controller is presented
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    // do something after the search controller is presented
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    // do something before the search controller is dismissed
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    // do something after the search controller is dismissed
}


#pragma mark-
#pragma mark Table View Data Source Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView.tag==1)
        return [self.keys count];
    else
        return 1;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if(tableView.tag==1)
        return self.keys;
    else
        return nil;
    }
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==1){
        NSString *key=self.keys[section];
        NSArray *nameSection=self.names[key];
        return [nameSection count];

    }else
    {
        return [filteredNames count];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView.tag==1)
        return self.keys[section];
    else
        return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionsTableIdentifier forIndexPath:indexPath];
    if(tableView.tag==1)
    {
        NSString *key=self.keys[indexPath.section];
        NSArray *nameSection=self.names[key];
        cell.textLabel.text=nameSection[indexPath.row];
    }else
    {
        cell.textLabel.text=filteredNames[indexPath.row];
        }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // update the filtered array based on the search text
    [filteredNames removeAllObjects];
    NSString *searchText = searchController.searchBar.text;
    if(searchText.length>0)
    {
        NSPredicate *predate=[NSPredicate predicateWithBlock:^BOOL(NSString *name, NSDictionary *bindings) {
            NSRange range=[name rangeOfString:searchText
                                      options:NSCaseInsensitiveSearch];
            return range.location!=NSNotFound;
        }];
        for(NSString *key in self.keys){
            NSArray *matches=[self.names[key] filteredArrayUsingPredicate:predate];
            [filteredNames addObjectsFromArray:matches];
        }
    }
    [self.tableViewController.tableView reloadData];
}



@end
