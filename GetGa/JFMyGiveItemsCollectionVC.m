//
//  JFMyGiveItemsCollectionVC.m
//  GetGa
//
//  Created by Jared Fishman on 6/15/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFMyGiveItemsCollectionVC.h"
#import "PFGiveItem.h"
#import "JFMyGiveItemCollectionCell.h"
#import "JFGivePhotoVC.h"
#import "JFItemDisplayVC.h"
#import "JFCollectionHeaderView.h"
#import "CSStickyHeaderFlowLayout.h"

@interface JFMyGiveItemsCollectionVC ()

@property (strong, nonatomic) NSMutableArray *myGiveItems;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *logButton;
@property (strong, nonatomic) PFGiveItem *selectedItem;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) UIImage *profilePicture;


@end

@implementation JFMyGiveItemsCollectionVC

@synthesize myGiveItems;

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
    self.navigationItem.title = [PFUser currentUser][@"profile"][@"first_name"];
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    

    CSStickyHeaderFlowLayout *layout = (id)self.collectionView.collectionViewLayout;
    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
        layout.parallaxHeaderReferenceSize = CGSizeMake(320, 200);
//        layout.parallaxHeaderAlwaysOnTop = YES;
    }
    layout.disableStickyHeaders = YES;

    
    UINib *headerNib = [UINib nibWithNibName:@"CSGrowHeader" bundle:nil];
    [self.collectionView registerNib:headerNib
          forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader
                 withReuseIdentifier:@"header"];
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getUserProfilePicture];
    [self reloadParseData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"itemsCollectionToGivePhoto"]){
        if ([segue.destinationViewController isKindOfClass:[JFGivePhotoVC class]]){
            JFGivePhotoVC *targetVC = segue.destinationViewController;
            targetVC.mainItemsCollectionVC = self;
        }
    }
    if ([segue.identifier isEqualToString:@"itemCollectionToDisplay"])
    {
        if ([segue.destinationViewController isKindOfClass:[JFItemDisplayVC class]]){
            JFItemDisplayVC *targetVC = segue.destinationViewController;
            targetVC.giveItem = self.selectedItem;
        }
        
    }
    
}




#pragma mark - Give Item Data

-(void)reloadParseData
{
    self.myGiveItems = [[NSMutableArray alloc]init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"giveItem"];
    [query whereKey:@"giver" equalTo:[PFUser currentUser]];
    [query includeKey:@"giveItemPhoto"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            for (PFObject *object in objects) {
                PFGiveItem *newGiveItem = [[PFGiveItem alloc]init];
                newGiveItem.giveItemName = object[@"giveItemTitle"];
                newGiveItem.locationData = object[@"postedLocation"];
                PFObject *photoObj = object[@"giveItemPhoto"];
                PFFile *ourImageFile = photoObj[@"imageFile"];
                
                [ourImageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if (!error){
                        newGiveItem.image = [UIImage imageWithData:data];
                    }
                    [self.collectionView reloadData];
                }];
                
                [self.myGiveItems addObject:newGiveItem];
                
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        [self.collectionView reloadData];
    }];
    
}




#pragma mark - Collection View Methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.myGiveItems.count;

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"itemCollectionCell";
    
    JFMyGiveItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    PFGiveItem *giveItem = self.myGiveItems[indexPath.row];
    cell.giveItemLabel.text = [NSString stringWithFormat:@"  %@", giveItem.giveItemName];
    cell.collectionCellImageView.image = giveItem.image;
    cell.giveItemLabel.shadowColor = [UIColor clearColor];
    cell.giveItemLabel.highlighted = NO;
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedItem = myGiveItems[indexPath.row];
    [self performSegueWithIdentifier:@"itemCollectionToDisplay" sender:self];
}



-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:CSStickyHeaderParallaxHeader]) {
        
        UICollectionReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        return cell;
    } else if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        JFCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        NSString *title = [[NSString alloc]initWithFormat:@"Successfully given"];
        headerView.sectionTitleLabel.text = title;
        return headerView;
    }
    return nil;
    
}


#pragma mark - profile data

-(void)getUserProfilePicture
{
    PFQuery *query = [PFQuery queryWithClassName:@"profilePhoto"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error){
            
            PFFile *photoFile = [objects lastObject][@"photoPictureFile"];
            [photoFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if (!error){
                    self.profilePicture = [UIImage imageWithData:data];
                    self.profileImageView.image = self.profilePicture;
                    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
                    self.profileImageView.clipsToBounds = YES;
                    [self.profileImageView setNeedsDisplay];
                }
            }];
            
        }
        
    }];
}




@end
