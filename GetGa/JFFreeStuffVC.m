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

@interface JFFreeStuffVC ()

@property (strong, nonatomic) NSMutableArray *availableFreeStuff;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

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
    
    [self reloadParseData];
    
}

-(void)reloadParseData
{
    self.availableFreeStuff = [[NSMutableArray alloc]init];
    
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



@end
