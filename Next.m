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
@property(nonatomic,strong) NSURL *urlMy;
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
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF ENDSWITH '.png' OR '.jpg'"];
     NSArray *extensions = [NSArray arrayWithObjects:@"png", @"jpg", @"jpeg", @"pdf",nil];
    NSArray *otherImages = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:docsDir error:nil];
    collImages = [[NSMutableArray alloc] initWithArray:[otherImages filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension IN %@", extensions]]];
   

    self.navigationController.navigationBar.hidden = YES;
    //imageCollectionView.editing = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
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
    NSString *pathWithoutExt = [collImages objectAtIndex:indexPath.row];
    label2.text = [pathWithoutExt stringByDeletingPathExtension];
    return collCell;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if(editingStyle==UITableViewCellEditingStyleDelete)
  {
      
      path = [docsDir stringByAppendingPathComponent:[collImages objectAtIndex:indexPath.row]];
      [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
      [collImages removeObjectAtIndex:indexPath.row];
      //[imageCollectionView performSelector:@selector(reloadData)];
      [imageCollectionView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
  }
}
- (IBAction)import:(id)sender {
    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.maximumImagesCount = 10;
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
	elcPicker.imagePickerDelegate = self;
    [self presentViewController:elcPicker animated:YES completion:nil];
}
-(void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    NSInteger imgNo = [collImages count] + 0;
   for(NSDictionary *myInfo in info)
   {
       
       image = [myInfo objectForKey:UIImagePickerControllerOriginalImage];
       NSString *myPath = [docsDir stringByAppendingFormat:@"/Photo %ld.png",(long)imgNo];
       NSData *data = UIImagePNGRepresentation(image);
       [data writeToFile:myPath atomically:NO];
        myPath = [myPath lastPathComponent];
    
       [collImages addObject:myPath];
       imgNo++;
   }
    [imageCollectionView performSelector:@selector(reloadData)];
     [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedImage = [self loadImage:indexPath.row];
    _urlMy = [[NSURL alloc] initFileURLWithPath:path];
    [self performSegueWithIdentifier:@"imageViewer" sender:nil];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue.destinationViewController setSelectedImageFromAnother:path];
    [segue.destinationViewController setUrlFromAnotherView:_urlMy];
}

-(void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


@end
