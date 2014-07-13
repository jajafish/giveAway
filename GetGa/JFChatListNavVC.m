//
//  JFChatListNavVC.m
//  GetGa
//
//  Created by Jared Fishman on 6/23/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFChatListNavVC.h"
#import "JFChatListNavCell.h"
#import "ChatController.h"

@interface JFChatListNavVC ()

@property (strong, nonatomic) NSMutableArray *availableChatRooms;
@property (strong, nonatomic) PFChatRoom *selectedChat;

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
    
    chatCell.chatListUserTwoNameLabel.text = chattingUser[@"profile"][@"first_name"];
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
    
    
    return chatCell;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]){
//        
//        if ([segue.destinationViewController isKindOfClass:[ChatController class]]){
//            ChatController *chatVC = segue.destinationViewController;
//            chatVC.chatRoom = self.selectedChat;
//            //    chatVC.chatRoomTitle =  self.giveItem.itemGiver.giveGetterName;
//            NSLog(@"preparing segue for class of %@", [chatVC class]);
//        }
        
        UINavigationController *navController = segue.destinationViewController;
        ChatController *chatVC = (ChatController*)navController.topViewController;
        chatVC.chatRoom = self.selectedChat;
    
    }


}


#pragma mark - tableView DELEGATE

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedChat = _availableChatRooms[indexPath.row];
    [self performSegueWithIdentifier:@"firstRightSegue" sender:indexPath];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
