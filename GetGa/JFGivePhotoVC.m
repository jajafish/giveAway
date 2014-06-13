//
//  JFGivePhotoVC.m
//  GetGa
//
//  Created by Jared Fishman on 5/28/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFGivePhotoVC.h"
#import "JFGiveItemDetailsVC.h"

@interface JFGivePhotoVC () 

@end

@implementation JFGivePhotoVC

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
    // Do any additional setup after loading the view.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
 
    if ([segue.identifier isEqualToString:@"givePhotoToGiveDetailsSegue"]){
        if ([segue.destinationViewController isKindOfClass:[JFGiveItemDetailsVC class]]){
            JFGiveItemDetailsVC *targetVC = segue.destinationViewController;
            targetVC.giveItemImage = self.giveItemImage;
            targetVC.rootVC = self.mainItemsTableVC;
        }
    }
    
}


-(void)viewDidAppear:(BOOL)animated
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    [self.view.window.rootViewController presentViewController:picker animated:YES completion:NULL];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Helpers

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    UIImage *image = info[UIImagePickerControllerEditedImage];
    if(!image) image = info[UIImagePickerControllerOriginalImage];
    
    picker.delegate = self;

    [self setPhotoForNextVC:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self performSegueWithIdentifier:@"givePhotoToGiveDetailsSegue" sender:self];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSLog(@"canceled");
}




-(void)setPhotoForNextVC:(UIImage *)image
{
    self.giveItemImage = image;
}





@end
