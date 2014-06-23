//
//  JFChatListNavVC.m
//  GetGa
//
//  Created by Jared Fishman on 6/23/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFChatListNavVC.h"
#import "JFChatListNavCell.h"

@implementation JFChatListNavVC

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"ChatCell";
    
    JFChatListNavCell *chatCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    chatCell.chatListItemNameLabel.text = @"Baseball bat";
    chatCell.chatListLatestMessageLabel.text = @"still want it?";
    chatCell.chatListUserTwoNameLabel.text = @"Billy Bob";
    chatCell.chatListCellBackgroundImageView.image = [UIImage imageNamed:@"dad.png"];
    chatCell.chatListCellUserTwoImageView.image = [UIImage imageNamed:@"appshot.png"];

    return chatCell;

    
}


@end
