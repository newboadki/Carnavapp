//
//  ContestPhaseViewController.m
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "ContestPhaseViewController.h"
#import "CalendarScrollViewController.h"
#import "GroupDetailViewController.h"
#import "YearSelectionViewController.h"
#import "HeaderAndFooterListViewController+Protected.h"
#import "ContestPhaseDatesHelper.h"

@interface ContestPhaseViewController()
- (void) handleGroupsForDate:(NSString*) selectedDate;
@end

@implementation ContestPhaseViewController



#pragma mark - Super class extension methods

- (void) handleGroupsForDate:(NSString*) selectedDate
{
    NSArray* dateComponents = [selectedDate componentsSeparatedByString:@"/"];
    if ([dateComponents count] == 3) {
        NSString *yearOfSelectedDate = [dateComponents objectAtIndex:2];
        NSDictionary* calendarDictionaryForAllYears = self.modelData[CALENDAR_KEY];
        NSDictionary* calendarForGivenYear = calendarDictionaryForAllYears[yearOfSelectedDate];
        NSArray* groupsForDate = calendarForGivenYear[selectedDate];
        
        [self setElementsArray:groupsForDate];
        [self.tableView reloadData];
    }
}


- (void) updateArrayOfElements
{
    NSDictionary* calendarDictionaryForAllYears = self.modelData[CALENDAR_KEY];
    NSArray* calendarForGivenYear = [calendarDictionaryForAllYears[self.yearString] allKeys];

    if([calendarForGivenYear count] > 0)
    {
        NSString* selectedDate = calendarForGivenYear[0];
        [self handleGroupsForDate:selectedDate];
        
        // There's new data, reload the calendar view
        CalendarScrollViewController* cc = [[CalendarScrollViewController alloc] initWithDelegate:self
                                                                                    andYearString:self.yearString
                                                                                        modelData:self.modelData];
        [self setCalendarController:cc];
        [cc release];
        
        [self.view addSubview:self.calendarController.view];
        [self.calendarController viewDidLoad];
    }
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set the Title:
    [self setTitle:[NSString stringWithFormat:@"Concurso %@", self.yearString]]; // This is affecting the TabBar's item, why?    
    [(UITabBarItem*)[self.tabBarController.tabBar.items objectAtIndex:0] setTitle:@"Concurso"];
    
    // Create the contest's calendar
    if (!self.yearString)
    {
        self.yearString = [[ContestPhaseDatesHelper yearKeys] lastObject];
    }

    CalendarScrollViewController* cc = [[CalendarScrollViewController alloc] initWithDelegate:self andYearString:self.yearString modelData:self.modelData];
    [self setCalendarController:cc];
    [cc release];
    
    [self.view addSubview:self.calendarController.view];
    [self.calendarController viewDidLoad];
}


- (NSArray*) allDaysForContestInYear:(NSString*)year
{
    NSMutableArray* result = [NSMutableArray array];
    NSArray* daysForPreliminaresInYear = self.modelData[DAYS_FOR_PHASES_KEY][year][PRELIMINAR];
    NSArray* daysForCuartosInYear = self.modelData[DAYS_FOR_PHASES_KEY][year][CUARTOS];
    NSArray* daysForSemifinalesInYear = self.modelData[DAYS_FOR_PHASES_KEY][year][SEMIFINALES];
    NSArray* daysForFinalInYear = self.modelData[DAYS_FOR_PHASES_KEY][year][FINAL];
    
    [result addObjectsFromArray:daysForPreliminaresInYear];
    [result addObjectsFromArray:daysForCuartosInYear];
    [result addObjectsFromArray:daysForSemifinalesInYear];
    [result addObjectsFromArray:daysForFinalInYear];
    
    return result;        
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self.calendarController viewDidUnload];
    
    [self.tableView release];
    self.tableView = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.calendarController viewWillAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.calendarController viewWillDisappear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



#pragma mark - ScrollableBoxTappedDelegateProtocol

- (void) scrollableBoxTappedWith:(id)identifier
{
    NSString* date = (NSString*)identifier;
    [self handleGroupsForDate:date];    
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
    // Configure the cell...
    Agrupacion* ag = self.elementsArray[[indexpath row]];
    UILabel* groupNameLabel = (UILabel*) [cell viewWithTag:GROUP_NAME_LABEL_TAG];
    UILabel* categoryNameLabel = (UILabel*) [cell viewWithTag:CATEGORY_LABEL_TAG];
    
    if (![ag isRestingGroup])
    {
        groupNameLabel.text = ag.nombre;
        categoryNameLabel.text = [NSString stringWithFormat:@"%@ (%@)", ag.modalidad, ag.localidad];
    }
    else
    {
        groupNameLabel.text = @"-- DESCANSO --";
        categoryNameLabel.text = @"";
        [cell setUserInteractionEnabled:NO];
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
    contestResultsYearSelectorViewController.classOfTheNextViewController = [ContestPhaseViewController class];
    contestResultsYearSelectorViewController.nibNameOfTheNextViewController = @"ContestPhaseViewController";
    
    // Key-values to be set when the user selects a year in the year-selector VC
    NSDictionary *dictionaryOfValuesToSetInNewInstance = @{ @"showHeader" : @NO, @"showFooter" : @NO };
    contestResultsYearSelectorViewController.keyValuesToSetInNewInstance = dictionaryOfValuesToSetInNewInstance;
    
    // Push the year-selector VC to the stack
    [self.navigationController pushViewController:contestResultsYearSelectorViewController animated:YES];
    [contestResultsYearSelectorViewController release];
}



#pragma mark - Memory Management

- (void) dealloc
{
    [_calendarController release];
    [_phase release];
    [super dealloc];
}


@end
