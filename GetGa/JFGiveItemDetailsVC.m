//
//  JFGiveItemDetailsVC.m
//  GetGa
//
//  Created by Jared Fishman on 5/29/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFGiveItemDetailsVC.h"
#import "JFMyGiveItemsCollectionVC.h"
#import "JFGiveItemLogisticsVC.h"
#import <CoreLocation/CoreLocation.h>

@interface JFGiveItemDetailsVC () <UITextFieldDelegate, UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *giveItemPhotoImageView;
@property (strong, nonatomic) IBOutlet UITextField *giveItemTitleTextField;

@property (strong, nonatomic) UIPanGestureRecognizer *moveRecognizer;

@property(nonatomic, assign) id<UIToolbarDelegate> delegate;

@end

@implementation JFGiveItemDetailsVC


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

#pragma mark - S

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.giveItemTitleTextField.delegate = self;
    
    self.giveItemPhotoImageView.image = self.giveItemImage;
    
    [self.giveItemTitleTextField becomeFirstResponder];
    UIColor *color = [UIColor blackColor];
    self.giveItemTitleTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"What are you giving away?" attributes:@{NSForegroundColorAttributeName: color}];
    
    self.giveItemTitleTextField.userInteractionEnabled = YES;
    


    
}

-(void)viewDidAppear:(BOOL)animated
{
        NSLog(@"navigation controller of GIVE ITEM DETAILS VC IS %@", self.navigationController);
}

#pragma mark - Submit Item to Parse

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
//    NSString *nameForGiveItem = self.giveItemTitleTextField.text;
//    NSData *giveItemImageData = UIImagePNGRepresentation(self.giveItemImage);
//    PFFile *giveItemImageFile = [PFFile fileWithName:nameForGiveItem data:giveItemImageData];
//    PFObject *giveItemPhoto = [PFObject objectWithClassName:@"giveItemPhoto"];
//    giveItemPhoto[@"imageOwner"] = [PFUser currentUser];
//    giveItemPhoto[@"imageName"] = nameForGiveItem;
//    giveItemPhoto[@"imageFile"] = giveItemImageFile;
//    
//    [giveItemPhoto saveInBackground];
//    
//    PFObject *giveItem = [PFObject objectWithClassName:@"giveItem"];
//    giveItem[@"giveItemTitle"] = self.giveItemTitleTextField.text;
//    giveItem[@"giver"] = [PFUser currentUser];
//    giveItem[@"postedLocation"] = [PFUser currentUser][@"mostRecentLocation"];
//    [giveItem setObject:giveItemPhoto forKey:@"giveItemPhoto"];
//    [giveItem saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        [self.rootVC reloadParseData];
//    }];
    
//    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [self performSegueWithIdentifier:@"giveItemDetailsToLogistics" sender:self];
    
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"giveItemDetailsToLogistics"]){
        if ([segue.destinationViewController isKindOfClass:[JFGiveItemLogisticsVC class]]){
            JFGiveItemLogisticsVC *targetVC = segue.destinationViewController;
            targetVC.giveItemNameFromDetails = self.giveItemTitleTextField.text;
            targetVC.giveItemImageFromDetails = self.giveItemImage;
        }
    }
}



@end


