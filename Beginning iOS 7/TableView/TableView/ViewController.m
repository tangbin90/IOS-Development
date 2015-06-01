//
//  ViewController.m
//  TableView
//
//  Created by tangbin on 5/31/15.
//  Copyright (c) 2015 tangbin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (copy,nonatomic) NSArray *dwarves;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dwarves=@[@"Sleepy",@"Sneezy",@"Bashful",@"Happy",@"Doc",@"Grumpy"];
    UITableView *tableview=(id)[self.view viewWithTag:1];
    UIEdgeInsets contentinset=tableview.contentInset;
    contentinset.top=20;
    [tableview setContentInset:contentinset];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dwarves count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"simpleTableIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
    }
    cell.textLabel.text=self.dwarves[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
