//
//  JFFreeStuffVC.m
//  GetGa
//
//  Created by Jared Fishman on 6/16/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFFreeStuffVC.h"
#import "JFGiveItemCell.h"
#import "PFGiveItem.h"
#import "JFFreeItemVC.h"
#import "ILTranslucentView.h"
#import <QuartzCore/QuartzCore.h>

@interface JFFreeStuffVC ()

@property (strong, nonatomic) NSMutableArray *availableFreeStuff;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) PFGiveItem *selectedItem;
@property (strong, nonatomic) IBOutlet UIButton *giveSomethingAwayButton;
@property (strong, nonatomic) IBOutlet ILTranslucentView *blurView;

@end

@implementation JFFreeStuffVC

@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    [self.tableView reloadData];
    //    [self.tableView setContentInset:UIEdgeInsetsMake(50,0,0,0)];
}


-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBar.topItem.title = @"Free Stuff";
    [self reloadParseData];
    self.giveSomethingAwayButton.layer.cornerRadius = 5;
    self.giveSomethingAwayButton.layer.borderWidth = 1;
    self.giveSomethingAwayButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.blurView.translucentAlpha = 0.7;
    
    
    
}

-(void)reloadParseData
{
    self.availableFreeStuff = [[NSMutableArray alloc]init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"giveItem"];
    [query whereKey:@"giver" equalTo:[PFUser currentUser]];
    [query includeKey:@"giveItemPhoto"];
    [query includeKey:@"giver"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            for (PFObject *object in objects) {
                PFGiveItem *newGiveItem = [[PFGiveItem alloc]init];
                newGiveItem.giveItemName = object[@"giveItemTitle"];
                newGiveItem.locationData = object[@"postedLocation"];
                newGiveItem.itemDetailsLogistics = object[@"giveItemLogistics"];
                
                
                JFGiverGetter *itemGiverGetter = (JFGiverGetter*)[JFGiverGetter object];
                itemGiverGetter = object[@"giver"];
                newGiveItem.itemGiver = itemGiverGetter;
                NSString *itemGiverGetterName = [[NSString alloc]init];
                itemGiverGetterName = itemGiverGetter[@"profile"][@"name"];
                newGiveItem.itemGiverName = itemGiverGetterName;
                
                PFObject *photoObj = object[@"giveItemPhoto"];
                PFFile *ourImageFile = photoObj[@"imageFile"];
                
                [ourImageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if (!error){
                        newGiveItem.image = [UIImage imageWithData:data];
                    }
                    [self.tableView reloadData];
                }];
                
                [self.availableFreeStuff addObject:newGiveItem];
                
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        [self.tableView reloadData];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.availableFreeStuff.count;
}

-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


- (JFGiveItemCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    JFGiveItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell = [[JFGiveItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    PFGiveItem *giveItem = self.availableFreeStuff[indexPath.row];
    cell.giveItemLabel.text = [NSString stringWithFormat:@"  %@", giveItem.giveItemName];
    cell.giveItemImageView.image = giveItem.image;
    cell.giveItemLabel.shadowColor = [UIColor clearColor];
    cell.giveItemLabel.highlighted = NO;
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"freeStuffToFreeItem"]){
        if ([segue.destinationViewController isKindOfClass:[JFFreeItemVC class]]){
            NSLog(@"hello making the transition:");
            JFFreeItemVC *targetVC = segue.destinationViewController;
            targetVC.giveItem = self.selectedItem;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedItem = self.availableFreeStuff[indexPath.row];
    NSLog(@"the selected item was %@", self.selectedItem);
    [self performSegueWithIdentifier:@"freeStuffToFreeItem" sender:self];
}







@end
