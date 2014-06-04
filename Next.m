//
//  Next.m
//  proximity
//
//  Created by Nikhil jain on 6/2/14.
//  Copyright (c) 2014 Nikhil jain. All rights reserved.
//

#import "Next.h"

@interface Next ()
{
    NSMutableArray *collImages;
    NSString *docsDir;
}
@end

@implementation Next
@synthesize webUploader;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIDevice *device=[UIDevice currentDevice];
    device.proximityMonitoringEnabled=NO;
    imageCollectionView.backgroundColor = [UIColor clearColor];
    //NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *docsDir = [dirPath objectAtIndex:0];
    collImages = [[NSMutableArray alloc] init];
     collImages = [[NSMutableArray alloc] initWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:docsDir error:nil]];
    //NSLog(@"%@",[collImages description]);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender {
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPath objectAtIndex:0];
    webUploader = [[GCDWebUploader alloc] initWithUploadDirectory:docsDir];
    webUploader.delegate = self;
    [webUploader start];
    NSLog(@"Visit %@ in your web browser", webUploader.serverURL);
    
    
}
-(void)webUploader:(GCDWebUploader *)uploader didDownloadFileAtPath:(NSString *)path
{
    NSLog(@"File Uploaded");
}
-(void)webUploader:(GCDWebUploader *)uploader didUploadFileAtPath:(NSString *)path
{
    NSLog(@"File Downloaded");
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [collImages count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *collCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    UIImageView *imageA = (UIImageView *)[collCell viewWithTag:10];
    [imageA setImage:[collImages objectAtIndex:indexPath.row]];
    return collCell;
}
- (IBAction)import:(id)sender {
    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.maximumImagesCount = 10;
    elcPicker.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
	elcPicker.imagePickerDelegate = self;
    [self presentViewController:elcPicker animated:YES completion:nil];
}
-(void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPath objectAtIndex:0];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    int a = 0;
   for(NSDictionary *myInfo in info)
   {
       //NSString *url = [myInfo objectForKey:UIImagePickerControllerReferenceURL];
       //url = [url lastPathComponent];
       image = [myInfo objectForKey:UIImagePickerControllerOriginalImage];
       //NSString *myPath = [docsDir stringByAppendingFormat:@"/%d.png",a];
       //NSData *data = UIImagePNGRepresentation(image);
       //[data writeToFile:myPath atomically:NO];
       [collImages addObject:image];
       a++;
   }
    [imageCollectionView performSelector:@selector(reloadData)];
}

-(void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}



@end
