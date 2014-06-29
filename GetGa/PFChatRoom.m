//
//  JFChatRoom.m
//  GetGa
//
//  Created by Jared Fishman on 6/26/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "PFChatRoom.h"
#import <Parse/PFObject+Subclass.h>

@implementation PFChatRoom

@dynamic user1, user2;

+(NSString *)parseClassName
{
    return @"PFChatRoom";
}

@end
