//
//  JFGiveItemCategorySelectVC.m
//  GetGa
//
//  Created by Jared Fishman on 6/22/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFGiveItemCategorySelectVC.h"
#import "JFGiveItemCategoryCell.h"
#import "JFGiveItemLogisticsVC.h"

@implementation JFGiveItemCategorySelectVC


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"CategoryCell";
    
    JFGiveItemCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell = [[JFGiveItemCategoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"books";
            break;
        case 1:
            cell.textLabel.text = @"children's";
            break;
        case 2:
            cell.textLabel.text = @"clothing";
            break;
        case 3:
            cell.textLabel.text = @"electronics";
            break;
        case 4:
            cell.textLabel.text = @"furntiture";
            break;
        case 5:
            cell.textLabel.text = @"home appliances";
            break;
        case 6:
            cell.textLabel.text = @"sporting goods";
            break;
        case 7:
            cell.textLabel.text = @"other";
            break;
        default:
            break;
    }
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = cell.textLabel.text;
    NSLog(@"the cell text is %@", cellText);
    self.selectedCategory = cellText;
    NSLog(@"the selected category is %@", self.selectedCategory);
    [self performSegueWithIdentifier:@"itemCategoryToItemLogistics" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"itemCategoryToItemLogistics"]){
        if ([segue.destinationViewController isKindOfClass:[JFGiveItemLogisticsVC class]]){
            JFGiveItemLogisticsVC *targetVC = segue.destinationViewController;
            targetVC.giveItemImageFromDetails = self.giveItemImageFromDetails;
            targetVC.giveItemNameFromDetails = self.giveItemNameFromDetails;
            targetVC.giveItemCategory = self.selectedCategory;
        }
    }
    
}




@end


