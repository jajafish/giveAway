//
//  JFGiveItemsTableVC.m
//  GetGa
//
//  Created by Jared Fishman on 5/29/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFGiveItemsTableVC.h"
#import "JFGiveItemCell.h"
#import "PFGiveItem.h"

@interface JFGiveItemsTableVC ()

@property (strong, nonatomic) NSArray *giveItems;
@property (strong, nonatomic) PFGiveItem *giveItem;


@end

@implementation JFGiveItemsTableVC

-(id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self){
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        self.objectsPerPage = 25;
    }
    return self;
}


- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:@"giveItem"];
    [query includeKey:@"giveItemPhoto"];
    
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByAscending:@"createdAt"];
    

    
    
    self.giveItems = self.objects;
    
    for (PFGiveItem *object in self.giveItems) {
        NSString *imageName = object[@"objectId"];
        NSLog(@"%@", imageName);
        
    }
    
//    NSLog(@"%@", self.giveItems);
    
    
    return query;
    
}


-(JFGiveItemCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *CellIdentifier = @"Cell";
    
    JFGiveItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[JFGiveItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.giveItemLabel.text = [object objectForKey:@"giveItemTitle"];
    cell.giveItemImageView.image = [UIImage imageNamed:@"appshot.png"];


    return cell;
    
}


//-(void)queryForGiveItemPhotoFiles
//{
//    
//    for (
//    
//    
//}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
