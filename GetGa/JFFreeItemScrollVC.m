//
//  JFFreeItemScrollVC.m
//  GetGa
//
//  Created by Jared Fishman on 6/22/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFFreeItemScrollVC.h"
#import <MapKit/MapKit.h>

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

@implementation JFFreeItemScrollVC

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
    
    
}


- (IBAction)iWantThisFreeItemButtonPressed:(UIButton *)sender {
}

@end
