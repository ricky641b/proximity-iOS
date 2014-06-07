//
//  Next.h
//  proximity
//
//  Created by Nikhil jain on 6/2/14.
//  Copyright (c) 2014 Nikhil jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "GCDWebUploader.h"

@interface Next : UIViewController<ELCImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIImagePickerController *imagePicker;
    UIImage *image;
    IBOutlet UITableView *imageCollectionView;
}

- (IBAction)back:(id)sender;
- (IBAction)import:(id)sender;

@end
