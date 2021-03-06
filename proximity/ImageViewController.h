//
//  ImageViewController.h
//  proximity
//
//  Created by RICKY on 10/06/14.
//  Copyright (c) 2014 Nikhil jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController <UIDocumentInteractionControllerDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,strong) NSString *selectedImageFromAnother;
@property(strong,nonatomic) UIDocumentInteractionController *documentInteraction;
@property(nonatomic,strong) NSURL *urlFromAnotherView;
@end
