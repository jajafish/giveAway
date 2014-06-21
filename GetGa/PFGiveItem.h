//
//  PFGiveItem.h
//  GetGa
//
//  Created by Jared Fishman on 5/30/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import <Parse/Parse.h>
#import "JFGiverGetter.h"

@interface PFGiveItem : PFObject <PFSubclassing>

+(NSString *)parseClassName;
@property (strong, nonatomic) NSString *giveItemName;
@property (nonatomic, strong) UIImage *image;
@property (strong, nonatomic) NSDictionary *locationData;
@property (strong, nonatomic) NSString *itemDetailsLogistics;
@property (strong, nonatomic) NSDate *itemListingExpireDate;
@property (strong, nonatomic) NSString *itemGiverName;
@property (strong, nonatomic) JFGiverGetter *itemGiver;

@end
