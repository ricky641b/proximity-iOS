//
//  ViewController.h
//  proximity
//
//  Created by Nikhil jain on 6/2/14.
//  Copyright (c) 2014 Nikhil jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImagePickerController *imagePicker;
    UIImage *image;
    IBOutlet UIImageView *imageView;

}
- (IBAction)facebok:(id)sender;
- (IBAction)twitter:(id)sender;


@end
