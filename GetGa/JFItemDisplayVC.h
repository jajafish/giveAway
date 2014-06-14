//
//  JFItemDisplayVC.h
//  GetGa
//
//  Created by Jared Fishman on 6/14/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFGiveItem.h"

@class PFGiveItem;

@interface JFItemDisplayVC : UIViewController

@property (strong, nonatomic) PFGiveItem *giveItem;

@end
