//
//  JFGiveItemCategorySelectVC.m
//  GetGa
//
//  Created by Jared Fishman on 6/22/14.
//  Copyright (c) 2014 Jared Fishman. All rights reserved.
//

#import "JFGiveItemCategorySelectVC.h"

@implementation JFGiveItemCategorySelectVC


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = cell.textLabel.text;
    NSLog(@"the cell text is %@", cellText);
    self.selectedCategory = cellText;
    NSLog(@"the selected category is %@", self.selectedCategory);
    [self performSegueWithIdentifier:@"itemCategoryToItemLogistics" sender:self];
}





@end


