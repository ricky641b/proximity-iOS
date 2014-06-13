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
    UIScrollView *scrollView2;
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
-(IBAction)toggleBars:(UITapGestureRecognizer *)gestureRecognizer
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
    //[self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.imageView sizeToFit];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.scrollView.minimumZoomScale=1.0;
    self.scrollView.maximumZoomScale=6.0;
    self.scrollView.contentSize=CGSizeMake(1280, 960);
    self.scrollView.delegate=self;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleBars:)];
    [tapGesture setDelegate:self];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.cancelsTouchesInView = NO;
    [_scrollView addGestureRecognizer:tapGesture];
  
}
-(void) setupScrollView {
    //add the scrollview to the view
   scrollView2 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,
                                                                     self.view.frame.size.width,
                                                                     self.view.frame.size.height)];
    scrollView2.pagingEnabled = YES;
    [scrollView2 setAlwaysBounceVertical:NO];
    //setup internal views
    NSInteger numberOfViews = 3;
    for (int i = 0; i < numberOfViews; i++) {
        CGFloat xOrigin = i * self.view.frame.size.width;
        UIImageView *image = [[UIImageView alloc] initWithFrame:
                              CGRectMake(xOrigin, 0,
                                         self.view.frame.size.width,
                                         self.view.frame.size.height)];
        image.image = [UIImage imageNamed:[NSString stringWithFormat:
                                           @"Photo %d", i+1]];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView2 addSubview:image];
    }
    //set the scroll view content size
    scrollView2.contentSize = CGSizeMake(self.view.frame.size.width *
                                             numberOfViews,
                                             self.view.frame.size.height);
    //add the scrollview to this view
    [self.view addSubview:scrollView2];
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
