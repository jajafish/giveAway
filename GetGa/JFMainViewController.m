//
//  JFMainViewController.m
//  GetGa
//
//  Created by Jared Fishman on 5/31/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFMainViewController.h"

@interface JFMainViewController ()

@end

@implementation JFMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath
{
    NSString *identifier;
    switch (indexPath.row) {
        case 0:
            identifier = @"firstSegue";
            break;
        case 1:
            identifier = @"secondSegue";
            break;
        case 2:
            identifier = @"thirdSegue";
            break;
            
    }
    
    if (indexPath.row == 3) {
        identifier = nil;
        
        NSLog(@"pressed logout");
        [PFUser logOut];
        [[PFFacebookUtils session]closeAndClearTokenInformation];
        [[PFFacebookUtils session]close];
        [[FBSession activeSession]closeAndClearTokenInformation];
        [[FBSession activeSession]close];
        [FBSession setActiveSession:nil];
        
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage]; for(NSHTTPCookie *cookie in [storage cookies]) { NSString *domainName = [cookie domain]; NSRange domainRange = [domainName rangeOfString:@"facebook"]; if(domainRange.length > 0) { [storage deleteCookie:cookie]; } }
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    return identifier;
    
}


-(void)configureLeftMenuButton:(UIButton *)button
{
    
    CGRect frame = button.frame;
    frame.origin = (CGPoint){0, 0};
    frame.size = (CGSize){40,40};
    
    button.frame = frame;
    
}

-(BOOL)deepnessForLeftMenu
{
    return YES;
}

-(BOOL)deepnessForRightMenu
{
    return YES;
}


















@end
