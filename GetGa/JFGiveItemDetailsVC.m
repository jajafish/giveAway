//
//  JFGiveItemDetailsVC.m
//  GetGa
//
//  Created by Jared Fishman on 5/29/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFGiveItemDetailsVC.h"
#import "JFGiveItemsTableVC.h"

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






//    [self.photos addObject:[self photoFromImage:image]];


//    NSData *imageData = UIImagePNGRepresentation(image);
//    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
//
//    PFObject *itemPhoto = [PFObject objectWithClassName:@"ItemPhoto"];
//    itemPhoto[@"imageName"] = @"old bed";
//    itemPhoto[@"imageFile"] = imageFile;
//    [itemPhoto saveInBackground];



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    NSString *currentUserName = [PFUser currentUser][@"profile"][@"name"];
    NSString *nameForGiveItem = [NSString stringWithFormat:@"%@%@%@", currentUserName, self.giveItemTitleTextField.text, @"Photo"];
    
    NSData *giveItemImageData = UIImagePNGRepresentation(self.giveItemImage);
    PFFile *giveItemImageFile = [PFFile fileWithName:nameForGiveItem data:giveItemImageData];
    PFObject *giveItemPhoto = [PFObject objectWithClassName:@"giveItemPhoto"];
    giveItemPhoto[@"imageName"] = nameForGiveItem;
    giveItemPhoto[@"imageFIle"] = giveItemImageFile;
    [giveItemPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        NSLog(@"saved %@", giveItemPhoto);
    }];
    
    
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


