//
//  JFTestAutoVC.m
//  GetGa
//
//  Created by Jared Fishman on 6/22/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFTestAutoVC.h"

@interface JFTestAutoVC ()

@property (strong, nonatomic) IBOutlet UIButton *button;

@property (strong, nonatomic) IBOutlet UILabel *label;

@end

@implementation JFTestAutoVC

-(void)viewDidLoad
{
    self.label.text = @"Thanks for helping me with AirPair---- and even for, yes, letting me take the recent 3-minute break as you so graciously provided ME";
    
}


@end
