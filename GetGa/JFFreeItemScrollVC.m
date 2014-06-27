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
#import <QuartzCore/QuartzCore.h>
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

@property (strong, nonatomic) IBOutlet ILTranslucentView *blurView;

@end

@implementation JFFreeItemScrollVC {
    
    CLLocationCoordinate2D itemLocation;
    
    
}

-(void)viewDidLoad
{
    
    [super viewDidLoad];
    
    NSLog(@"item giver is %@", self.giveItem.itemGiver.objectId);
    
    
    
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
    
    
    self.blurView.translucentAlpha = 0.8;
    self.blurView.translucentStyle = UIBarStyleBlack;
    self.blurView.translucentTintColor = [UIColor clearColor];
    
    
    self.iWantThisFreeItemButton.layer.cornerRadius = 5;
    self.iWantThisFreeItemButton.layer.borderWidth = 1;
    self.iWantThisFreeItemButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    
    self.freeItemGiverPhoto.image = self.giveItem.itemGiver.giveGetterProfileImage;
    
    
//    ITEM ON MAP
    double lat = [self.giveItem.locationData[@"latitude"] doubleValue];
    double lng = [self.giveItem.locationData[@"longitude"] doubleValue];
    
    self.freeItemLocationMapView.delegate = self;
    CLLocationCoordinate2D cord = CLLocationCoordinate2DMake(lat, lng);
    itemLocation = cord;
    
    MKCoordinateRegion startRegion = MKCoordinateRegionMakeWithDistance(cord, 1500, 1500);
    [self.freeItemLocationMapView setRegion:startRegion animated:YES];
    
    [self.freeItemLocationMapView addOverlay:[MKCircle circleWithCenterCoordinate:cord radius:800]];
    
    
    [self queryForItemGiverProfilePhoto];
    
    
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


-(void)queryForItemGiverProfilePhoto {
    PFQuery *profilePhotoQuery = [PFQuery queryWithClassName:@"profilePhoto"];
    [profilePhotoQuery whereKey:@"photoUser" equalTo:self.giveItem.itemGiver];
    [profilePhotoQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        PFObject *theOnlyPhoto = objects[0];
        
        PFFile *photoFile = theOnlyPhoto[@"photoPictureFile"];
        [photoFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            self.freeItemGiverPhoto.image = [UIImage imageWithData:data];
        }];
        
    }];
    
}


@end
