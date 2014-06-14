//
//  JFItemDisplayVC.m
//  GetGa
//
//  Created by Jared Fishman on 6/14/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFItemDisplayVC.h"
#import <MapKit/MapKit.h>

@interface JFItemDisplayVC ()
@property (weak, nonatomic) IBOutlet UIImageView *itemDisplayImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemDisplayTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemDisplayDetailLabel;
@property (strong, nonatomic) IBOutlet MKMapView *itemDisplayMap;
@property (weak, nonatomic) IBOutlet UIButton *iWantThisItemButton;

@end

@implementation JFItemDisplayVC

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
    
    NSLog(@"made it to the item display view");
    NSLog(@"%@", self.giveItem.locationData);
    
    self.itemDisplayImageView.image = self.giveItem.image;
    self.navigationItem.title = self.giveItem.giveItemName;
    
    double lat = [self.giveItem.locationData[@"latitude"] doubleValue];
    double lng = [self.giveItem.locationData[@"longitude"] doubleValue];
    
    self.itemDisplayDetailLabel.text = [NSString stringWithFormat:@"%f %f", lat, lng];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
