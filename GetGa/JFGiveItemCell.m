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


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    
    return self;
}




- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
