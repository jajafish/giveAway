//
//  PFChatMessage.h
//  GetGa
//
//  Created by Jared Fishman on 7/1/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import <Parse/Parse.h>
#import "PFChatRoom.h"
#import "JFGiverGetter.h"

@interface PFChatMessage : PFObject <PFSubclassing>

@property (strong, nonatomic) PFChatRoom *chatRoom;
@property (strong, nonatomic) PFUser *from;
@property (strong, nonatomic) PFUser *to;
@property (strong, nonatomic) NSString *messageText;
@property int *messageSize;





//@property (strong, nonatomic) NSDate *messageTime;



@end

