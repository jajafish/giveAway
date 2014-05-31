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
    
    PFQuery *query = [PFQuery queryWithClassName:@"giveItem"];
    [query whereKey:@"giver" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.myGiveItems = [[NSMutableArray alloc]init];
            for (PFObject *object in objects) {
                PFGiveItem *newGiveItem = [[PFGiveItem alloc]init];
                newGiveItem.giveItemName = object[@"giveItemTitle"];
                newGiveItem.giveItemImage = object[@"giveItemPhoto"];
                [self.myGiveItems addObject:newGiveItem];
            }
            [self.tableView reloadData];
            NSLog(@"%@",objects);
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
    
    
    return cell;
}





//    NSString *pathToPhotoFile = giveItem.giveItemImage[@"giveItemPhoto"];

//NSLog(@"%@", giveItem.giveItemImage);

//    PFFile *giveItemImageFile = giveItem[@"giveItemPhoto"][@"imageFIle"];
//    [giveItemImageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//        cell.giveItemImageView.image = [UIImage imageWithData:data];
//        NSLog(@"hello");
//    }];




//-(void)requestImage
//{
//    PFQuery *imageQuery = [PFQuery queryWithClassName:@"giveItemPhoto"];
//    [imageQuery whereKey:<#(NSString *)#> equalTo:<#(id)#>]


    
//    QUERY PHOTOS WHERE USER key is current user AND item name key is current item name


//    
//    
//}






@end
