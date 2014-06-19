//
//  JFAppDelegate.m
//  GetGa
//
//  Created by Jared Fishman on 5/25/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFAppDelegate.h"
#import "PFGiveItem.h"


@implementation JFAppDelegate

{
    
    CLLocationManager *manager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;

    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [PFGiveItem registerSubclass];
    
    [Parse setApplicationId:@"IjFRIlLu8yBBxiUQYcal76jTJv631Y9vJF5XMugI"
                  clientKey:@"1nZesjcYElee33M9iWCCw2f3eKXhkMJNyivEuDbQ"];
    
    [PFFacebookUtils initializeFacebook];
    
    
    self->manager = [[CLLocationManager alloc]init];
    self->manager.delegate = self;
    self->manager.desiredAccuracy = kCLLocationAccuracyBest;
    [manager startUpdatingLocation];
    

    return YES;
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}





#pragma mark - CLLocationManagerDelegate Methods

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
    NSLog(@"Failed to get location!");
}


- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    CLLocation * newLocation = [locations lastObject];
    // post notification that a new location has been found
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newLocationNotif"
                                                        object:self
                                                      userInfo:[NSDictionary dictionaryWithObject:newLocation
                                                                                           forKey:@"newLocationResult"]];
}




@end
