//
//  ViewController.m
//  proximity
//
//  Created by Nikhil jain on 6/2/14.
//  Copyright (c) 2014 Nikhil jain. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIAlertView *alert,*myAlert,*errorAlert;
  //  NSUserDefaults *initialPasswordUD,*passwordSavedUD;
    NSString *passwordEntered;
}
@property(nonatomic,strong)NSUserDefaults *initialPasswordUD;
@property(nonatomic,strong)NSUserDefaults *passwordSavedUD;
@end

@implementation ViewController
@synthesize imageToShare;

-(void)PasswordAuthority
{
    myAlert = [[UIAlertView alloc] initWithTitle:@"Set Your Password" message:@"Enter Password" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
    myAlert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [myAlert show];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

       // imagePicker=[[UIImagePickerController alloc]init];
   // imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.delegate=self;
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    // [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
   // [self presentViewController:imagePicker animated:YES completion:NULL];
   

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)proximityChanged:(NSNotification *)notification{
    UIDevice *device=[notification object];
    NSLog(@"Detected %d",device.proximityState);
    if(device.proximityState==1)
    {
        if(!alert.isVisible)
        {
        alert=[[UIAlertView alloc]initWithTitle:@"Login" message:nil delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"Login",nil];
        alert.alertViewStyle=UIAlertViewStyleSecureTextInput;
        [alert setTag:1];
        
        [alert show];
        }
        // [UIApplication sharedApplication].idleTimerDisabled = YES;
    }
}
-(NSUserDefaults *)passwordSavedUD
{
    if(!_passwordSavedUD)
        _passwordSavedUD = [[NSUserDefaults alloc] init];
    return _passwordSavedUD;
}
-(NSUserDefaults *)initialPasswordUD
{
    if(!_initialPasswordUD)
        _initialPasswordUD = [[NSUserDefaults alloc] init];
    return _initialPasswordUD;
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
   
    if(buttonIndex==1)
    {
        NSString *check=[self.passwordSavedUD objectForKey:@"UserPassword"];
        UITextField *password=[alertView textFieldAtIndex:0];
         NSLog(@"%@",check);
        if([password.text isEqualToString:check])
        {
            
            [self performSegueWithIdentifier:@"next" sender:self];
        }
        else{
            alert=[[UIAlertView alloc]initWithTitle:@"ERROR" message:@"Incorrect Password" delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles: nil];
            [alert show];
        }
    }
    if(alertView==myAlert)
    {
        UITextField *password = [alertView textFieldAtIndex:0];
        NSString *rawString = [password text];
        NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        //NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
        NSRange range = [rawString rangeOfCharacterFromSet:whitespace];
        if (!(range.location != NSNotFound) && [password.text length]!=0) {
            passwordEntered = password.text;
            [self.passwordSavedUD setObject:passwordEntered forKey:@"UserPassword"];
            [self.initialPasswordUD setObject:@"YES" forKey:@"firstTimeBoot"];
            UIAlertView *acceptedAlert = [[UIAlertView alloc] initWithTitle:@"Password Accepted" message:@"Congratulations" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
            [acceptedAlert show];
            [self proximityEnabler];
          
        }
        else
        {
            errorAlert = [[UIAlertView alloc] initWithTitle:@"Password not accepted" message:@"Password contained spaces" delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:nil];
            [errorAlert show];
            
            
        }
    }
    if(alertView==errorAlert)
    {
        [self PasswordAuthority];
    }
}
-(void)proximityEnabler
{
    UIDevice *device=[UIDevice currentDevice];
    [device setProximityMonitoringEnabled:YES];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(proximityChanged:) name:UIDeviceProximityStateDidChangeNotification object:device];
}

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
-(void)viewWillAppear:(BOOL)animated
{
  
   
    if(![self.initialPasswordUD boolForKey:@"firstTimeBoot"])
    {
        [self PasswordAuthority];
    }
    else
    {
        [self proximityEnabler];
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
