//
//  ContestResultsViewController.m
//  Coac2012
//
//  Created by Borja Arias on 22/02/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "ContestResultsViewController.h"
#import "Agrupacion.h"
#import "GroupDetailViewController.h"
#import "YearSelectionViewController.h"
#import "ContestPhaseDatesHelper.h"

@interface ContestResultsViewController(private)
- (Agrupacion*) findGroupWithId:(int)soughtId;
@end

@implementation ContestResultsViewController


#pragma mark - Parent Class extentsion methods

- (void) updateArrayOfElements
{
    if (self.yearString)
    {
        // Setting the title here, and not in viewDidLoad, because this controller is currently selected on the tabBar, view did load gerts called before the app delegate sets some of its properties (ie.yearString)
        [self setTitle:[NSString stringWithFormat:@"Resultados %@", self.yearString]]; // This is affecting the TabBar's item, why?
        
        NSArray* selectedYearResults = [ContestPhaseDatesHelper resultsDictionary][self.yearString];
        NSMutableArray* groups = [[NSMutableArray alloc] init];
        for (NSNumber* groupId in selectedYearResults)
        {
            Agrupacion *group = [self findGroupWithId:[groupId intValue]];
            if (group)
            {
                [groups addObject:[self findGroupWithId:[groupId intValue]]];
            }
        
        }
        
        [self setElementsArray:groups];
        [groups release];
        [self.tableView reloadData];        
    }
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark - Hooks to implement by subclasses of HeaderAndFooterVC class

- (NSInteger) numberOfContentSections
{
    return 4;
}


- (NSInteger) numberOfRowsContentSection:(NSInteger)contentSection
{
    return 3;
}


// section goes from 0 to numberOfSections - 1
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInContentSection:(NSInteger)section
{
    NSString* title = nil;
    
    switch (section)
    {
        case 0:
            title = @"Coros";
            break;
        case 1:
            title = @"Comparsas";
            break;
        case 2:
            title = @"Chirigotas";
            break;
        case 3:
            title = @"Cuartetos";
            break;
        default:
            title = nil;
            break;
    }
    
    return title;
}


- (void) configureContentCell:(UITableViewCell*)cell inTableView:(UITableView*)theTableView indexPath:(NSIndexPath*)indexpath
{
    int section = [indexpath section];
    int row = [indexpath row];
    int linealIndex = row + (section * 3);
    
    if ([elementsArray count] > 0)
    {
        Agrupacion* ag = elementsArray[linealIndex];
        UILabel* groupNameLabel = (UILabel*) [cell viewWithTag:GROUP_NAME_LABEL_TAG];
        UILabel* categoryNameLabel = (UILabel*) [cell viewWithTag:CATEGORY_LABEL_TAG];
        
        groupNameLabel.text = ag.nombre;
        categoryNameLabel.text = @"";        
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
    detailViewController.group = elementsArray[linealIndex];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}


- (void) handleFooterSelected
{
    // Create the year selection view controller
    YearSelectionViewController *contestResultsYearSelectorViewController = [[YearSelectionViewController alloc] initWithNibName:@"BaseCoacListViewController" bundle:nil];
    
    // Class of the new VC after the user selects a year in the year selector VC
    contestResultsYearSelectorViewController.classOfTheNextViewController = [ContestResultsViewController class];
    
    // Key-values to be set when the user selects a year in the year-selector VC
    NSDictionary *dictionaryOfValuesToSetInNewInstance = @{ @"showHeader" : @NO, @"showFooter" : @NO };
    contestResultsYearSelectorViewController.keyValuesToSetInNewInstance = dictionaryOfValuesToSetInNewInstance;
    
    // Push the year-selector VC to the stack
    [self.navigationController pushViewController:contestResultsYearSelectorViewController animated:YES];
    [contestResultsYearSelectorViewController release];
}


#pragma mark - Helpers

- (Agrupacion*) findGroupWithId:(int)soughtId
{
    NSArray* allgroups = modelData[GROUPS_KEY];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"self.identificador = %ld", soughtId];
    NSArray* results = [allgroups filteredArrayUsingPredicate:predicate];
    Agrupacion* group = nil;
    
    if ([results count] > 0)
    {
        group = results[0];        
    }
    
    return group;    
}


@end
