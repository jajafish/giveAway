//
//  PFGiveItem.m
//  GetGa
//
//  Created by Jared Fishman on 5/30/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "PFGiveItem.h"
#import <Parse/PFObject+Subclass.h>

@implementation PFGiveItem

@dynamic giveItemName;
@dynamic giveItemImage;

+(NSString *)parseClassName
{
    return @"PFGiveItem";
}

@end
