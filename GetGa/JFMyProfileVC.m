//
//  JFMyProfileVC.m
//  GetGa
//
//  Created by Jared Fishman on 6/1/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFMyProfileVC.h"

@interface JFMyProfileVC ()
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) UIImage *profilePicture;

@end

@implementation JFMyProfileVC

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
    
    
    self.navigationItem.title = [PFUser currentUser][@"profile"][@"first_name"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [self getUserProfilePicture];
}


-(void)getUserProfilePicture
{
    PFQuery *query = [PFQuery queryWithClassName:@"profilePhoto"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error){
            
            PFFile *photoFile = [objects lastObject][@"photoPictureFile"];
            [photoFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if (!error){
                    self.profilePicture = [UIImage imageWithData:data];
                    self.profileImageView.image = self.profilePicture;
                    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
                    self.profileImageView.clipsToBounds = YES;
                    NSLog(@"the picture is %@", self.profilePicture);
                    [self.profileImageView setNeedsDisplay];
                }
            }];
            
        }
        
    }];
}



@end
