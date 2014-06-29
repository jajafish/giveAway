//
//  JFChatRoom.h
//  GetGa
//
//  Created by Jared Fishman on 6/26/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import <Parse/Parse.h>

@interface PFChatRoom : PFObject <PFSubclassing>

+(NSString *)parseClassName;
@property (strong, nonatomic) PFUser *user1;
@property (strong, nonatomic) PFUser *user2;

@end
