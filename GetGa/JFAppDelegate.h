//
//  JFAppDelegate.h
//  GetGa
//
//  Created by Jared Fishman on 5/25/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface JFAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate, UIAppearance>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;

@end


