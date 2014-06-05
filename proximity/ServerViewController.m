//
//  ServerViewController.m
//  proximity
//
//  Created by RICKY on 05/06/14.
//  Copyright (c) 2014 Nikhil jain. All rights reserved.
//

#import "ServerViewController.h"

@interface ServerViewController ()
{
    NSString *docsDir;
}
@end
static int fileCounter;
@implementation ServerViewController
@synthesize webUploader,urlLabel,fileDownloadLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    fileCounter =0;
    [self webUploaderInitialiser];
    // Do any additional setup after loading the view.
}
-(void)webUploaderInitialiser
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [path objectAtIndex:0];
    webUploader = [[GCDWebUploader alloc] initWithUploadDirectory:docsDir];
    webUploader.delegate = self;
    if(![webUploader start])
    {
        [webUploader startWithPort:2121 bonjourName:@""];
    }
    urlLabel.text = [[NSString alloc] initWithFormat:@"%@" , webUploader.serverURL];
    
}
-(void)webUploader:(GCDWebUploader *)uploader didUploadFileAtPath:(NSString *)path
{
    fileCounter++;
    fileDownloadLabel.text = [[NSString alloc] initWithFormat:@"%d file downloaded",fileCounter];
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

@end
