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

@property (strong, nonatomic) IBOutlet UITableView *getItemsTableView;

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
                NSLog(@"%@", newGetItem);
                
                [self.availableFreeStuff addObject:[newGetItem description]];
                
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
    
//    PFGetItem *giveItem = self.availableFreeStuff[indexPath.row];
    cell.getItemLabel.text = @"bob";
//    cell.getItemImageView.image = giveItem.getItemImage;
    
    return cell;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
