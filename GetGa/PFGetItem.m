//
//  JFGetItem.m
//  GetGa
//
//  Created by Jared Fishman on 6/1/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "PFGetItem.h"
#import <Parse/PFObject+Subclass.h>

@implementation PFGetItem

@dynamic getItemName;
@dynamic getItemImage;

+(NSString *)parseClassName
{
    return @"PFGetItem";
}


@end
