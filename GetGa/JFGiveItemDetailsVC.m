//
//  JFGiveItemDetailsVC.m
//  GetGa
//
//  Created by Jared Fishman on 5/29/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFGiveItemDetailsVC.h"

@interface JFGiveItemDetailsVC () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *giveItemPhotoImageView;
@property (strong, nonatomic) IBOutlet UITextField *giveItemTitleTextField;
@property (strong, nonatomic) IBOutlet UITextView *giveItemDescriptionTextView;

@property(nonatomic, assign) id<UIToolbarDelegate> delegate;

@end

@implementation JFGiveItemDetailsVC

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
    
    self.giveItemTitleTextField.delegate = self;
    
    self.giveItemPhotoImageView.image = self.giveItemImage;
    
    [self.giveItemTitleTextField becomeFirstResponder];

    
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *nameForGiveItem = self.giveItemTitleTextField.text;
    NSData *giveItemImageData = UIImagePNGRepresentation(self.giveItemImage);
    PFFile *giveItemImageFile = [PFFile fileWithName:nameForGiveItem data:giveItemImageData];
    PFObject *giveItemPhoto = [PFObject objectWithClassName:@"giveItemPhoto"];
    giveItemPhoto[@"imageOwner"] = [PFUser currentUser];
    giveItemPhoto[@"imageName"] = nameForGiveItem;
    giveItemPhoto[@"imageFile"] = giveItemImageFile;

    [giveItemPhoto saveInBackground];
    
    PFObject *giveItem = [PFObject objectWithClassName:@"giveItem"];
    giveItem[@"giveItemTitle"] = self.giveItemTitleTextField.text;
    giveItem[@"giver"] = [PFUser currentUser];
    [giveItem setObject:giveItemPhoto forKey:@"giveItemPhoto"];
    [giveItem saveInBackground];
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];

    return YES;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end


