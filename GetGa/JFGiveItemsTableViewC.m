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

@property (strong, nonatomic) IBOutlet UIBarButtonItem *logButton;



@end


@implementation JFGiveItemsTableViewC

@synthesize myGiveItems;

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
    [self.navigationItem setHidesBackButton:YES];
//    [self.tableView setContentInset:UIEdgeInsetsMake(50,0,0,0)];
}


-(void)viewWillAppear:(BOOL)animated
{
//    PFQuery *query = [PFQuery queryWithClassName:@"giveItem"];
//    [query whereKey:@"giver" equalTo:[PFUser currentUser]];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            self.myGiveItems = [[NSMutableArray alloc]init];
//            for (PFObject *object in objects) {
//                PFGiveItem *newGiveItem = [[PFGiveItem alloc]init];
//                newGiveItem.giveItemName = object[@"giveItemTitle"];
//                
//                // return photo files for each of the objecs
//                PFFile *giveItemImageFile = object[@"imageFile"];
//                [giveItemImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
//                    if (!error) {
//                        UIImage *giveItemImageForCell = [UIImage imageWithData:imageData];
//                        newGiveItem.giveItemImage = giveItemImageForCell;
//                    };
//                }];
//                
//                [self.myGiveItems addObject:newGiveItem];
//
//            }
//        } else {
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//        [self.tableView reloadData];
//    }];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myGiveItems.count;
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

    PFGiveItem *giveItem = self.myGiveItems[indexPath.row];
    cell.giveItemLabel.text = giveItem.giveItemName;
    cell.giveItemImageView.image = giveItem.giveItemImage;
    
    return cell;
}


//-(void)getImagesForGiveItemCells
//{
//    
//    
//    PFQuery *imagesQuery = [PFQuery queryWithClassName:@"giveItemPhoto"];
//    [imagesQuery whereKey:@"imageFile" equalTo:@"laptop"];
//    [imagesQuery countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
//       
//        if (number == 0)
//        {
//            
//            NSURL
//            
//            
//            
//        }
//        
//    }];
//}



- (IBAction)logButtonPressed:(UIBarButtonItem *)sender {
    
    NSLog(@"%@", self.myGiveItems);
    
    
}


@end
