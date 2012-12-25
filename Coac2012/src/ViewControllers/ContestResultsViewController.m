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
#import "HeaderAndFooterListViewController+Protected.h"
#import "Result.h"

@interface ContestResultsViewController(private)
- (Agrupacion*) findGroupWithId:(int)soughtId inYear:(NSString*)yearString;
@end

@implementation ContestResultsViewController


#pragma mark - Parent Class extentsion methods

- (void) updateArrayOfElements
{
    if (self.yearString)
    {
        // Setting the title here, and not in viewDidLoad, because this controller is currently selected on the tabBar, view did load gerts called before the app delegate sets some of its properties (ie.yearString)
        [self setTitle:[NSString stringWithFormat:@"Resultados %@", self.yearString]]; // This is affecting the TabBar's item, why?
        [(UITabBarItem*)[self.tabBarController.tabBar.items objectAtIndex:2] setTitle:@"Resultados"];
        
        NSArray* selectedYearResults = self.modelData[RESULTS_KEY][self.yearString];
        NSMutableArray* groups = [[NSMutableArray alloc] init];
        
        
        NSPredicate *finalGroupsPredicate = [NSPredicate predicateWithFormat:@"self.phase LIKE 'FINAL'"];
        NSArray *finalGroups = [selectedYearResults filteredArrayUsingPredicate:finalGroupsPredicate];

        NSPredicate* corosResultsPredicate = [NSPredicate predicateWithFormat:@"self.modality LIKE 'CORO'"];
        NSPredicate* comparsasResultsPredicate = [NSPredicate predicateWithFormat:@"self.modality LIKE 'COMPARSA'"];
        NSPredicate* chirigotasResultsPredicate = [NSPredicate predicateWithFormat:@"self.modality LIKE 'CHIRIGOTA'"];
        NSPredicate* cuartetosResultsPredicate = [NSPredicate predicateWithFormat:@"self.modality LIKE 'CUARTETO'"];
        
        NSArray *coros = [finalGroups filteredArrayUsingPredicate:corosResultsPredicate];
        NSArray *comparsas = [finalGroups filteredArrayUsingPredicate:comparsasResultsPredicate];
        NSArray *chirigotas = [finalGroups filteredArrayUsingPredicate:chirigotasResultsPredicate];
        NSArray *cuartetos = [finalGroups filteredArrayUsingPredicate:cuartetosResultsPredicate];
        
        
        NSComparisonResult (^comparatorBlock) (id obj1, id obj2) = ^NSComparisonResult(id obj1, id obj2) {
            Result* r1 = (Result*)obj1;
            Result* r2 = (Result*)obj2;            
            return [r1.points compare:r2.points];
        };
        
        NSArray *orderedCoros = [coros sortedArrayUsingComparator:comparatorBlock];
        NSArray *orderedComparsas = [comparsas sortedArrayUsingComparator:comparatorBlock];
        NSArray *orderedChirigotas = [chirigotas sortedArrayUsingComparator:comparatorBlock];
        NSArray *orderedCuartetos = [cuartetos sortedArrayUsingComparator:comparatorBlock];
        
        
        for (Result* res in orderedCoros)
        {
            Agrupacion* ag = [self findGroupWithId:[res.groupId intValue] inYear:self.yearString];
            if (ag)
            {
                [groups addObject:ag];
            }
        }

        for (Result* res in orderedComparsas)
        {
            Agrupacion* ag = [self findGroupWithId:[res.groupId intValue] inYear:self.yearString];
            if (ag)
            {
                [groups addObject:ag];
            }
        }

        for (Result* res in orderedChirigotas)
        {
            Agrupacion* ag = [self findGroupWithId:[res.groupId intValue] inYear:self.yearString];
            if (ag)
            {
                [groups addObject:ag];
            }
        }

        for (Result* res in orderedCuartetos)
        {
            Agrupacion* ag = [self findGroupWithId:[res.groupId intValue] inYear:self.yearString];
            if (ag)
            {
                [groups addObject:ag];
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
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData]; // This is a hack. By doing this, the tableview's delegate methods get called and we can again recalculate the height of the rows depending on whether there's data in the elements array or not.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark - Hooks to implement by subclasses of HeaderAndFooterVC class

- (NSInteger) numberOfContentSections
{
    if ([self.elementsArray count] > 0)
    {
        return 4;
    }
    else
    {
        self.noContentMessageLabel.text = @"Aún no hay resultados";
        return 1;
    }
}


- (NSInteger) numberOfRowsContentSection:(NSInteger)contentSection
{
    if ([self.elementsArray count] > 0) {
        return 3;
    } else {
        return 1;
    }
}


// section goes from 0 to numberOfSections - 1
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInContentSection:(NSInteger)section
{
    NSString* title = nil;
    
    if ([self.elementsArray count] == 0) {
        return nil;
    }
    
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


- (CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.elementsArray count] > 0) {
        return [super tableView:_tableView heightForRowAtIndexPath:indexPath];
    }
    else if (indexPath.row == 0 && indexPath.section ==0){
        NSLog(@"%@", NSStringFromCGRect(_tableView.frame));
        return _tableView.frame.size.height - 44;
    } else {
        return 44;
    }

}



- (void) configureContentCell:(UITableViewCell*)cell inTableView:(UITableView*)theTableView indexPath:(NSIndexPath*)indexpath
{
    int section = [indexpath section];
    int row = [indexpath row];
    int linealIndex = row + (section * 3);

    UILabel* groupNameLabel = (UILabel*) [cell viewWithTag:GROUP_NAME_LABEL_TAG];
    UILabel* categoryNameLabel = (UILabel*) [cell viewWithTag:CATEGORY_LABEL_TAG];

    if ([self.elementsArray count] > 0)
    {
        Agrupacion* ag = self.elementsArray[linealIndex];
        groupNameLabel.text = ag.nombre;
        categoryNameLabel.text = @"";
        cell.userInteractionEnabled = YES;
    }
    else
    {
        // To override what's on the nib file, which I want to be descriptive
        groupNameLabel.text = @"";
        categoryNameLabel.text = @"";
        cell.userInteractionEnabled = NO;
    }

}


- (void) configureFooterCell:(UITableViewCell*)cell inTableView:(UITableView*)theTableView
{
    [super configureFooterCell:cell inTableView:theTableView];
    UILabel *footerLabel = (UILabel*)[cell viewWithTag:1];
    footerLabel.text = @"Ver años anteriores";
}


/**
 @param contentSectionIndexPath this takes values from 0 to numberOfContentSections-1
 */
- (void) tableView:(UITableView *)theTableView didSelectContentRowAtIndexPath:(NSIndexPath *)contentSectionIndexPath
{
    int section = [contentSectionIndexPath section];
    int row = [contentSectionIndexPath row];
    int linealIndex = row + (section * 3);

    int count = [[self elementsArray] count];
    if (count > 0 && linealIndex >=0 && linealIndex<count)
    {
        GroupDetailViewController* detailViewController = [[GroupDetailViewController alloc] initWithNibName:@"GroupDetailViewController" bundle:nil];
        detailViewController.group = self.elementsArray[linealIndex];
        [self.navigationController pushViewController:detailViewController animated:YES];
        [detailViewController release];
    }
}


- (void) handleFooterSelected:(UITableViewCell*)footerCell
{
    [super handleFooterSelected:footerCell];
    
    // Create the year selection view controller
    YearSelectionViewController *contestResultsYearSelectorViewController = [[YearSelectionViewController alloc] initWithNibName:@"BaseCoacListViewController" bundle:nil];
    
    // Class of the new VC after the user selects a year in the year selector VC
    contestResultsYearSelectorViewController.classOfTheNextViewController = [ContestResultsViewController class];
    contestResultsYearSelectorViewController.nibNameOfTheNextViewController = @"BaseCoacListViewController";
    
    // Key-values to be set when the user selects a year in the year-selector VC
    NSDictionary *dictionaryOfValuesToSetInNewInstance = @{ @"showHeader" : @NO, @"showFooter" : @NO };
    contestResultsYearSelectorViewController.keyValuesToSetInNewInstance = dictionaryOfValuesToSetInNewInstance;
    
    // Push the year-selector VC to the stack
    [self.navigationController pushViewController:contestResultsYearSelectorViewController animated:YES];
    [contestResultsYearSelectorViewController release];
}


#pragma mark - Helpers

- (Agrupacion*) findGroupWithId:(int)soughtId inYear:(NSString*)yearString
{
    NSDictionary* allgroupsForAllYears = self.modelData[GROUPS_KEY];
    NSArray* allGroupsForYear = allgroupsForAllYears[yearString];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"self.identificador = %ld", soughtId];
    NSArray* results = [allGroupsForYear filteredArrayUsingPredicate:predicate];
    Agrupacion* group = nil;
    
    if ([results count] > 0)
    {
        group = results[0];        
    }
    
    return group;    
}


@end
