//
//  JFGiveItemCell.m
//  GetGa
//
//  Created by Jared Fishman on 5/29/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFGiveItemCell.h"

@implementation JFGiveItemCell

@synthesize giveItemImageView = _giveItemImageView;
@synthesize giveItemLabel = _giveItemLabel;
@synthesize giveItemGiverUserPhoto = _giveItemGiverUserPhoto;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    
    return self;
}




- (void)awakeFromNib
{

    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = _labelBackgroundView.bounds;
    layer.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0] CGColor], (id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:1] CGColor], nil];
    layer.startPoint = CGPointMake(0.0f, 0.0f);
    layer.endPoint = CGPointMake(1.0f, 1.0f);
    
    _labelBackgroundView.layer.mask = layer;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
