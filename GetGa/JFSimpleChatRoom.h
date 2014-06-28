//
//  JFSimpleChatRoom.h
//  GetGa
//
//  Created by Jared Fishman on 6/24/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatController.h"
#import "PFChatRoom.h"

@interface JFSimpleChatRoom : UIViewController <ChatControllerDelegate>

@property (strong, nonatomic) ChatController *chatController;
@property (strong, nonatomic) NSString * chatTitle;

@property (strong, nonatomic) PFChatRoom *chatRoom;

@property (strong, nonatomic) PFUser *user1;
@property (strong, nonatomic) PFUser *user2;

@end
