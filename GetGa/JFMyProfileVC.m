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
    

    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    
//    
//    PFFile *pictureFile = [PFUser currentUser][@"profile"]
    
    
    
    
//    for (PFObject *object in objects) {
//        PFGiveItem *newGiveItem = [[PFGiveItem alloc]init];
//        newGiveItem.giveItemName = object[@"giveItemTitle"];
//        PFObject *photoObj = object[@"giveItemPhoto"];
//        PFFile *ourImageFile = photoObj[@"imageFile"];
//        
//        [ourImageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//            if (!error){
//                newGiveItem.image = [UIImage imageWithData:data];
//            }
//            [self.tableView reloadData];
//        }];
//        
    
    
    
//    self.profileImageView.image = [UIImage imageNamed:@"dad.png"];
    self.navigationItem.title = [PFUser currentUser][@"profile"][@"first_name"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
