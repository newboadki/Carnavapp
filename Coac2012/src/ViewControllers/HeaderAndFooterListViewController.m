//
//  HeaderAndFooterListViewController.m
//  Coac2012
//
//  Created by Borja Arias Drake on 25/11/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "HeaderAndFooterListViewController.h"

#define HEADER_SECTION_INDEX 0
#define FOOTER_SECTION_INDEX ([self numberOfSectionsInTableView:self.tableView] - 1)

@interface HeaderAndFooterListViewController ()

@end

@implementation HeaderAndFooterListViewController

@synthesize yearString;
@synthesize showHeader = _showHeader, showFooter = _showFooter;

- (void) dealloc
{
    [yearString release];
    [super dealloc];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        _showHeader = NO;
        _showFooter = YES;
    }
    
    return self;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // This class assumes there are 3 sections: HEADER, CONTENT, FOOTER
    // If a subclass wants to have more sentions in the content section, it can override this method, but it will have
    // to take into account the superclass'es expectations.
    
    NSInteger numberOfSections = 0;
    if (self.showHeader)
    {
        numberOfSections++;
    }

    if (self.showFooter)
    {
        numberOfSections++;
    }

    return numberOfSections + [self numberOfContentSections];
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ((section == HEADER_SECTION_INDEX) && self.showHeader)
    {        
        return 1;
    }
    else if ((section == FOOTER_SECTION_INDEX) && self.showFooter)
    {
        return 1;
    }
    else
    {
        NSInteger contentSectionIndex = section;
        if (self.showHeader)
        {
            contentSectionIndex = section - 1;
        }

        return [self numberOfRowsContentSection:contentSectionIndex];
    }
}


- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *NormalCellIdentifier = @"NormalCell";
    static NSString *HeaderCellIdentifier = @"HeaderCell";
    static NSString *FooterCellIdentifier = @"FooterCell";
    NSString * cellIdentifier = @"NormalCell";
    NSString* nibToLoad = [self normalCellNibName];
        
    if ((indexPath.section == HEADER_SECTION_INDEX) && self.showHeader)
    {
        nibToLoad = [self headerCellNibName];
        cellIdentifier = HeaderCellIdentifier;
    }
    else if ((indexPath.section == FOOTER_SECTION_INDEX) && self.showFooter)
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


- (void) configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexPath
{
    if ((indexPath.section == HEADER_SECTION_INDEX) && self.showHeader)
    {        
        [self configureHeaderCell:cell inTableView:(UITableView*)self.tableView];
    }
    else if ((indexPath.section == FOOTER_SECTION_INDEX) && self.showFooter)
    {
        [self configureFooterCell:cell inTableView:(UITableView*)self.tableView];
    }
    else
    {
        NSIndexPath *contentSectionsIndexPath = indexPath;
        if (self.showHeader)
        {
            contentSectionsIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section-1];
        }
        [self configureContentCell:cell inTableView:(UITableView*)self.tableView indexPath:contentSectionsIndexPath];
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInContentSection:(NSInteger)section
{
    // implement in subclasses
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    NSInteger contentSection = section;
    
    if ((section == HEADER_SECTION_INDEX) && self.showHeader)
    {
        return nil;
    }
    else if ((section == FOOTER_SECTION_INDEX) && self.showFooter)
    {
        return nil;
    }
    else
    {
        // transform the indexPath to a content-section-only indexpath
        if (self.showHeader)
        {
            contentSection = section - 1;
        }
        return [self tableView:self.tableView titleForHeaderInContentSection:contentSection];
    }
}


- (void) tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    if ((indexPath.section == HEADER_SECTION_INDEX) && self.showHeader)
    {        
        [self handleHeaderSelected];
    }
    else if ((indexPath.section == FOOTER_SECTION_INDEX) && self.showFooter)
    {
        [self handleFooterSelected];
    }
    else
    {
        // transform the indexPath to a content-section-only indexpath
        NSIndexPath *contentIndexPath = indexPath;
        if (self.showHeader) {
            contentIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section-1];
        }
        [super tableView:theTableView didSelectRowAtIndexPath:contentIndexPath];
        [self tableView:(UITableView *)theTableView didSelectContentRowAtIndexPath:contentIndexPath];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.section == FOOTER_SECTION_INDEX) && self.showFooter)
    {
        return 44;
    }
    else if ((indexPath.section == FOOTER_SECTION_INDEX) && self.showFooter)
    {
        return 44;
    }
    else
    {
        return 60.0f;
    }
}



#pragma mark - Header & Footer subclass hooks

/* Configure Cells */

- (void) configureHeaderCell:(UITableViewCell*)cell inTableView:(UITableView*)theTableView
{
    // Implement in subclasses
}


- (void) configureFooterCell:(UITableViewCell*)cell inTableView:(UITableView*)theTableView
{
    // Implement in subclasses
}


- (void) configureContentCell:(UITableViewCell*)cell inTableView:(UITableView*)theTableView indexPath:(NSIndexPath*)indexpath
{
    // Implement in subclasses
}


/* Content Delegate */

- (void) handleHeaderSelected
{
    // Implement in subclasses
}


- (void) handleFooterSelected
{
    //implement in subclases
}


- (void) tableView:(UITableView *)theTableView didSelectContentRowAtIndexPath:(NSIndexPath *)indexPath
{
    // implement in subclasses
}



/* Content Data Source */

- (NSInteger) numberOfContentSections
{
    @throw @"implement in subclasses";
}


- (NSInteger) numberOfRowsContentSection:(NSInteger)contentSection
{
    @throw @"implement in subclasses";
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
