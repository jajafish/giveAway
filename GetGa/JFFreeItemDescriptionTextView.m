//
//  JFFreeItemDescriptionTextView.m
//  GetGa
//
//  Created by Jared Fishman on 7/13/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFFreeItemDescriptionTextView.h"

@implementation JFFreeItemDescriptionTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollEnabled = NO;
    }
    return self;

}


-(void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated
{
    // do nothing
}


@end
