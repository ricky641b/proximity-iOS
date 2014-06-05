//
//  ServerViewController.m
//  proximity
//
//  Created by RICKY on 06/06/14.
//  Copyright (c) 2014 Nikhil jain. All rights reserved.
//

#import "ServerViewController.h"

@interface ServerViewController ()
{
    NSString *docsDir;
}
@end
static int fileCounter = 0;
@implementation ServerViewController
@synthesize webUploader,urlLabel,downloadFileNo;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)webServerInit
{
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPath objectAtIndex:0];
    webUploader = [[GCDWebUploader alloc] initWithUploadDirectory:docsDir];
    webUploader.delegate = self;
    
    if(![webUploader start])
    {
        [webUploader startWithPort:2121 bonjourName:@" "];
    }
    urlLabel.text = [[NSString alloc] initWithFormat:@"%@", webUploader.serverURL];
    
}
-(void)webUploader:(GCDWebUploader *)uploader didUploadFileAtPath:(NSString *)path
{
    downloadFileNo.text = [[NSString alloc] initWithFormat:@"%d files downloaded",fileCounter];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(IBAction)stopServer:(id)sender
{
    [webUploader stop];
    [self dismissViewControllerAnimated:YES completion:NULL];
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
