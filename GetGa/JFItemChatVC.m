//
//  JFItemChatVC.m
//  GetGa
//
//  Created by Jared Fishman on 6/22/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFItemChatVC.h"

@interface JFItemChatVC ()

@property (strong, nonatomic) PFUser *chattingUser;
@property (strong, nonatomic) PFUser *currentUser;

@property (strong, nonatomic) NSTimer *chatTimer;
@property (nonatomic) BOOL initialLoadComplete;

@property (strong, nonatomic) NSMutableArray *chats;

@end

@implementation JFItemChatVC

-(NSMutableArray *)chats
{
    if (!_chats){
        _chats = [[NSMutableArray alloc]init];
    }
    return _chats;
}

-(void)viewDidLoad
{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;


}


@end
