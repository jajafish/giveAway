//
//  JFFreeItemScrollVC.m
//  GetGa
//
//  Created by Jared Fishman on 6/22/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFFreeItemScrollVC.h"
#import "JFFreeItemDescriptionTextView.h"
#import <MapKit/MapKit.h>
#import <ILTranslucentView.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import "ChatController.h"
#import "PFChatRoom.h"
#import "JFFreeItemDescriptionTableViewCell.h"
#import "JFFreeItemMapTableViewCell.h"
#import "JFFreeItemGiverTableViewCell.h"

@interface JFFreeItemScrollVC () <UITextViewDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *freeItemImageView;
@property (strong, nonatomic) IBOutlet UILabel *freeItemImageNameLabel;
@property (strong, nonatomic) IBOutlet UITableView *freeItemDataTable;
@property (strong, nonatomic) IBOutlet UIButton *iWantThisFreeItemButton;
@property (strong, nonatomic) UIImage *navBackgroundImage;
@property (strong, nonatomic) UIImage *navBackgroundShadowImage;
@property (strong, nonatomic) UIColor *navBackgroundColor;
@property (strong, nonatomic) IBOutlet ILTranslucentView *blurView;
@property (strong, nonatomic) PFChatRoom *selectedChat;
@property double headerImageYOffset;
@property (strong, nonatomic) UIImageView *headerImageView;
@property (strong, nonatomic) UIImage *itemImage;
@property CGFloat heightOfItemImage;


@end

@implementation JFFreeItemScrollVC {
    CLLocationCoordinate2D itemLocation;
}

-(void)viewDidLoad
{
    
    [super viewDidLoad];
    _itemImage = self.giveItem.image;

    
    
    self.freeItemDataTable.delegate = self;
    self.freeItemDataTable.dataSource = self;
    
    self.freeItemImageNameLabel.text = self.giveItem.giveItemName;
    
    NSLog(@"%@", NSStringFromCGRect(self.iWantThisFreeItemButton.frame));
    
    self.blurView.translucentAlpha = 0.8;
    self.blurView.translucentStyle = UIBarStyleBlack;
    self.blurView.translucentTintColor = [UIColor clearColor];
    
    self.iWantThisFreeItemButton.layer.cornerRadius = 13;
    self.iWantThisFreeItemButton.layer.borderWidth = 1;
    self.iWantThisFreeItemButton.layer.borderColor = [UIColor blackColor].CGColor;
    CGRect buttonFrame = self.iWantThisFreeItemButton.frame;
    buttonFrame.size.height = 54;
    self.iWantThisFreeItemButton.frame = buttonFrame;
    
    self.navigationController.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = self.giveItem.giveItemName;

    [self setUpGiverPhoto];
    [self setUpTableViewParallax];

}



-(void)setUpTableViewParallax
{
    _headerImageYOffset = 50;
    
    _heightOfItemImage = _itemImage.size.height;
    CGFloat desiredHeightOfItemImageFrame = (_heightOfItemImage - 200);
    
    UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, desiredHeightOfItemImageFrame)];
    CGFloat properPlaceForYOriginOfBlackLine = (desiredHeightOfItemImageFrame - 0.01);
    UIView *blackBorderView = [[UIView alloc]initWithFrame:CGRectMake(0.0, properPlaceForYOriginOfBlackLine, self.view.frame.size.width, 1.0)];
    tableHeaderView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
    blackBorderView.backgroundColor = [UIColor blackColor];
    [tableHeaderView addSubview:blackBorderView];
    _freeItemDataTable.tableHeaderView = tableHeaderView;
    _freeItemDataTable.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.0];
    
        _headerImageView = [[UIImageView alloc]init];
    _headerImageView.image = _itemImage;
    CGRect tableHeaderFrame = tableHeaderView.frame;
    tableHeaderFrame.origin.y = _headerImageYOffset;
    _headerImageView.frame = tableHeaderFrame;
    [self.view insertSubview:_headerImageView belowSubview:_freeItemDataTable];
    
    NSLog(@"the size of the headerImageView is %@ and the size of the image itself is %@", NSStringFromCGRect(_headerImageView.frame), NSStringFromCGSize(_itemImage.size));
}


-(void)setUpGiverPhoto
{
    //    [self queryForItemGiverProfilePhoto];
    //    self.freeItemGiverPhoto.layer.cornerRadius = self.freeItemGiverPhoto.frame.size.width / 2;
    //    self.freeItemGiverPhoto.clipsToBounds = YES;
    //    self.freeItemGiverPhoto.layer.borderWidth = 1.5f;
    //    self.freeItemGiverPhoto.layer.borderColor = [UIColor blackColor].CGColor;
}




-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    return nil;
    [_freeItemDataTable reloadData];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0){
        return 1.0f;
    }
    return 32.0f;

}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollOffset = scrollView.contentOffset.y;
    CGRect headerImageFrame = _headerImageView.frame;
    CGRect tableViewFrame = _freeItemDataTable.frame;
    CGFloat initialTableViewYOrigin = tableViewFrame.origin.y;
    
    
    CGFloat negativeHeightOfImage = 0 - _heightOfItemImage;
    
//    while (scrollOffset < negativeHeightOfImage) {
        if (scrollOffset < 0 | scrollOffset > 0){
            headerImageFrame.origin.y = _headerImageYOffset - ((scrollOffset / 3));
        } else {
            headerImageFrame.origin.y = _headerImageYOffset - scrollOffset;
            //        tableViewFrame.origin.y = scrollOffset;
        }
