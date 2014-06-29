//
//  JFGivePhotoVC.h
//  GetGa
//
//  Created by Jared Fishman on 5/28/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFMyGiveItemsCollectionVC.h"

@interface JFGivePhotoVC : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong ,nonatomic) UIImage *giveItemImage;

@property (strong, nonatomic) JFMyGiveItemsCollectionVC *mainItemsCollectionVC;

@property (weak, nonatomic) UINavigationController *navController;

@end
