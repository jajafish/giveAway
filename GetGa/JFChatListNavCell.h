//
//  JFChatListNavCell.h
//  GetGa
//
//  Created by Jared Fishman on 6/23/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFChatListNavCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *chatListCellBackgroundImageView;
@property (strong, nonatomic) IBOutlet UIImageView *chatListCellUserTwoImageView;
@property (strong, nonatomic) IBOutlet UILabel *chatListUserTwoNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *chatListItemNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *chatListLatestMessageLabel;

@end
