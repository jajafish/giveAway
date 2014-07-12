//
//  JFavCameraVC.h
//  GetGa
//
//  Created by Jared Fishman on 7/11/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreVideo/CoreVideo.h>
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>
#import <QuartzCore/QuartzCore.h>

@interface JFavCameraVC : UIViewController <UINavigationControllerDelegate>

@property (nonatomic, retain) IBOutlet UIView *vImagePreview;

@property (strong, nonatomic) IBOutlet UIButton *takePicButton;

@property(nonatomic, retain) AVCaptureStillImageOutput *stillImageOutput;

@property (strong, nonatomic) IBOutlet UIImageView *outputImageView;

@property (strong, nonatomic) UIImage *imageForNext;

@end
