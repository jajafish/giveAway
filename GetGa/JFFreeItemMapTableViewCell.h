//
//  JFFreeItemMapTableViewCell.h
//  GetGa
//
//  Created by Jared Fishman on 7/14/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface JFFreeItemMapTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet MKMapView *freeItemLocationMapView;

@end
