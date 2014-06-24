//
//  JFSimpleChatRoom.m
//  GetGa
//
//  Created by Jared Fishman on 6/24/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFSimpleChatRoom.h"

@implementation JFSimpleChatRoom

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UILabel * tapLabel = [UILabel new];
    tapLabel.bounds = CGRectMake(0, 0, 200, 100);
    tapLabel.text = @"** TAP TO OPEN **";
    tapLabel.textAlignment = NSTextAlignmentCenter;
    tapLabel.center = self.view.center;
    tapLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    [self.view addSubview:tapLabel];
    
    UITapGestureRecognizer * tap = [UITapGestureRecognizer new];
    [tap addTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tap];
}

- (void) handleTap:(UITapGestureRecognizer *)tap {
    
    if (!_chatController) _chatController = [ChatController new];
    _chatController.delegate = self;
    _chatController.opponentImg = [UIImage imageNamed:@"tempUser.png"];
    [self presentViewController:_chatController animated:YES completion:nil];
}


-(void)chatController:(ChatController *)chatController didSendMessage:(NSMutableDictionary *)message
{
    NSLog(@"Message contents: %@", message[kMessageContent]);
    NSLog(@"Timestamp: %@", message[kMessageTimestamp]);
    
    message[@"sentByUserId"] = @"currentUserId";
    
    [_chatController addNewMessage:message];
}




@end
