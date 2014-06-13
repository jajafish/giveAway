//
//  JFLoginVC.m
//  GetGa
//
//  Created by Jared Fishman on 5/31/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFLoginVC.h"



@interface JFLoginVC ()

@property (strong, nonatomic) IBOutlet UIButton *FBLoginButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) NSMutableData *imageData;

@end

@implementation JFLoginVC

{
    
    CLLocationManager *manager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    
}

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updatedLocation:)
                                                 name:@"newLocationNotif"
                                               object:nil];
    
}

-(void) updatedLocation:(NSNotification*)notif {
    CLLocation* userLocation = (CLLocation*)[[notif userInfo] valueForKey:@"newLocationResult"];
//    NSLog(@"from login, user location is %@", userLocation);
    self.currentLocation = userLocation;
//    NSLog(@"the instance variable of the user's location is %@", self.currentLocation);
}



-(void)viewDidAppear:(BOOL)animated
{
    
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]){
        [self updateUserInformation];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IB Actions

- (IBAction)loginWithFBButtonPressed:(UIButton *)sender {
    
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location", @"user_friends"];
    
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        [_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else{
            [self updateUserInformation];
            [self performSegueWithIdentifier:@"loginToMainSegue" sender:self];
        }
    }];
    
}




#pragma mark - Helpers

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
            
            NSMutableDictionary *mostRecentCoordinates = [[NSMutableDictionary alloc]initWithCapacity:10];
            
            if (self.currentLocation){
                mostRecentCoordinates[@"latitude"] = [NSString stringWithFormat:@"%.8f", self.currentLocation.coordinate.latitude];
                mostRecentCoordinates[@"longitude"] = [NSString stringWithFormat:@"%.8f", self.currentLocation.coordinate.longitude];
            }
            
            [[PFUser currentUser] setObject:userProfile forKey:kJFUserProfileKey];
            [[PFUser currentUser]setObject:mostRecentCoordinates forKey:@"mostRecentLocation"];
            [[PFUser currentUser] saveInBackground];
            [self requestImage];
            
            
        }
        
    }];
    
}


-(void)uploadPFFileToParse:(UIImage *)image
{
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    
    if (!imageData){
        NSLog(@"imageData not found");
        return;
    }
    
    PFFile *photoFile = [PFFile fileWithData:imageData];
    
    [photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded){
            PFObject *photo = [PFObject objectWithClassName:@"profilePhoto"];
            [photo setObject:[PFUser currentUser] forKey:@"photoUser"];
            [photo setObject:photoFile forKey:@"photoPictureFile"];
            [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                NSLog(@"photo saved");
            }];
            
        }
    }];
    
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.imageData appendData:data];
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *profileImage = [UIImage imageWithData:self.imageData];
    [self uploadPFFileToParse:profileImage];
}



-(void)requestImage
{
    PFQuery *query = [PFQuery queryWithClassName:@"profilePhoto"];
    
    [query whereKey:@"photoUser" equalTo:[PFUser currentUser]];
    
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (number == 0)
        {
            PFUser *user = [PFUser currentUser];
            self.imageData = [[NSMutableData alloc] init];
            
            NSURL *profilePictureURL = [NSURL URLWithString:user[kJFUserProfileKey][kJFUserProfilePictureURL]];
            
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:profilePictureURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4.0f];
            
            NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
            
            if (!urlConnection){
                NSLog(@"Failed to download picture");
            }
            
        };
    }];
    
}







@end
