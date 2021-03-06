//
//  JFGiveItemDetailsVC.m
//  GetGa
//
//  Created by Jared Fishman on 5/29/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFGiveItemDetailsVC.h"
#import "JFMyGiveItemsCollectionVC.h"
#import "JFGiveItemCategorySelectVC.h"
#import <CoreLocation/CoreLocation.h>
#import "UIImage+ImageEffects.h"

@interface JFGiveItemDetailsVC () <UITextFieldDelegate, UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *giveItemPhotoImageView;
@property (strong, nonatomic) IBOutlet UITextField *giveItemTitleTextField;

@property (strong, nonatomic) UIPanGestureRecognizer *moveRecognizer;

@property(nonatomic, assign) id<UIToolbarDelegate> delegate;

@end

@implementation JFGiveItemDetailsVC


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

#pragma mark - S

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.giveItemTitleTextField.delegate = self;
    
    self.giveItemPhotoImageView.image = self.giveItemImage;

    UIColor *color = [UIColor blackColor];
    self.giveItemTitleTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"What are you giving away?" attributes:@{NSForegroundColorAttributeName: color}];
    
    self.giveItemTitleTextField.userInteractionEnabled = YES;
    
    UIImage *effectImage = nil;
    effectImage = [self.giveItemImage applyLightEffect];
    self.giveItemPhotoImageView.image = effectImage;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.giveItemTitleTextField becomeFirstResponder];
}

-(void)viewDidAppear:(BOOL)animated
{
        NSLog(@"navigation controller of GIVE ITEM DETAILS VC IS %@", self.navigationController);
}

#pragma mark - Submit Item to Parse

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self performSegueWithIdentifier:@"itemDetailsToItemTags" sender:self];
    
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"itemDetailsToItemTags"]){
        if ([segue.destinationViewController isKindOfClass:[JFGiveItemCategorySelectVC class]]){
            JFGiveItemCategorySelectVC *targetVC = segue.destinationViewController;
            targetVC.giveItemNameFromDetails = self.giveItemTitleTextField.text;
            targetVC.giveItemImageFromDetails = self.giveItemImage;
        }
    }
}



@end


