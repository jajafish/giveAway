//
//  JFGiveItemCategorySelectVC.h
//  GetGa
//
//  Created by Jared Fishman on 6/22/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFGiveItemCategorySelectVC : UITableViewController

@property (strong, nonatomic) UIImage *giveItemImageFromDetails;
@property (strong, nonatomic) NSString *giveItemNameFromDetails;
@property (strong, nonatomic) NSString *selectedCategory;

@end