//    }
  
    _freeItemDataTable.frame = tableViewFrame;
    _headerImageView.frame = headerImageFrame;
    
}


#pragma mark - Table View

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell;
    
    switch (indexPath.row) {
        case 0: {
            
            static NSString *cellID = @"Cell1";
            JFFreeItemDescriptionTableViewCell *cell = [_freeItemDataTable dequeueReusableCellWithIdentifier:cellID];
            
            if (cell == nil){
                cell = [[JFFreeItemDescriptionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            
            cell.freeItemLogisticsTextView.text = self.giveItem.itemDetailsLogistics;
            CGRect sizeOfText = cell.freeItemLogisticsTextView.frame;
            cell.frame = sizeOfText;

            return cell;
            
            break;
        }
        
            
        case 1: {
            
            static NSString *cellID = @"Cell2";
            JFFreeItemMapTableViewCell *cell = [_freeItemDataTable dequeueReusableCellWithIdentifier:cellID];
            
            if (cell == nil){
                cell = [[JFFreeItemMapTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            
            //    ITEM ON MAP
            cell.freeItemLocationMapView.delegate = cell;
            double lat = [self.giveItem.locationData[@"latitude"] doubleValue];
            double lng = [self.giveItem.locationData[@"longitude"] doubleValue];
            cell.freeItemLocationMapView.delegate = cell;
            CLLocationCoordinate2D cord = CLLocationCoordinate2DMake(lat, lng);
            itemLocation = cord;
            MKCoordinateRegion startRegion = MKCoordinateRegionMakeWithDistance(cord, 1500, 1500);
            [cell.freeItemLocationMapView setRegion:startRegion animated:YES];
            [cell.freeItemLocationMapView addOverlay:[MKCircle circleWithCenterCoordinate:cord radius:200]];

            return cell;
    
        }
            
        case 2: {
        
            static NSString *cellID = @"Cell3";
            JFFreeItemGiverTableViewCell *cell = [_freeItemDataTable dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil){
                cell = [[JFFreeItemGiverTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            cell.freeItemGiverName.text = self.giveItem.itemGiverName;
            cell.freeItemGiverPhoto.image = [UIImage imageNamed:@"dad.png"];
            
            return cell;
            
        }
            
        default:
            break;
    }
    
    return cell;
    
}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    MKCircleView *circleView = [[MKCircleView alloc] initWithCircle:(MKCircle *)overlay];
    circleView.fillColor = [UIColor blueColor];
    circleView.alpha = 0.3;
    return circleView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
    
    [self chatRoomQuery];
    
    self.navBackgroundImage = [self.navigationController.navigationBar backgroundImageForBarMetrics:(UIBarMetricsDefault)];
    self.navBackgroundShadowImage = [self.navigationController.navigationBar shadowImage];
    self.navBackgroundColor = [self.navigationController.view backgroundColor];

}


- (IBAction)iWantThisFreeItemButtonPressed:(UIButton *)sender {
    
    [self goToChatRoom];
    
}



-(void)queryForItemGiverProfilePhoto {
    PFQuery *profilePhotoQuery = [PFQuery queryWithClassName:@"profilePhoto"];
    [profilePhotoQuery whereKey:@"photoUser" equalTo:self.giveItem.itemGiver];
    [profilePhotoQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        PFObject *theOnlyPhoto = objects[0];
        
        PFFile *photoFile = theOnlyPhoto[@"photoPictureFile"];
        [photoFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
     //       self.freeItemGiverPhoto.image = [UIImage imageWithData:data];
        }];
        
    }];
    
}



-(void)goToChatRoom
{
    
    [self performSegueWithIdentifier:@"freeItemScrollToChatModal" sender:nil];

}


-(void)chatRoomQuery
{
    
    PFQuery *queryForChatRoom = [PFQuery queryWithClassName:@"ChatRoom"];
    [queryForChatRoom whereKey:@"user1" equalTo:[PFUser currentUser]];
    [queryForChatRoom whereKey:@"user2" equalTo:self.giveItem.itemGiver];
    
    PFQuery *queryForChatRoomInverse = [PFQuery queryWithClassName:@"ChatRoom"];
    [queryForChatRoomInverse whereKey:@"user1" equalTo:self.giveItem.itemGiver];
    [queryForChatRoomInverse whereKey:@"user2" equalTo:[PFUser currentUser]];
    
    PFQuery *combinedChatRoomQuery = [PFQuery orQueryWithSubqueries:@[queryForChatRoom, queryForChatRoomInverse]];
    
    [combinedChatRoomQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (![objects count] == 0) {
            [self.iWantThisFreeItemButton setTitle:@"continue chat with this user" forState:UIControlStateNormal];
            self.selectedChat = objects[0];
        }
        else if ([objects count] == 0){
            [self.iWantThisFreeItemButton setTitle:@"create new chat" forState:UIControlStateNormal];
            [PFCloud callFunctionInBackground:@"addUsersToChatRoom" withParameters:@{@"user1" : [PFUser currentUser].objectId, @"user2" : self.giveItem.itemGiver.objectId} block:^(id object, NSError *error) {
                NSLog(@"the object is %@", object);
                self.selectedChat = object;
            }];
        };
    }];
    
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ChatController *chatVC = segue.destinationViewController;
    chatVC.chatRoom = self.selectedChat;
    chatVC.chatRoomTitle =  self.giveItem.itemGiver.giveGetterName;
}


@end
