//
//  JFGiverGetter.h
//  GetGa
//
//  Created by Jared Fishman on 6/21/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import <Parse/Parse.h>

@interface JFGiverGetter : PFUser <PFSubclassing>

@property (strong, nonatomic) NSString *giveGetterName;
@property (strong, nonatomic) NSMutableDictionary *giveGetterLatestLocation;
@property (strong, nonatomic) UIImage *giveGetterProfileImage;
@property (strong, nonatomic) NSMutableArray *giveGetterItemsToGive;
@property (strong, nonatomic) NSMutableArray *giveGetterItemsIWant;

@end
