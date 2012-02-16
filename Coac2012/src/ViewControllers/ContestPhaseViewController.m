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

@interface ContestPhaseViewController()
- (void) handleGroupsForDate:(NSString*) selectedDate;
- (NSArray*) daysForPhase:(NSString*) phase;
@end

@implementation ContestPhaseViewController

@synthesize phase;
@synthesize calendarController;


#pragma mark - Super class extension methods

- (void) handleGroupsForDate:(NSString*) selectedDate
{
    NSDictionary* calendarDictionary = [modelData objectForKey:CALENDAR_KEY];
    NSArray* groupsForDate = [calendarDictionary objectForKey:selectedDate];
    
    [self setElementsArray:groupsForDate];
    [tableView reloadData];
}


- (void) updateArrayOfElements
{
    NSArray* daysForCurrentPhase = [self daysForPhase:self.phase];
    if([daysForCurrentPhase count] > 0)
    {
        NSString* selectedDate = [daysForCurrentPhase objectAtIndex:0];
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
    Agrupacion* ag = [elementsArray objectAtIndex:[indexpath row]];
    UILabel* groupNameLabel = (UILabel*) [cell viewWithTag:GROUP_NAME_LABEL_TAG];
    UILabel* categoryNameLabel = (UILabel*) [cell viewWithTag:CATEGORY_LABEL_TAG];    
    
    if ([ag identificador] != -1)
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
    self.title = phase;
    
    // Create here
    NSArray* daysForCurrentPhase = [self daysForPhase:self.phase];
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
    detailViewController.group = [elementsArray objectAtIndex:[indexPath row]];
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



#pragma mark - Helper methods

- (NSArray*) daysForPhase:(NSString*) currentPhase
{
    NSArray* diasPreliminar = [NSArray arrayWithObjects:@"21/01/2012",
                                                        @"22/01/2012",
                                                        @"23/01/2012",
                                                        @"24/01/2012",
                                                        @"25/01/2012",
                                                        @"26/01/2012",
                                                        @"27/01/2012",
                                                        @"28/01/2012",
                                                        @"29/01/2012",
                                                        @"30/01/2012",
                                                        @"31/01/2012",
                                                        @"01/02/2012",
                                                        @"02/02/2012",
                                                        @"03/02/2012",
                                                        @"04/02/2012",
                                                        nil];
    
    NSArray* diasCuartos = [NSArray arrayWithObjects:@"06/02/2012", 
                                                     @"07/02/2012", 
                                                     @"08/02/2012", 
                                                     @"09/02/2012",
                                                     @"10/02/2012",
                                                     @"11/02/2012", 
                                                     nil];
    
    NSArray* diasSemifinales = [NSArray arrayWithObjects:@"13/02/2012", 
                                                         @"14/02/2012",
                                                         @"15/02/2012",
                                                         nil];
    
    NSArray* diasFinal = [NSArray arrayWithObjects:@"17/02/2012", nil];
    
    NSDictionary* daysForPhases = [[[NSDictionary alloc] initWithObjectsAndKeys:diasPreliminar, PRELIMINAR, 
                                                                               diasCuartos, CUARTOS, 
                                                                               diasSemifinales, SEMIFINALES, 
                                                                               diasFinal, FINAL,
                                                                               nil] autorelease];
    
    return [daysForPhases objectForKey:currentPhase];
}

@end
