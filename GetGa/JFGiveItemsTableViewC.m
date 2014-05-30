//
//  JFGiveItemsTableViewC.m
//  GetGa
//
//  Created by Jared Fishman on 5/30/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFGiveItemsTableViewC.h"
#import "PFGiveItem.h"
#import "JFGiveItemCell.h"

@interface JFGiveItemsTableViewC ()

@property (strong, nonatomic) NSMutableArray *myGiveItems;

@end

@implementation JFGiveItemsTableViewC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    PFQuery *query = [PFQuery queryWithClassName:@"giveItem"];
    [query whereKey:@"giver" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d give items.", objects.count);
            // Do something with the found objects
            
            NSMutableArray *mutableGiveItems = [[NSMutableArray alloc]init];
            
            for (PFObject *object in objects) {
                PFGiveItem *newGiveItem = [[PFGiveItem alloc]init];
                newGiveItem.giveItemName = object[@"giveItemTitle"];
                newGiveItem.giveItemImage = object[@"giveItemPhoto"];
                [mutableGiveItems addObject:newGiveItem];
                [self.myGiveItems addObjectsFromArray:mutableGiveItems];
                NSLog(@"%@", mutableGiveItems);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        
        
    }];
    
    

    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myGiveItems count];
}




    
    
- (JFGiveItemCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    JFGiveItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        

    PFGiveItem *giveItem = self.myGiveItems[indexPath.row];
    cell.giveItemLabel.text = giveItem.giveItemName;
        
    /* Now that the cell is configured we return it to the table view so that it can display it */
        
    return cell;

    
    
}




@end
