//
//  ViewController.m
//  TableView
//
//  Created by tangbin on 5/31/15.
//  Copyright (c) 2015 tangbin. All rights reserved.
//

#import "ViewController.h"
#import "BIDNameAndColorCell.h"

static NSString *CellTableIdentifier=@"CelltableIdentifier";

@interface ViewController ()
@property (copy,nonatomic) NSArray *computers;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.computers=@[@{@"Name":@"MacBook Air",@"Color":@"Silver"},
                     @{@"Name":@"iMak",@"Color":@"Silver"},
                     @{@"Name": @"Mac Pro",@"Color":@"Silver"},
                     @{@"Name":@"Mac Mini",@"Color":@"Black"}];
    UITableView *tableview=(id)[self.view viewWithTag:1];
    //[tableview registerClass:[BIDNameAndColorCell class] forCellReuseIdentifier:CellTableIdentifier];
    tableview.rowHeight=65;
    UINib *nib=[UINib nibWithNibName:@"BIDNameAndColorCellUseNib" bundle:nil];
    [tableview registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
    UIEdgeInsets contentinset=tableview.contentInset;
    contentinset.top=100;
    [tableview setContentInset:contentinset];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.computers count];
}

/*-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row;
}*/

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        return nil;
    }else{
        return indexPath;
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *computers=[self.computers[indexPath.row] valueForKey:@"Name"];
    NSString *message=[[NSString alloc]initWithFormat:@"You seleted %@",computers];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Row selected" message:message delegate:nil cancelButtonTitle:@"Yes I Did" otherButtonTitles:nil];
    [alert show];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BIDNameAndColorCell *cell=[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier forIndexPath:indexPath];
    cell.name=[self.computers[indexPath.row] valueForKey:@"Name"];
    cell.color=[self.computers[indexPath.row] valueForKey:@"Color"];
    if(indexPath.row<7)
    {
        cell.detailTextLabel.text=@"Mr. Disney";
    }else
    {
        cell.detailTextLabel.text=@"Mr. Tolkien";
    }
    cell.textLabel.font=[UIFont boldSystemFontOfSize:50];
    return cell;
}

/*-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}*/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
