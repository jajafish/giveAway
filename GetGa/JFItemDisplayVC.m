//
//  JFItemDisplayVC.m
//  GetGa
//
//  Created by Jared Fishman on 6/14/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFItemDisplayVC.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface JFItemDisplayVC () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *itemDisplayImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemDisplayTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemDisplayDetailLabel;
@property (strong, nonatomic) IBOutlet MKMapView *itemDisplayMap;
@property (weak, nonatomic) IBOutlet UIButton *iWantThisItemButton;

@end

@implementation JFItemDisplayVC {
    
    CLLocationCoordinate2D itemLocation;
    
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
    // Do any additional setup after loading the view.
    
    self.itemDisplayImageView.image = self.giveItem.image;
    self.navigationItem.title = self.giveItem.giveItemName;
    
    double lat = [self.giveItem.locationData[@"latitude"] doubleValue];
    double lng = [self.giveItem.locationData[@"longitude"] doubleValue];
    
    self.itemDisplayDetailLabel.text = [NSString stringWithFormat:@"%f %f", lat, lng];
    
    // MAP
    self.itemDisplayMap.delegate = self;
    CLLocationCoordinate2D cord = CLLocationCoordinate2DMake(lat, lng);
    itemLocation = cord;
    
    MKCoordinateRegion startRegion = MKCoordinateRegionMakeWithDistance(cord, 1500, 1500);
    [self.itemDisplayMap setRegion:startRegion animated:YES];
    
//    [self.itemDisplayMap addOverlay:(id)itemRadius level:MKOverlayLevelAboveRoads];
    
    [self.itemDisplayMap addOverlay:[MKCircle circleWithCenterCoordinate:cord radius:1000]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-(MKOverlayRenderer *):(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
//{
//    MKCircle *itemCircle = [MKCircle circleWithCenterCoordinate:itemLocation radius:1000];
//    MKCircleRenderer *itemRadius = [[MKCircleRenderer alloc]initWithCircle:itemCircle];
//    itemRadius.fillColor = [UIColor blueColor];
//    
//    return itemRadius;
//    
//}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    MKCircleView *circleView = [[MKCircleView alloc] initWithCircle:(MKCircle *)overlay];
    circleView.fillColor = [UIColor blueColor];
    return circleView;
}






@end
