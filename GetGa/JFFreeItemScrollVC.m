//
//  JFFreeItemScrollVC.m
//  GetGa
//
//  Created by Jared Fishman on 6/22/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFFreeItemScrollVC.h"
#import <MapKit/MapKit.h>
#import <ILTranslucentView.h>
#import <CoreLocation/CoreLocation.h>

@interface JFFreeItemScrollVC () <MKMapViewDelegate, UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *freeItemImageView;
@property (strong, nonatomic) IBOutlet UILabel *freeItemImageNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *freeItemCategoryLabel;
@property (strong, nonatomic) IBOutlet UITextView *freeItemLogisticsTextView;
@property (strong, nonatomic) IBOutlet MKMapView *freeItemLocationMapView;
@property (strong, nonatomic) IBOutlet UIImageView *freeItemGiverPhoto;
@property (strong, nonatomic) IBOutlet UILabel *freeItemGiverName;
@property (strong, nonatomic) IBOutlet UIButton *iWantThisFreeItemButton;
@property (strong, nonatomic) IBOutlet UIView *scrollContentView;

@property (strong, nonatomic) UIImage *navBackgroundImage;
@property (strong, nonatomic) UIImage *navBackgroundShadowImage;
@property (strong, nonatomic) UIColor *navBackgroundColor;

@end

@implementation JFFreeItemScrollVC {
    
    CLLocationCoordinate2D itemLocation;
    
    
}

-(void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self.scoller setScrollEnabled:YES];
    [self.scoller setContentSize:CGSizeMake(320, 936)];
    
    self.freeItemLogisticsTextView.delegate = self;

    
    self.freeItemImageView.image = self.giveItem.image;
//    self.freeItemImageView.image = [UIImage imageNamed:@"dad.png"];
    
    self.freeItemImageNameLabel.text = self.giveItem.giveItemName;
    self.freeItemCategoryLabel.text = self.giveItem.itemCategory;
    self.freeItemLogisticsTextView.text = self.giveItem.itemDetailsLogistics;
//    self.freeItemGiverName.text = self.giveItem.itemGiverName;
    self.freeItemGiverName.text = self.giveItem.itemGiver.giveGetterName;
    
    [self.scoller setContentOffset:CGPointMake(self.scoller.contentOffset.x, 0)
                             animated:NO];
    
    self.scoller.delegate = self;
    
    NSLog(@"%@", NSStringFromCGRect(self.iWantThisFreeItemButton.frame));
    

    
    
//    ITEM ON MAP
    double lat = [self.giveItem.locationData[@"latitude"] doubleValue];
    double lng = [self.giveItem.locationData[@"longitude"] doubleValue];
    
    self.freeItemLocationMapView.delegate = self;
    CLLocationCoordinate2D cord = CLLocationCoordinate2DMake(lat, lng);
    itemLocation = cord;
    
    MKCoordinateRegion startRegion = MKCoordinateRegionMakeWithDistance(cord, 1500, 1500);
    [self.freeItemLocationMapView setRegion:startRegion animated:YES];
    
    [self.freeItemLocationMapView addOverlay:[MKCircle circleWithCenterCoordinate:cord radius:800]];
    
    NSLog(@"the item giver is %@", self.giveItem.itemGiver);
    NSLog(@"and the current user is %@", [PFUser currentUser]);
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:self.navBackgroundImage
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = self.navBackgroundShadowImage;
    self.navigationController.view.backgroundColor = self.navBackgroundColor;
    

    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    self.navBackgroundImage = [self.navigationController.navigationBar backgroundImageForBarMetrics:(UIBarMetricsDefault)];
    self.navBackgroundShadowImage = [self.navigationController.navigationBar shadowImage];
    self.navBackgroundColor = [self.navigationController.view backgroundColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    
    [self textViewDidChange:self.freeItemLogisticsTextView];
}


- (IBAction)iWantThisFreeItemButtonPressed:(UIButton *)sender {
    
    [self createChatRoom];
    
}


-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    MKCircleView *circleView = [[MKCircleView alloc] initWithCircle:(MKCircle *)overlay];
    circleView.fillColor = [UIColor blueColor];
    circleView.alpha = 0.3;
    return circleView;
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat fixedWidth = _freeItemLogisticsTextView.frame.size.width;
    CGSize newSize = [_freeItemLogisticsTextView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = _freeItemLogisticsTextView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    _freeItemLogisticsTextView.frame = newFrame;
}


-(void)createChatRoom
{
    PFQuery *queryForChatRoom = [PFQuery queryWithClassName:@"ChatRoom"];
    [queryForChatRoom whereKey:@"user1" equalTo:[PFUser currentUser]];
    [queryForChatRoom whereKey:@"user2" equalTo:self.giveItem.itemGiver];
    
    PFQuery *queryForChatRoomInverse = [PFQuery queryWithClassName:@"ChatRoom"];
    [queryForChatRoomInverse whereKey:@"user1" equalTo:self.giveItem.itemGiver];
    [queryForChatRoomInverse whereKey:@"user2" equalTo:[PFUser currentUser]];
    
    PFQuery *combinedChatRoomQuery = [PFQuery orQueryWithSubqueries:@[queryForChatRoom, queryForChatRoomInverse]];
    
    [combinedChatRoomQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] == 0){
            PFObject *chatRoom = [PFObject objectWithClassName:@"ChatRoom"];
            [chatRoom setObject:[PFUser currentUser] forKey:@"user1"];
            [chatRoom setObject:self.giveItem.itemGiver forKey:@"user2"];
            [chatRoom saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [self performSegueWithIdentifier:@"itemToItemChatSegue" sender:nil];
            }];
        }
    }];

}



@end
