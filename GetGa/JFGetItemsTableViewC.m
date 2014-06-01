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

@property (strong, nonatomic) NSMutableArray *availableFreeStuff;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *filterButton;

//@property (strong, nonatomic) IBOutlet UITableView *getItemsTableView;

@end

@implementation JFGetItemsTableViewC

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
    
    self.availableFreeStuff = [[NSMutableArray alloc]init];
    
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
    [query whereKey:@"giver" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {

            for (PFObject *object in objects) {
                PFGetItem *newGetItem = [[PFGetItem alloc]init];
                newGetItem = object[@"giveItemTitle"];
                NSLog(@"%@", newGetItem);
                [self.availableFreeStuff addObject:newGetItem];
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        [self.tableView reloadData];
        
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
    
    PFGetItem *getItem = self.availableFreeStuff[indexPath.row];
    cell.getItemLabel.text = getItem.getItemName;
//    cell.getItemImageView.image = giveItem.getItemImage;
    
    return cell;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.availableFreeStuff.count;
}

- (IBAction)filterButtonPressed:(UIBarButtonItem *)sender {
    
    NSLog(@"%@", self.availableFreeStuff);
    
}


@end
