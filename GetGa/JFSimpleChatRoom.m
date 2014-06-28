//
//  JFSimpleChatRoom.m
//  GetGa
//
//  Created by Jared Fishman on 6/24/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFSimpleChatRoom.h"

@interface JFSimpleChatRoom ()

@property (strong, nonatomic) NSString *chatRoomObjectID;

@end

@implementation JFSimpleChatRoom

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    if (!_chatController) _chatController = [ChatController new];
    _chatController.delegate = self;
    _chatController.opponentImg = [UIImage imageNamed:@"tempUser.png"];
    [self presentViewController:_chatController animated:YES completion:nil];
    self.chatTitle = @"hello";
    self.user1 = self.chatRoom[@"user1"];
    self.user2 = self.chatRoom[@"user2"];
    
    
//    NSLog(@"the users involved in this chatroom are %@ and %@", self.user1, self.user2);
//    NSLog(@"this chatroom is %@", self.chatRoom);
    self.chatRoomObjectID = [self.chatRoom objectId];
//    NSLog(@"the object ID of this chatRoom is %@", self.chatRoomObjectID);
    
//    NSLog(@"before query the chats are %@", self.chats);
    
    [self queryForChatRoomMessages];
    
}


-(void)chatController:(ChatController *)chatController didSendMessage:(NSMutableDictionary *)message
{
    NSLog(@"Message contents: %@", message[kMessageContent]);
    NSLog(@"Timestamp: %@", message[kMessageTimestamp]);
    
    message[@"sentByUserId"] = @"currentUserId";
    
    PFObject *chatMessage = [PFObject objectWithClassName:@"chatMessage"];
    

    [chatMessage setObject:[PFUser currentUser] forKey:@"from"];
    [chatMessage setObject:self.user2 forKey:@"to"];
    chatMessage[@"messageText"] = message[kMessageContent];
    chatMessage[@"messageTime"] = message[kMessageTimestamp];
    chatMessage[@"chatRoom"] = self.chatRoom;
    
    [chatMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self.chats addObject:chatMessage];
        [_chatController addNewMessage:message];
    }];

}

-(void)queryForChatRoomMessages {
    
    PFQuery *messagesQuery = [PFQuery queryWithClassName:@"chatMessage"];
//    [messagesQuery whereKey:@"chatRoom" equalTo:self.chatRoomObjectID];
    [messagesQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        self.chats = [objects mutableCopy];
        [self.chatController setMessagesArray:self.chats];
        NSLog(@"the chats are %@", self.chats);

    }];
    
}



@end
