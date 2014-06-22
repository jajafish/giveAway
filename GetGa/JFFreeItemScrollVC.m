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

@interface JFFreeItemScrollVC () <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *freeItemImageView;
@property (strong, nonatomic) IBOutlet UILabel *freeItemImageNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *freeItemCategoryLabel;
@property (strong, nonatomic) IBOutlet UITextView *freeItemLogisticsTextView;
@property (strong, nonatomic) IBOutlet MKMapView *freeItemLocationMapView;
@property (strong, nonatomic) IBOutlet UIImageView *freeItemGiverPhoto;
@property (strong, nonatomic) IBOutlet UILabel *freeItemGiverName;
@property (strong, nonatomic) IBOutlet UIButton *iWantThisFreeItemButton;
@property (strong, nonatomic) IBOutlet UIView *scrollContentView;

@end

@implementation JFFreeItemScrollVC {
    
    CLLocationCoordinate2D itemLocation;
    
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.scoller setScrollEnabled:YES];
    [self.scoller setContentSize:CGSizeMake(320, 936)];
    
    self.freeItemImageView.image = self.giveItem.image;
//    self.freeItemImageView.image = [UIImage imageNamed:@"dad.png"];
    
    self.freeItemImageNameLabel.text = self.giveItem.giveItemName;
    self.freeItemCategoryLabel.text = self.giveItem.itemCategory;
    self.freeItemLogisticsTextView.text = self.giveItem.itemDetailsLogistics;
    
    [self.scoller setContentOffset:CGPointMake(self.scoller.contentOffset.x, 0)
                             animated:NO];
    
    self.scoller.delegate = self;
    

    
    
    
//    ITEM ON MAP
    double lat = [self.giveItem.locationData[@"latitude"] doubleValue];
    double lng = [self.giveItem.locationData[@"longitude"] doubleValue];
    
    self.freeItemLocationMapView.delegate = self;
    CLLocationCoordinate2D cord = CLLocationCoordinate2DMake(lat, lng);
    itemLocation = cord;
    
    MKCoordinateRegion startRegion = MKCoordinateRegionMakeWithDistance(cord, 1500, 1500);
    [self.freeItemLocationMapView setRegion:startRegion animated:YES];
    
    [self.freeItemLocationMapView addOverlay:[MKCircle circleWithCenterCoordinate:cord radius:800]];
    
    
    
    
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


@end
