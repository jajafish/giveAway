//
//  JFItemChatVC.h
//  GetGa
//
//  Created by Jared Fishman on 6/22/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JSQMessagesViewController.h"

@interface JFItemChatVC : JSQMessagesViewController <JSQMessagesCollectionViewDataSource, JSQMessagesCollectionViewDelegateFlowLayout>

@property (strong, nonatomic) PFObject *chatRoom;

@end
