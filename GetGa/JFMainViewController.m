//
//  JFMainViewController.m
//  GetGa
//
//  Created by Jared Fishman on 5/31/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFMainViewController.h"

@interface JFMainViewController ()
@property (strong, nonatomic) IBOutlet UIButton *loginWithFBButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loginActivityIndicator;

@end

@implementation JFMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath
{
    NSString *identifier;
    switch (indexPath.row) {
        case 0:
            identifier = @"firstSegue";
            break;
        case 1:
            identifier = @"secondSegue";
            break;
    }
    
    return identifier;
    
}


-(void)configureLeftMenuButton:(UIButton *)button
{
    
    CGRect frame = button.frame;
    frame.origin = (CGPoint){0, 0};
    frame.size = (CGSize){40,40};
    
    button.frame = frame;
    
}

-(BOOL)deepnessForLeftMenu
{
    return YES;
}

-(BOOL)deepnessForRightMenu
{
    return YES;
}









#pragma mark - from initial login controller

- (IBAction)loginWithFBButtonPressed:(UIButton *)sender {
    
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location", @"user_friends"];
    
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        [_loginActivityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else{
            [self performSegueWithIdentifier:@"rightMenu" sender:self];
//            [self updateUserInformation];
        }
    }];
    
}


#pragma mark - Helper Methods




//-(void)updateUserInformation
//{
//    
//    
//    FBRequest *request = [FBRequest requestForMe];
//    
//    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//        
//        
//        if (!error){
//            
//            NSDictionary *userDictionary = (NSDictionary *)result;
//            
//            NSString *facebookID = userDictionary[@"id"];
//            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
//            
//            NSMutableDictionary *userProfile = [[NSMutableDictionary alloc]initWithCapacity:8];
//            if (userDictionary[@"name"]){
//                userProfile[kJFUserProfileNameKey] = userDictionary[@"name"];
//            }
//            if (userDictionary[@"first_name"]){
//                userProfile[kJFUserProfileFirstNameKey] = userDictionary[@"first_name"];
//            }
//            if (userDictionary[@"location"][@"name"]){
//                userProfile[kJFUserProfileLocationKey] = userDictionary[@"location"][@"name"];
//            }
//            if (userDictionary[@"gender"]){
//                userProfile[kJFUserProfileGenderKey] = userDictionary[@"gender"];
//            }
//            if (userDictionary[@"birthday"]){
//                userProfile[kJFUserProfileBirthdayKey] = userDictionary[@"birthday"];
//                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//                [formatter setDateStyle:NSDateFormatterShortStyle];
//                NSDate *date = [formatter dateFromString:userDictionary[@"birthday"]];
//                NSDate *now = [NSDate date];
//                NSTimeInterval seconds = [now timeIntervalSinceDate:date];
//                int age = seconds / 31536000;
//                userProfile[kJFUserProfileAgeKey] = @(age);
//            }
//            if (userDictionary[@"interested_in"]){
//                userProfile[kJFUserProfileInterestedInKey] = userDictionary[@"interested_in"];
//            }
//            if (userDictionary[@"relationship_status"]){
//                userProfile[kJFUserProfileRelationshipStatusKey] = userDictionary[@"relationship_status"];
//            }
//            if ([pictureURL absoluteString]){
//                userProfile[kJFUserProfilePictureURL] = [pictureURL absoluteString];
//            }
//            
//            [[PFUser currentUser] setObject:userProfile forKey:kJFUserProfileKey];
//            [[PFUser currentUser] saveInBackground];
//            //            NSLog(@"%@", userProfile);
//            
//        }
//        
//    }];
//    
//}









@end
