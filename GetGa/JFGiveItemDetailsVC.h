//
//  JFGiveItemDetailsVC.h
//  GetGa
//
//  Created by Jared Fishman on 5/29/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFMyGiveItemsCollectionVC.h"

@interface JFGiveItemDetailsVC : UIViewController

@property (strong ,nonatomic) UIImage *giveItemImage;

@property (weak, nonatomic) JFMyGiveItemsCollectionVC *rootVC;

@end
