//
//  HeaderAndFooterListViewController.m
//  Coac2012
//
//  Created by Borja Arias Drake on 25/11/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "HeaderAndFooterListViewController.h"

@interface HeaderAndFooterListViewController ()

@end

@implementation HeaderAndFooterListViewController



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // This class assumes there are 3 sections: HEADER, CONTENT, FOOTER
    // If a subclass wants to have more sentions in the content section, it can override this method, but it will have
    // to take into account the superclass'es expectations.
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *NormalCellIdentifier = @"NormalCell";
    static NSString *HeaderCellIdentifier = @"HeaderCell";
    static NSString *FooterCellIdentifier = @"FooterCell";
    NSString * cellIdentifier = @"NormalCell";
    NSString* nibToLoad = [self normalCellNibName];
    

    const int FirstSection = 0;
    const int LastSection = [self numberOfSections] - 1;
    
    
    if (indexPath.section == FirstSection)
    {
        nibToLoad = [self headerCellNibName];
        cellIdentifier = HeaderCellIdentifier;
    }
    else if (indexPath.section == LastSection)
    {
        nibToLoad = [self footerCellNibName];
        cellIdentifier = FooterCellIdentifier;
    }
    else
    {
        nibToLoad = [self normalCellNibName];
        cellIdentifier = NormalCellIdentifier;
    }
    
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        self.cellFromNib = [[NSBundle mainBundle] loadNibNamed:nibToLoad owner:self options:nil][0];
        cell = cellFromNib;
        self.cellFromNib = nil;
    }
    
    // Configure the cell...
    [self configureCell:cell indexPath:indexPath];
    
    return cell;
}

- (NSInteger) numberOfSections
{
    @throw @"implement in subclasses";
    return 1;
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:theTableView didSelectRowAtIndexPath:indexPath];
    
    // do something depending on the index, keep in mind footer acts differently
}


- (NSString*) headerCellNibName
{
    return @"YearHeaderView";
}


- (NSString*) footerCellNibName
{
    return @"YearHeaderView";
}

@end
