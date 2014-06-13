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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self reloadParseData];
    
}


-(void)reloadParseData
{

    
    PFQuery *query = [PFQuery queryWithClassName:@"giveItem"];
    [query includeKey:@"giveItemPhoto"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            for (PFObject *object in objects) {
                PFGetItem *newGetItem = [[PFGetItem alloc]init];
                newGetItem.getItemName = object[@"giveItemTitle"];
                
                PFObject *photoObject = object[@"giveItemPhoto"];
                PFFile *getImageFile = photoObject[@"imageFile"];
                [getImageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if (!error){
                        newGetItem.image = [UIImage imageWithData:data];
                    }
                    [self.tableView reloadData];
                }];
                

                [self.availableFreeStuff addObject:newGetItem];

            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        [self.tableView reloadData];
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
    cell.getItemImageView.image = getItem.image;
    

    return cell;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.availableFreeStuff count];
}

- (IBAction)filterButtonPressed:(UIBarButtonItem *)sender {
    
    
}


@end
