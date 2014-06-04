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

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIDevice *device=[UIDevice currentDevice];
    device.proximityMonitoringEnabled=YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(proximityChanged:) name:@"UIDeviceProximityStateDidChangeNotification" object:device];
    imagePicker=[[UIImagePickerController alloc]init];
   

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
        _state.text=@"Value is 1";
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Login" message:nil delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"Login",nil];
        alert.alertViewStyle=UIAlertViewStyleSecureTextInput;
        [alert setTag:1];
        [alert show];
        // [UIApplication sharedApplication].idleTimerDisabled = YES;
    }
    else
    {
        _state.text=@"Value is !1";
        

    }
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        UITextField *password=[alertView textFieldAtIndex:0];
        if([password.text isEqualToString:@"nik"])
        {
            _Text.text=@"Welcome";
            [self performSegueWithIdentifier:@"next" sender:self];
        }
        else{
            _Text.text=@"Wrong";
        }
    }
}


#pragma Camera

- (IBAction)activate:(id)sender {
    imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.delegate=self;
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
   // [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:imagePicker animated:YES completion:NULL];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    image=[info objectForKey:UIImagePickerControllerOriginalImage];
    [imageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
