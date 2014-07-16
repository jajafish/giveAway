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

@interface JFFreeItemScrollVC () <MKMapViewDelegate, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
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


@end

@implementation JFFreeItemScrollVC {
    
    CLLocationCoordinate2D itemLocation;
    
}


-(void)viewDidLoad
{
    
    [super viewDidLoad];

    
    self.freeItemDataTable.delegate = self;
    self.freeItemDataTable.dataSource = self;
    
    self.freeItemImageView.image = [UIImage imageNamed:@"dad.png"];

    self.freeItemImageNameLabel.text = self.giveItem.giveItemName;
    
    NSLog(@"%@", NSStringFromCGRect(self.iWantThisFreeItemButton.frame));
    
    self.blurView.translucentAlpha = 0.8;
    self.blurView.translucentStyle = UIBarStyleBlack;
    self.blurView.translucentTintColor = [UIColor clearColor];
    
    self.iWantThisFreeItemButton.layer.cornerRadius = 5;
    self.iWantThisFreeItemButton.layer.borderWidth = 1;
    self.iWantThisFreeItemButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    
    self.navigationController.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = self.giveItem.giveItemName;

    
    
    // PARALLAX Scroll
    
//    
//    UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 180.0)];
//    UIView *blackBorderView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 179.0, self.view.frame.size.width, 1.0)];
//    blackBorderView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
//    tableHeaderView.backgroundColor = [UIColor clearColor];
//    [tableHeaderView addSubview:blackBorderView];
//    _freeItemDataTable.tableHeaderView = tableHeaderView;
    
    _headerImageYOffset = -150.0;
    _headerImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dad.png"]];
    CGRect headerImageFrame = _headerImageView.frame;
    headerImageFrame.origin.y = _headerImageYOffset;
    _headerImageView.frame = headerImageFrame;
//    _freeItemDataTable.tableHeaderView = _headerImageView;
    [self.view insertSubview:_headerImageView belowSubview:_freeItemDataTable];
    _freeItemDataTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    

    
////    ITEM ON MAP
//    double lat = [self.giveItem.locationData[@"latitude"] doubleValue];
//    double lng = [self.giveItem.locationData[@"longitude"] doubleValue];
//    self.freeItemLocationMapView.delegate = self;
//    CLLocationCoordinate2D cord = CLLocationCoordinate2DMake(lat, lng);
//    itemLocation = cord;
//    MKCoordinateRegion startRegion = MKCoordinateRegionMakeWithDistance(cord, 1500, 1500);
//    [self.freeItemLocationMapView setRegion:startRegion animated:YES];
//    [self.freeItemLocationMapView addOverlay:[MKCircle circleWithCenterCoordinate:cord radius:200]];
//
////    QUERY FOR GIVER PHOTO
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
    
    if (scrollOffset < 0){
        headerImageFrame.origin.y = _headerImageYOffset - ((scrollOffset / 3));
    } else {
//        headerImageFrame.origin.y = _headerImageYOffset - scrollOffset;
        tableViewFrame.origin.y = scrollOffset;

    }
    
    _freeItemDataTable.frame = tableViewFrame;
//    _headerImageView.frame = headerImageFrame;
    
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

            
            return cell;
            
            break;
        }
        
            
        case 1: {
            
            static NSString *cellID = @"Cell2";
            JFFreeItemMapTableViewCell *cell = [_freeItemDataTable dequeueReusableCellWithIdentifier:cellID];
            
            if (cell == nil){
                cell = [[JFFreeItemMapTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            
            
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
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    
//    [self textViewDidChange:self.freeItemLogisticsTextView];
}


- (IBAction)iWantThisFreeItemButtonPressed:(UIButton *)sender {
    
    [self goToChatRoom];
    
}



-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    MKCircleView *circleView = [[MKCircleView alloc] initWithCircle:(MKCircle *)overlay];
    circleView.fillColor = [UIColor blueColor];
    circleView.alpha = 0.3;
    return circleView;
}

- (void)textViewDidChange:(JFFreeItemDescriptionTextView *)textView
{
  //  CGFloat fixedWidth = _freeItemLogisticsTextView.frame.size.width;
   // CGSize newSize = [_freeItemLogisticsTextView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
 //   CGRect newFrame = _freeItemLogisticsTextView.frame;
   // newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
//    _freeItemLogisticsTextView.frame = newFrame;
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
