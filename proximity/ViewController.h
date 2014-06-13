//
//  ViewController.h
//  proximity
//
//  Created by Nikhil jain on 6/2/14.
//  Copyright (c) 2014 Nikhil jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
@interface ViewController : UIViewController<UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIDocumentInteractionControllerDelegate>
{
    UIImagePickerController *imagePicker;
    UIImage *image;
    IBOutlet UIImageView *imageView;

}
- (IBAction)camera:(id)sender;
- (IBAction)facebok:(id)sender;
- (IBAction)twitter:(id)sender;
@property(strong,nonatomic)SLComposeViewController *slComposeView;
@property(strong,nonatomic) NSData *imageToShare;
@end
