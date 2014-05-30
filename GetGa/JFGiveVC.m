//
//  JFGiveVC.m
//  GetGa
//
//  Created by Jared Fishman on 5/25/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFGiveVC.h"

@interface JFGiveVC () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *itemTitleTextField;
@property(nonatomic, assign) id<UIToolbarDelegate> delegate;

@end

@implementation JFGiveVC

@synthesize label;
@synthesize segmentedControl;

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
    // Do any additional setup after loading the view.
    label.text = @"First";
    
    self.navigationItem.hidesBackButton = YES;
    
    self.itemTitleTextField.delegate = self;
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    
}


#pragma mark - UI Alterations




-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    
    UIToolbar *toolbar = [UIToolbar new];
    [toolbar sizeToFit];
    toolbar.backgroundColor = [UIColor lightGrayColor];
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *addPhotoBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:nil];
    [barItems addObject:addPhotoBarButton];
    [toolbar setItems:barItems];
    self.itemTitleTextField.inputAccessoryView = toolbar;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if(!image) image = info[UIImagePickerControllerOriginalImage];
    
//    [self.photos addObject:[self photoFromImage:image]];
//    
//    [self.collectionView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


@end
