//
//  JFFreeItemScrollVC.h
//  GetGa
//
//  Created by Jared Fishman on 6/22/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFGiveItem.h"

@interface JFFreeItemScrollVC : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scoller;
@property (strong, nonatomic) PFGiveItem *giveItem;

@end
