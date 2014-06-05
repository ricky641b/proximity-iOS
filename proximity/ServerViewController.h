//
//  ServerViewController.h
//  proximity
//
//  Created by RICKY on 06/06/14.
//  Copyright (c) 2014 Nikhil jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDWebUploader.h"

@interface ServerViewController : UIViewController <GCDWebUploaderDelegate>
{
    GCDWebUploader *webUploader;
}
@property(nonatomic,weak)IBOutlet UILabel *urlLabel;
@property(nonatomic,strong)    GCDWebUploader *webUploader;
@property(nonatomic,weak)IBOutlet UILabel *downloadFileNo;
@end
