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

@interface Next : UIViewController<ELCImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,GCDWebUploaderDelegate>
{
    UIImagePickerController *imagePicker;
    UIImage *image;
    IBOutlet UICollectionView *imageCollectionView;
    GCDWebUploader *webUploader;
}
@property(nonatomic,strong) GCDWebUploader *webUploader;
- (IBAction)back:(id)sender;
- (IBAction)import:(id)sender;

@end
