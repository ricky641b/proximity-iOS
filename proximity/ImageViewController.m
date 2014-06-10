//
//  ImageViewController.m
//  proximity
//
//  Created by RICKY on 10/06/14.
//  Copyright (c) 2014 Nikhil jain. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//@property (strong,nonatomic) IBOutlet UINavigationBar *navBar;
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
-(IBAction)toggleBars:(id)sender
{
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImage* myImage = [UIImage imageWithContentsOfFile:self.selectedImageFromAnother];
    [self.imageView setImage:myImage];
    self.tabBarController.tabBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleBars:)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
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
