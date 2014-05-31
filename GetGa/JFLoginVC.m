//
//  JFLoginVC.m
//  GetGa
//
//  Created by Jared Fishman on 5/29/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFLoginVC.h"

@interface JFLoginVC ()
@property (strong, nonatomic) IBOutlet UIButton *loginWithFBButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loginActivityIndicator;

@end

@implementation JFLoginVC

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

//-(void)viewDidAppear:(BOOL)animated
//{
//    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]){
//        [self updateUserInformation];
//        [self performSegueWithIdentifier:@"loginToGiveItemsTable" sender:self];
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IB Actions

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
            [self performSegueWithIdentifier:@"loginToGiveItemsTable" sender:self];
            [self updateUserInformation];
        }
    }];
    
}


#pragma mark - Helper Methods




-(void)updateUserInformation
{
    
    
    FBRequest *request = [FBRequest requestForMe];
    
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        
        
        if (!error){
            
            NSDictionary *userDictionary = (NSDictionary *)result;
            
            NSString *facebookID = userDictionary[@"id"];
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            
            NSMutableDictionary *userProfile = [[NSMutableDictionary alloc]initWithCapacity:8];
            if (userDictionary[@"name"]){
                userProfile[kJFUserProfileNameKey] = userDictionary[@"name"];
            }
            if (userDictionary[@"first_name"]){
                userProfile[kJFUserProfileFirstNameKey] = userDictionary[@"first_name"];
            }
            if (userDictionary[@"location"][@"name"]){
                userProfile[kJFUserProfileLocationKey] = userDictionary[@"location"][@"name"];
            }
            if (userDictionary[@"gender"]){
                userProfile[kJFUserProfileGenderKey] = userDictionary[@"gender"];
            }
            if (userDictionary[@"birthday"]){
                userProfile[kJFUserProfileBirthdayKey] = userDictionary[@"birthday"];
                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                [formatter setDateStyle:NSDateFormatterShortStyle];
                NSDate *date = [formatter dateFromString:userDictionary[@"birthday"]];
                NSDate *now = [NSDate date];
                NSTimeInterval seconds = [now timeIntervalSinceDate:date];
                int age = seconds / 31536000;
                userProfile[kJFUserProfileAgeKey] = @(age);
            }
            if (userDictionary[@"interested_in"]){
                userProfile[kJFUserProfileInterestedInKey] = userDictionary[@"interested_in"];
            }
            if (userDictionary[@"relationship_status"]){
                userProfile[kJFUserProfileRelationshipStatusKey] = userDictionary[@"relationship_status"];
            }
            if ([pictureURL absoluteString]){
                userProfile[kJFUserProfilePictureURL] = [pictureURL absoluteString];
            }
            
            [[PFUser currentUser] setObject:userProfile forKey:kJFUserProfileKey];
            [[PFUser currentUser] saveInBackground];
//            NSLog(@"%@", userProfile);
            
        }
        
    }];
    
    
    
    
    
    
    
}



@end
