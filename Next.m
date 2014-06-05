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
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPath objectAtIndex:0];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF ENDSWITH '.png'"];
    NSArray *otherImages = [[NSMutableArray alloc] initWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:docsDir error:nil]];
    [otherImages description];
    collImages = [[NSMutableArray alloc] initWithArray:[otherImages filteredArrayUsingPredicate:predicate]];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)server:(id)sender {
  /*  NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPath objectAtIndex:0];
    webUploader = [[GCDWebUploader alloc] initWithUploadDirectory:docsDir];
    webUploader.delegate = self;
    
    if(![webUploader start])
    {
        [webUploader startWithPort:2121 bonjourName:@" "];
    }
    NSLog(@"Visit %@ in your web browser", webUploader.serverURL);
   */
    
}
- (UIImage*)loadImage:(NSInteger)counter
{
    NSString* path = [docsDir stringByAppendingPathComponent:[collImages objectAtIndex:counter]];
    UIImage* myImage = [UIImage imageWithContentsOfFile:path];
    return myImage;
}

-(IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
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
    [imageA setImage:[self loadImage:indexPath.row]];
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
    NSInteger imgNo = [collImages count] + 0;
   for(NSDictionary *myInfo in info)
   {
       image = [myInfo objectForKey:UIImagePickerControllerOriginalImage];
       NSString *myPath = [docsDir stringByAppendingFormat:@"/%ld.png",(long)imgNo];
       NSData *data = UIImagePNGRepresentation(image);
       [data writeToFile:myPath atomically:NO];
        myPath = [myPath lastPathComponent];
       [collImages addObject:myPath];
       imgNo++;
   }
    [imageCollectionView performSelector:@selector(reloadData)];
     [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


@end
