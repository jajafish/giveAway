//
//  JFGetItemsTableViewC.m
//  GetGa
//
//  Created by Jared Fishman on 6/1/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFGetItemsTableViewC.h"
#import "JFGetItemCell.h"
#import "PFGetItem.h"

@interface JFGetItemsTableViewC ()
@property (strong, nonatomic) IBOutlet UITableView *getItemsTableView;

@property (strong, nonatomic) NSMutableArray *availableFreeStuff;

@end

@implementation JFGetItemsTableViewC



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    PFQuery *query = [PFQuery queryWithClassName:@"giveItem"];
//    [query whereKey:@"giver" notEqualTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.availableFreeStuff = [[NSMutableArray alloc]init];
            for (PFObject *object in objects) {
                PFGetItem *newGetItem = [[PFGetItem alloc]init];
                newGetItem = object[@"giveItemTitle"];
                
                // return photo files for each of the objecs
                PFFile *giveItemImageFile = object[@"imageFile"];
                [giveItemImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                    if (!error) {
                        UIImage *giveItemImageForCell = [UIImage imageWithData:imageData];
                        newGetItem.getItemImage = giveItemImageForCell;
                    };
                }];
                NSLog(@"hello");
                
                [self.availableFreeStuff addObject:newGetItem];
                
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        [self.getItemsTableView reloadData];
        
        NSLog(@"reached end of query");
        
    }];
    
}


#pragma mark - Table view data source



- (JFGetItemCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"getCell";
    
    JFGetItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell = [[JFGetItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    PFGetItem *giveItem = self.availableFreeStuff[indexPath.row];
    cell.getItemLabel.text = giveItem.getItemName;
    cell.getItemImageView.image = giveItem.getItemImage;
    
    return cell;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}



@end
