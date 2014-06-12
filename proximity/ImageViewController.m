//
//  ImageViewController.m
//  proximity
//
//  Created by RICKY on 10/06/14.
//  Copyright (c) 2014 Nikhil jain. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()
{
    IBOutlet UIBarButtonItem *barButtonItem;
}
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property(strong,nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic) IBOutlet UINavigationBar *navBar;


@end

@implementation ImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
-(void)toggleBars:(id)sender
{
    self.navBar.hidden = !self.navBar.isHidden;
//self.toolBar.hidden = !self.toolBar.isHidden;
    //[self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
  //  [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
}
-(UIDocumentInteractionController *)documentInteraction
{
    if(!_documentInteraction)
    {
        _documentInteraction = [[UIDocumentInteractionController alloc] init];
        _documentInteraction.delegate = self;
    }
    return _documentInteraction;
    
}
-(IBAction)backButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
#pragma Camera
- (IBAction)buttonPressed:(id)sender {
    
   
    NSURL *documentURL = _urlFromAnotherView;
    self.documentInteraction.URL = documentURL;
    [self.documentInteraction presentOpenInMenuFromBarButtonItem:barButtonItem animated:YES];
}
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    
    return  self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImage* myImage = [UIImage imageWithContentsOfFile:self.selectedImageFromAnother];
    [self.imageView setImage:myImage];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleBars:)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
    self.scrollView.minimumZoomScale=1.0;
    self.scrollView.maximumZoomScale=6.0;
    self.scrollView.contentSize=CGSizeMake(1280, 960);
    self.scrollView.delegate=self;
    // Do any additional setup after loading the view.
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
-(void)viewWillAppear:(BOOL)animated
{
    //self.toolBar.hidden = NO;
    self.navBar.hidden = YES;
    
    //[self.imageView setImage:self.selectedImageFromAnother];
}
-(void)selectImage:(UIImage *)selectedImage
{
    [self.imageView setImage:selectedImage];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
