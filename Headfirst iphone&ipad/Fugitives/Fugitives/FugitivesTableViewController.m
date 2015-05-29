//
//  FugitivesTableViewController.m
//  Fugitives
//
//  Created by tangbin on 5/10/15.
//  Copyright (c) 2015 tangbin. All rights reserved.
//

#import "FugitivesTableViewController.h"

@interface FugitivesTableViewController ()
@property (nonatomic, retain) UIManagedDocument *document;
@property (nonatomic, retain) NSMutableArray *fugitives;
@end

@implementation FugitivesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *documentsDirectory = [fileManager URLsForDirectory:NSDocumentDirectory
                                  inDomains:NSUserDomainMask];
    NSString *documentName=@"Fugitives.sqlite";
    NSURL *url = [documentsDirectory[0] URLByAppendingPathComponent:documentName];
    self.document = [[UIManagedDocument alloc] initWithFileURL:url];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:[url path]])
    {
        [self.document openWithCompletionHandler:^(BOOL success) {
            if (success) [self documentIsReady];
            if (!success) NSLog(@"couldn't open document at %@", url);
        }];
    }else
    {
        NSURL *defaultDBPath = [[NSBundle mainBundle]URLForResource:@"Fugitives" withExtension:@"sqlite"];
        NSError *error;
        UIManagedDocument* tempdoc = [[UIManagedDocument alloc] initWithFileURL:defaultDBPath];
        [tempdoc saveToURL:url
         forSaveOperation:UIDocumentSaveForCreating
         completionHandler:^(BOOL success){
             if(!success)
             {
                 NSAssert1(0,@"Failed to create writable database file with message '%@'.",[error localizedDescription]);
             }
         }];
        
        [self.document openWithCompletionHandler:^(BOOL success) {
            if (success) [self documentIsReady];
            if (!success) NSLog(@"couldn't open document at %@", url);
        }];
    }
    
}

- (void)documentIsReady
{
    if (self.document.documentState == UIDocumentStateNormal) { // start using document
        NSManagedObjectContext *managedObjectContext = self.document.managedObjectContext;
        NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Fugitive"];
        NSSortDescriptor *sortDescriptor =
        [NSSortDescriptor sortDescriptorWithKey:@"name"
                                      ascending:YES
                                       selector:@selector(localizedStandardCompare:)];
        NSError *error;
        request.sortDescriptors=@[sortDescriptor];
        self.fugitives=[[managedObjectContext executeFetchRequest:request error:&error]mutableCopy];
        for(Fugitive *fugitive in self.fugitives)
        {
            NSLog(@"fetched Fugitives %@",fugitive);
        }
        
    } }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
