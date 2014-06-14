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
    NSLog(@"%@", self.giveItem);
    
    self.itemDisplayImageView.image = self.giveItem.image;
    self.navigationItem.title = self.giveItem.giveItemName;
    
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
