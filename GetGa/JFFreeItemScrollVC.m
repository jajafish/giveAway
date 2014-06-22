//
//  JFFreeItemScrollVC.m
//  GetGa
//
//  Created by Jared Fishman on 6/22/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFFreeItemScrollVC.h"

@implementation JFFreeItemScrollVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.scoller setScrollEnabled:YES];
    [self.scoller setContentSize:CGSizeMake(320, 1000)];
}

@end
