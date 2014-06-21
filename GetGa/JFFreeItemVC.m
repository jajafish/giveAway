//
//  JFFreeItemVC.m
//  GetGa
//
//  Created by Jared Fishman on 6/21/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFFreeItemVC.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface JFFreeItemVC () <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *freeItemImageView;

@property (strong, nonatomic) IBOutlet UILabel *freeItemDistanceLabel;
@property (strong, nonatomic) IBOutlet MKMapView *freeItemMapView;
@property (strong, nonatomic) IBOutlet UILabel *freeItemDescriptionLabel;
@property (strong, nonatomic) IBOutlet UIButton *iWantThisItemButton;
@property (strong, nonatomic) IBOutlet UIImageView *freeItemGiverPhoto;
@property (strong, nonatomic) IBOutlet UILabel *freeItemGiverNameLabel;

@end

@implementation JFFreeItemVC {
    
    CLLocationCoordinate2D itemLocation;
    
}

@synthesize giveItem;


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.freeItemImageView.image = self.giveItem.image;
    self.navigationItem.title = self.giveItem.giveItemName;
    self.freeItemDescriptionLabel.text = self.giveItem.itemDetailsLogistics;
    
    self.freeItemGiverNameLabel.text = self.giveItem.itemGiverName;

    self.navigationController.navigationBar.topItem.title = @"";
    
    
    
    
    
    
    //    Item Map
    double lat = [self.giveItem.locationData[@"latitude"] doubleValue];
    double lng = [self.giveItem.locationData[@"longitude"] doubleValue];
    self.freeItemMapView.delegate = self;
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(lat, lng);
    itemLocation = coord;
    
    MKCoordinateRegion startRegion = MKCoordinateRegionMakeWithDistance(coord, 1500, 1500);
    [self.freeItemMapView setRegion:startRegion animated:YES];
    [self.freeItemMapView addOverlay:[MKCircle circleWithCenterCoordinate:coord radius:800]];
    
    
    
    
}


- (IBAction)iWantThisItemButtonPressed:(UIButton *)sender {
}


-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    MKCircleView *circleView = [[MKCircleView alloc]initWithCircle:(MKCircle *)overlay];
    circleView.fillColor = [UIColor blueColor];
    circleView.alpha = 0.3;
    return circleView;
}




@end
