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

@interface ContestPhaseViewController()
- (void) handleGroupsForDate:(NSString*) selectedDate;
@end

@implementation ContestPhaseViewController

@synthesize phase;
@synthesize calendarController;


#pragma mark - Super class extension methods

- (void) handleGroupsForDate:(NSString*) selectedDate
{
    NSDictionary* calendarDictionary = modelData[CALENDAR_KEY];
    NSArray* groupsForDate = calendarDictionary[selectedDate];
    
    [self setElementsArray:groupsForDate];
    [tableView reloadData];
}


- (void) updateArrayOfElements
{
    NSArray* daysForCurrentPhase = [ContestPhaseDatesHelper allDaysForcontest2012];
    if([daysForCurrentPhase count] > 0)
    {
        NSString* selectedDate = daysForCurrentPhase[0];
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


- (void) configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath
{
    Agrupacion* ag = elementsArray[[indexpath row]];
    UILabel* groupNameLabel = (UILabel*) [cell viewWithTag:GROUP_NAME_LABEL_TAG];
    UILabel* categoryNameLabel = (UILabel*) [cell viewWithTag:CATEGORY_LABEL_TAG];    
    
    if ([[ag identificador] intValue] != -1)
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



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set the Title:
    [self setTitle:[NSString stringWithFormat:@"Concurso %@", self.yearString]]; // This is affecting the TabBar's item, why?
    
    // Create the contest's calendar
    NSArray* daysForCurrentPhase = [ContestPhaseDatesHelper allDaysForcontest2012];
    CalendarScrollViewController* cc = [[CalendarScrollViewController alloc] initWithDates:daysForCurrentPhase andDelegate:self];        
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



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:theTableView didSelectRowAtIndexPath:indexPath];
    

    GroupDetailViewController* detailViewController = [[GroupDetailViewController alloc] initWithNibName:@"GroupDetailViewController" bundle:nil];
    detailViewController.group = elementsArray[[indexPath row]];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];    
}



#pragma mark - ScrollableBoxTappedDelegateProtocol

- (void) scrollableBoxTappedWith:(id)identifier
{
    NSString* date = (NSString*)identifier;
    [self handleGroupsForDate:date];    
}



#pragma mark - Memory Management

- (void) dealloc
{
    [calendarController release];
    [phase release];
    [super dealloc];
}


@end
