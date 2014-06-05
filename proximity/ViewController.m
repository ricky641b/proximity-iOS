//
//  ViewController.m
//  proximity
//
//  Created by Nikhil jain on 6/2/14.
//  Copyright (c) 2014 Nikhil jain. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize imageToShare;

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIDevice *device=[UIDevice currentDevice];
    device.proximityMonitoringEnabled=YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(proximityChanged:) name:@"UIDeviceProximityStateDidChangeNotification" object:device];
    imagePicker=[[UIImagePickerController alloc]init];
   // imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.delegate=self;
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    // [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:imagePicker animated:YES completion:NULL];
   

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)proximityChanged:(NSNotification *)notification{
    UIDevice *device=[notification object];
    if(device.proximityState==1)
    {
       
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Login" message:nil delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"Login",nil];
        alert.alertViewStyle=UIAlertViewStyleSecureTextInput;
        [alert setTag:1];
        [alert show];
        // [UIApplication sharedApplication].idleTimerDisabled = YES;
    }
    else
    {
        
        

    }
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        UITextField *password=[alertView textFieldAtIndex:0];
        if([password.text isEqualToString:@"nik"])
        {
            
            [self performSegueWithIdentifier:@"next" sender:self];
        }
        else{
            
        }
    }
}


#pragma Camera


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    image=[info objectForKey:UIImagePickerControllerOriginalImage];
    imageToShare=UIImageJPEGRepresentation(image, 1.0);
    [imageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)camera:(id)sender {
    imagePicker.delegate=self;
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

- (IBAction)facebok:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        self.slComposeView=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [self.slComposeView addImage:[UIImage imageWithData:imageToShare]];
        //imageToShare=UIImageJPEGRepresentation(image, 1.0);
        [self presentViewController:self.slComposeView animated:YES completion:NULL];
    }
    else{
        NSLog(@"Error no account found");
    }
}

- (IBAction)twitter:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        self.slComposeView=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [self.slComposeView addImage:[UIImage imageWithData:imageToShare]];
        [self presentViewController:self.slComposeView animated:YES completion:NULL];
    }
}
@end
