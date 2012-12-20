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
#import "ContestPhaseDatesHelper.h"
#import "YearSelectionViewController.h"

@interface ContestPhaseViewController()
- (void) handleGroupsForDate:(NSString*) selectedDate;
@end

@implementation ContestPhaseViewController

@synthesize phase;
@synthesize calendarController;


#pragma mark - Super class extension methods

- (void) handleGroupsForDate:(NSString*) selectedDate
{
    NSArray* dateComponents = [selectedDate componentsSeparatedByString:@"/"];
    if ([dateComponents count] == 3) {
        NSString *yearOfSelectedDate = [dateComponents objectAtIndex:2];
        NSDictionary* calendarDictionaryForAllYears = modelData[CALENDAR_KEY];
        NSDictionary* calendarForGivenYear = calendarDictionaryForAllYears[yearOfSelectedDate];
        NSArray* groupsForDate = calendarForGivenYear[selectedDate];
        
        [self setElementsArray:groupsForDate];
        [tableView reloadData];
    }
}


- (void) updateArrayOfElements
{
    NSArray* daysForContestInCurrentYear = [ContestPhaseDatesHelper allDaysForContestInYear:self.yearString];
    if([daysForContestInCurrentYear count] > 0)
    {
        NSString* selectedDate = daysForContestInCurrentYear[0];
        [self handleGroupsForDate:selectedDate];
    }
}


- (void) setModelData:(NSDictionary *)theModelData
{

    if (self->modelData != theModelData)
    {
        [theModelData retain];
        [self->modelData release];
        self->modelData = theModelData;

        [self updateArrayOfElements];
    }
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set the Title:
    [self setTitle:[NSString stringWithFormat:@"Concurso %@", self.yearString]]; // This is affecting the TabBar's item, why?
    
    // Create the contest's calendar
    NSArray* daysForContestInYear = [ContestPhaseDatesHelper allDaysForContestInYear:self.yearString];
    CalendarScrollViewController* cc = [[CalendarScrollViewController alloc] initWithDates:daysForContestInYear andDelegate:self andYearString:self.yearString];
    [self setCalendarController:cc];
    [cc release];
    
    [self.view addSubview:calendarController.view];
    [calendarController viewDidLoad];    
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
    [calendarController viewDidUnload];
    
    [tableView release];
    tableView = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [calendarController viewWillAppear:animated];
    
    if ([self.elementsArray count] > 0)
    {
        self.noContentMessageLabel.hidden = YES;
        
    }
    else
    {
        self.noContentMessageLabel.hidden = NO;
    }

}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [calendarController viewWillDisappear:animated];
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
    Agrupacion* ag = elementsArray[[indexpath row]];
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
    detailViewController.group = elementsArray[linealIndex];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}


- (void) handleFooterSelected
{
    // Create the year selection view controller
    YearSelectionViewController *contestResultsYearSelectorViewController = [[YearSelectionViewController alloc] initWithNibName:@"BaseCoacListViewController" bundle:nil];
    
    // Class of the new VC after the user selects a year in the year selector VC
    contestResultsYearSelectorViewController.classOfTheNextViewController = [ContestPhaseViewController class];
    
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
    [calendarController release];
    [phase release];
    [super dealloc];
}


@end
