//
//  DetailViewController.m
//  RetroPhoneHunter
//
//  Created by Paul Pilone on 5/5/13.
//  Copyright (c) 2013 Element 84, LLC. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *cityText;
@property (weak, nonatomic) IBOutlet UITextView *notesTextField;
@property (strong, nonatomic) IBOutlet UIImageView *imageVeiw;
@property (strong, nonatomic) UIPopoverController *PickerPopoverController;
@property (strong, nonatomic)CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIButton *takePictureButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (void)configureView;
@end

@implementation DetailViewController

@synthesize locationManager=_locationManager;
#pragma mark - Location
- (IBAction)locatePhoneboothButtonPressed:(id)sender {
    [self.locationManager startUpdatingLocation];
}

-(CLLocationManager *)locationManager
{
    if(_locationManager==nil)
    {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.delegate=self;
    }
    return _locationManager;
}
#pragma mark CLLocationManagerDelegate methods

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"Core location claims to have a position.");
    CLLocation *location = [locations lastObject];
    
    self.detailItem.lat=[NSNumber numberWithDouble:location.coordinate.latitude];
    self.detailItem.lon=[NSNumber numberWithDouble:location.coordinate.longitude];
    [self configureView];
    
    NSLog(@"shutting down core location.");
    [self.locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Core location cant get a fix");
    self.locationLabel.text=@"cant get a location.";
}
#pragma mark - Save the data
- (IBAction)nameFieldEditingChanged:(id)sender {
    self.detailItem.name=self.nameText.text;
}

- (IBAction)cityFieldEditingChanged:(id)sender {
    self.detailItem.city=self.cityText.text;
}

-(void)textViewDidChanged:(UITextView *)textview
{
    self.detailItem.notes=self.notesTextField.text;
}

#pragma mark - Pick a image
- (IBAction)takePictureButtonPressed:(id)sender {
    NSLog(@"Taking a picture!");
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        NSLog(@"This device has a camera.Asking the user what they want to use.");
        UIActionSheet *photoShourceSheet=[[UIActionSheet alloc]initWithTitle:@"Select PhotoBooth Picture" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Take New Phtot",@"Choose Existing Photo",nil];
        [photoShourceSheet showFromRect:((UIButton *)sender).frame inView:self.view animated:YES];
    }else{
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.delegate=self;
        picker.allowsEditing=YES;
        self.PickerPopoverController=[[UIPopoverController alloc]initWithContentViewController:picker];
        self.PickerPopoverController.delegate=self;
        [self.PickerPopoverController presentPopoverFromRect:self.takePictureButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];

    }
    
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.PickerPopoverController=nil;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *uniqueFilename=[[NSUUID UUID]UUIDString];
    NSString *imagePath=[documentsDirectory stringByAppendingPathComponent:uniqueFilename];
    
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
    
    self.detailItem.imagePath=imagePath;
    self.imageVeiw.image=image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - splitview
- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}
#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.nameText.text=self.detailItem.name;
        self.cityText.text=self.detailItem.city;
        self.notesTextField.text=self.detailItem.notes;
        NSLog(@"%@",self.detailItem.imagePath);
        self.imageVeiw.image=[UIImage imageWithContentsOfFile:self.detailItem.imagePath];
        
        if(self.detailItem.lat!=nil &&self.detailItem.lon!=nil)
        {
            self.locationLabel.text=[NSString stringWithFormat:@"%.3f, %.3f",[self.detailItem.lat doubleValue],[self.detailItem.lon doubleValue]];
            // Add the annotation to the map and zoom to it.
            [self.mapView addAnnotation:self.detailItem];
            MKCoordinateRegion region;
            region.center.latitude = [self.detailItem.lat doubleValue];
            region.center.longitude = [self.detailItem.lon doubleValue];
            region.span.latitudeDelta = 0.5;
            region.span.longitudeDelta = 0.5;
            
            [self.mapView setRegion:region animated:YES];
        }else{
            self.locationLabel.text=@"No location.";
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.locationManager requestWhenInUseAuthorization];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action sheet
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex ==actionSheet.cancelButtonIndex)
    {
        NSLog(@"The user canceled adding a image.");
        return;
    }
    
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    picker.delegate=self;
    picker.allowsEditing=YES;
    switch(buttonIndex)
    {
        case 0:
            NSLog(@"User wants to take a new picture");
            picker.sourceType=UIImagePickerControllerSourceTypeCamera;
            break;
        default:
            picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            break;
    }
    self.PickerPopoverController=[[UIPopoverController alloc]initWithContentViewController:picker];
    self.PickerPopoverController.delegate=self;
    [self.PickerPopoverController presentPopoverFromRect:self.takePictureButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}

@end
