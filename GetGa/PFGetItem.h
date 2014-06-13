//
//  JFGetItem.h
//  GetGa
//
//  Created by Jared Fishman on 6/1/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import <Parse/Parse.h>

@interface PFGetItem : PFObject <PFSubclassing>

+(NSString *)parseClassName;
@property (strong, nonatomic) NSString *getItemName;
@property (nonatomic, strong) UIImage *image;
@property (strong, nonatomic) NSString *zipCode;

@end
