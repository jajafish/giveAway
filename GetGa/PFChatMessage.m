//
//  PFChatMessage.m
//  GetGa
//
//  Created by Jared Fishman on 7/1/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "PFChatMessage.h"
#import <Parse/PFObject+Subclass.h>

@implementation PFChatMessage

@dynamic chatRoom, from, to, messageText;

+(NSString *)parseClassName
{
    return @"PFChatMessage";
}

@end
