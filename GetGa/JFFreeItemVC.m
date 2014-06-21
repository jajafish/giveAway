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

@property (strong, nonatomic) IBOutlet MKMapView *freeItemMapView;
@property (strong, nonatomic) IBOutlet UILabel *freeItemDescriptionLabel;
@property (strong, nonatomic) IBOutlet UIButton *iWantThisItemButton;


@end

@implementation JFFreeItemVC

@synthesize giveItem;


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.freeItemImageView.image = self.giveItem.image;
    self.navigationItem.title = self.giveItem.giveItemName;
    self.freeItemDescriptionLabel.text = self.giveItem.itemDetailsLogistics;

    
    self.navigationController.navigationBar.topItem.title = @"";
}


- (IBAction)iWantThisItemButtonPressed:(UIButton *)sender {
}


@end
