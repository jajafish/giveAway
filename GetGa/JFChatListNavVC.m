//
//  JFChatListNavVC.m
//  GetGa
//
//  Created by Jared Fishman on 6/23/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFChatListNavVC.h"
#import "JFChatListNavCell.h"
#import "JFItemChatVC.h"

@interface JFChatListNavVC ()

@property (strong, nonatomic) NSMutableArray *availableChatRooms;

@end

@implementation JFChatListNavVC


#pragma mark - lazy isntantiation

-(NSMutableArray *)availableChatRooms
{
    if (!_availableChatRooms){
        _availableChatRooms = [[NSMutableArray alloc]init];
    }
    return _availableChatRooms;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self updateAvailableChatRooms];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.availableChatRooms count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"ChatCell";
    
    JFChatListNavCell *chatCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    PFObject *chatRoom = [self.availableChatRooms objectAtIndex:indexPath.row];
    PFUser *chattingUser;
    PFUser *currentUser = [PFUser currentUser];
    PFUser *testUser1 = chatRoom[@"user1"];
    if ([testUser1.objectId isEqual:currentUser.objectId]){
        chattingUser = [chatRoom objectForKey:@"user2"];
    }
    else {
        chattingUser = [chatRoom objectForKey:@"user1"];
    }
    
    chatCell.chatListUserTwoNameLabel.text = chattingUser[@"profile"][@"name"];
    chatCell.chatListCellBackgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    PFQuery *queryForPhoto = [[PFQuery alloc]initWithClassName:@"profilePhoto"];
    [queryForPhoto whereKey:@"photoUser" equalTo:chattingUser];
    [queryForPhoto findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] > 0){
            PFObject *photo = objects[0];
            PFFile *pictureFile = photo[@"photoPictureFile"];
            [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                chatCell.chatListCellUserTwoImageView.image = [UIImage imageWithData:data];
                chatCell.chatListCellBackgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
            }];
        }
    }];
    
    
    

//    chatCell.chatListItemNameLabel.text = @"Baseball bat";
//    chatCell.chatListLatestMessageLabel.text = @"still want it?";
//    chatCell.chatListUserTwoNameLabel.text = @"Billy Bob";
//    chatCell.chatListCellBackgroundImageView.image = [UIImage imageNamed:@"dad.png"];
//    chatCell.chatListCellUserTwoImageView.image = [UIImage imageNamed:@"appshot.png"];

    return chatCell;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    JFItemChatVC *chatVC = segue.destinationViewController;
    NSIndexPath *indexPath = sender;
    chatVC.chatRoom = [self.availableChatRooms objectAtIndex:indexPath.row];
}


#pragma mark - tableView DELEGATE

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"firstRightSegue" sender:indexPath];
}


#pragma mark - Helper Methods

-(void)updateAvailableChatRooms
{
    
    PFQuery *query = [PFQuery queryWithClassName:@"ChatRoom"];
    [query whereKey:@"user1" equalTo:[PFUser currentUser]];
    PFQuery *queryInverse = [PFQuery queryWithClassName:@"ChatRoom"];
    [queryInverse whereKey:@"user2" equalTo:[PFUser currentUser]];
    PFQuery *queryCombined = [PFQuery orQueryWithSubqueries:@[query, queryInverse]];
    [queryCombined includeKey:@"chat"];
    [queryCombined includeKey:@"user1"];
    [queryCombined includeKey:@"user2"];
    [queryCombined findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error){
            [self.availableChatRooms removeAllObjects];
            self.availableChatRooms = [objects mutableCopy];
            [self.tableView reloadData];
        }
    }];
    
}


@end
