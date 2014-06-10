//
//  Next.m
//  proximity
//
//  Created by Nikhil jain on 6/2/14.
//  Copyright (c) 2014 Nikhil jain. All rights reserved.
//

#import "Next.h"
#import "ImageViewController.h"
@interface Next ()
{
    NSMutableArray *collImages;
    NSString *docsDir;
    UIImage *selectedImage;
    NSString *path;
}
@end

@implementation Next


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
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    [imageCollectionView performSelector:@selector(reloadData)];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage*)loadImage:(NSInteger)counter
{
    path = [docsDir stringByAppendingPathComponent:[collImages objectAtIndex:counter]];
    UIImage* myImage = [UIImage imageWithContentsOfFile:path];
    return myImage;
}

-(IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [collImages count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *collCell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!collCell)
        collCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    UIImageView *imageA = (UIImageView *)[collCell viewWithTag:10];
    [imageA setImage:[self loadImage:indexPath.row]];
    UILabel *label2 = (UILabel *)[collCell viewWithTag:11];
    label2.text = [collImages objectAtIndex:indexPath.row];
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
       myPath = [myPath stringByDeletingPathExtension];
       [collImages addObject:myPath];
       imgNo++;
   }
    [imageCollectionView performSelector:@selector(reloadData)];
     [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedImage = [self loadImage:indexPath.row];
    [self performSegueWithIdentifier:@"imageViewer" sender:nil];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue.destinationViewController setSelectedImageFromAnother:path];
}

-(void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


@end
