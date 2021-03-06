//
//  GroupsForModalityViewController.m
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "GroupsForModalityViewController.h"
#import "Agrupacion.h"
#import "GroupDetailViewController.h"
#import "YearSelectionViewController.h"
#import "HeaderAndFooterListViewController+Protected.h"



@implementation GroupsForModalityViewController



#pragma mark - Parent class extension methods

- (void) updateArrayOfElements
{
    NSDictionary* modalitiesDic = self.modelData[MODALITIES_KEY];
    NSDictionary* modalityGroupsForAllYears = modalitiesDic[self.modality]; // that is from that modality from all years
    NSArray* moddalityGroupsInYear = modalityGroupsForAllYears[self.yearString];    
    // now we should re-filter, selecting just the current year
    
    moddalityGroupsInYear = [moddalityGroupsInYear sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        Agrupacion* a1 = (Agrupacion*)obj1;
        Agrupacion* a2 = (Agrupacion*)obj2;
        
        return [a1.nombre compare:a2.nombre];
    }];
    
    [self setElementsArray:moddalityGroupsInYear];
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up title
    [self setTitle:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(self.modality, self.modality), self.yearString]]; // This is affecting the TabBar's item, why?

}



#pragma mark - Table view delegate

- (BOOL) implementsSearch
{
    return YES;
}



#pragma mark - Hooks to implement by subclasses of HeaderAndFooterVC class

- (NSInteger) numberOfContentSections
{
    return 1;
}


- (NSInteger) numberOfRowsContentSection:(NSInteger)contentSection
{
    return [self.elementsArray count];
}


- (void) configureContentCell:(UITableViewCell*)cell inTableView:(UITableView*)theTableView indexPath:(NSIndexPath*)indexpath
{
    [super configureContentCell:cell inTableView:theTableView indexPath:indexpath];
    // Configure the cell...
    Agrupacion* ag = self.elementsArray[[indexpath row]];
    UILabel* groupNameLabel = (UILabel*) [cell viewWithTag:GROUP_NAME_LABEL_TAG];
    UILabel* categoryNameLabel = (UILabel*) [cell viewWithTag:CATEGORY_LABEL_TAG];
    
    if (![ag isRestingGroup])
    {
        groupNameLabel.text = ag.nombre;
        categoryNameLabel.text = [NSString stringWithFormat:@"%@ (%@)", ag.modalidad, ag.localidad];
    }
}


/**
 @param contentSectionIndexPath this takes values from 0 to numberOfContentSections-1
 */
- (void) tableView:(UITableView *)theTableView didSelectContentRowAtIndexPath:(NSIndexPath *)contentSectionIndexPath
{
    int section = [contentSectionIndexPath section];
    int row = [contentSectionIndexPath row];
    int linealIndex = row + (section * 3);
    
    GroupDetailViewController* detailViewController = [[GroupDetailViewController alloc] initWithNibName:@"GroupDetailViewController" bundle:nil];
    detailViewController.group = self.elementsArray[linealIndex];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}


- (void) handleFooterSelected:(UITableViewCell*)footerCell
{
    [super handleFooterSelected:footerCell];
    
    // Create the year selection view controller
    YearSelectionViewController *contestResultsYearSelectorViewController = [[YearSelectionViewController alloc] initWithNibName:@"BaseCoacListViewController" bundle:nil];
    
    // Class of the new VC after the user selects a year in the year selector VC
    contestResultsYearSelectorViewController.classOfTheNextViewController = [GroupsForModalityViewController class];
    contestResultsYearSelectorViewController.nibNameOfTheNextViewController = @"BaseCoacListViewController";
    
    // Key-values to be set when the user selects a year in the year-selector VC
    NSDictionary *dictionaryOfValuesToSetInNewInstance = @{ @"showHeader" : @NO, @"showFooter" : @NO, @"modality" : self.modality };
    contestResultsYearSelectorViewController.keyValuesToSetInNewInstance = dictionaryOfValuesToSetInNewInstance;
    
    // Push the year-selector VC to the stack
    [self.navigationController pushViewController:contestResultsYearSelectorViewController animated:YES];
    [contestResultsYearSelectorViewController release];
}

#pragma mark - Memory Management

- (void) dealloc
{
    [_modality release];
    [super dealloc];    
}


@end
