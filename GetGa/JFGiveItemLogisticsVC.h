//
//  JFGiveItemLogisticsVC.h
//  GetGa
//
//  Created by Jared Fishman on 6/16/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFMyGiveItemsCollectionVC.h"

@interface JFGiveItemLogisticsVC : UIViewController

@property (strong, nonatomic) NSString *detailsAndLogistics;
@property (strong, nonatomic) UIImage *giveItemImageFromDetails;
@property (strong, nonatomic) NSString *giveItemNameFromDetails;

@property (weak, nonatomic) JFMyGiveItemsCollectionVC *rootVC;

@end
