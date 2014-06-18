//
//  JFGiveItemLogisticsVC.m
//  GetGa
//
//  Created by Jared Fishman on 6/16/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFGiveItemLogisticsVC.h"
#import <QuartzCore/QuartzCore.h>
#import "JFMyGiveItemsCollectionVC.h"

@interface JFGiveItemLogisticsVC () <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *logisticsTextView;
@property (strong, nonatomic) IBOutlet UIButton *revealDatePickerButton;
@property (strong, nonatomic) IBOutlet UIButton *confirmLogisticsButton;

@end

@implementation JFGiveItemLogisticsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.logisticsTextView becomeFirstResponder];
    
    self.revealDatePickerButton.layer.cornerRadius = 2;
    self.revealDatePickerButton.layer.borderWidth = 1;
    self.revealDatePickerButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"stopped editing");
}

- (IBAction)confirmLogisticsButtonPressed:(id)sender {
    
    self.detailsAndLogistics = self.logisticsTextView.text;
    
    JFMyGiveItemsCollectionVC *giveItemsCollectionVC = [[JFMyGiveItemsCollectionVC alloc]init];
    [self.navigationController popToViewController:giveItemsCollectionVC animated:YES];
}


@end
