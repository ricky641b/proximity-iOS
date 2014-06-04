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
@property (strong, nonatomic) IBOutlet UILabel *state;
@property (strong, nonatomic) IBOutlet UILabel *Text;
- (IBAction)activate:(id)sender;

@end
