//
//  JFGiveItemLogisticsVC.m
//  GetGa
//
//  Created by Jared Fishman on 6/16/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFGiveItemLogisticsVC.h"
#import <QuartzCore/QuartzCore.h>
#import "JFMyGiveItemsCollectionVC.h"

@interface JFGiveItemLogisticsVC () <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *logisticsTextView;
@property (strong, nonatomic) IBOutlet UIButton *confirmLogisticsButton;

@end

@implementation JFGiveItemLogisticsVC

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
    [self.logisticsTextView becomeFirstResponder];
    
//    NSArray *viewControllers = self.navigationController.viewControllers;
//    UIViewController *rootViewController = [viewControllers objectAtIndex:viewControllers.count - 2];
//    NSLog(@"%@", viewControllers);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.confirmLogisticsButton.layer.cornerRadius = 5;
    self.confirmLogisticsButton.layer.borderWidth = 1;
    self.confirmLogisticsButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    
}


-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"the NAV CONTROLLER OF GIVE ITEM LOGISTICS VS IS %@", self.navigationController);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"stopped editing");
}

- (IBAction)confirmLogisticsButtonPressed:(id)sender {
    self.detailsAndLogistics = self.logisticsTextView.text;
    
    NSString *nameForGiveItem = self.giveItemNameFromDetails;
    NSData *giveItemImageData = UIImagePNGRepresentation(self.giveItemImageFromDetails);
    PFFile *giveItemImageFile = [PFFile fileWithName:nameForGiveItem data:giveItemImageData];
    PFObject *giveItemPhoto = [PFObject objectWithClassName:@"giveItemPhoto"];
    giveItemPhoto[@"imageOwner"] = [PFUser currentUser];
    giveItemPhoto[@"imageName"] = nameForGiveItem;
    giveItemPhoto[@"imageFile"] = giveItemImageFile;
    
    [giveItemPhoto saveInBackground];
    
    PFObject *giveItem = [PFObject objectWithClassName:@"giveItem"];
    giveItem[@"giveItemTitle"] = self.giveItemNameFromDetails;
    giveItem[@"giver"] = [PFUser currentUser];
    giveItem[@"giveItemLogistics"] = self.detailsAndLogistics;
    giveItem[@"postedLocation"] = [PFUser currentUser][@"mostRecentLocation"];
    [giveItem setObject:giveItemPhoto forKey:@"giveItemPhoto"];
    [giveItem saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self.rootVC reloadParseData];
    }];

    [self.navigationController popToRootViewControllerAnimated:YES];


}

@end



