//
//  FirstViewController.m
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "TodayViewController.h"
#import "Agrupacion.h"
#import "GroupDetailViewController.h"
#import "BaseCoacListViewController+Protected.h"

@interface TodayViewController(protected)
- (void) showAlertIfNoConstestToday;
- (NSString*) todaysDateString;
@end

@implementation TodayViewController



#pragma mark - Parent Class extentsion methods

- (void) updateArrayOfElements
{
    NSString* todaysDateString = [self todaysDateString];
    NSDictionary* calendarDictionary = [self.modelData objectForKey:CALENDAR_KEY];
    NSArray* groupsForDate = [calendarDictionary objectForKey:todaysDateString];
    [self setElementsArray:groupsForDate];
    [self.tableView reloadData];
    
    [self showAlertIfNoConstestToday];
}


- (void) configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath
{
    Agrupacion* ag = [self.elementsArray objectAtIndex:[indexpath row]];
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



#pragma mark - Helper Methods

- (void) showAlertIfNoConstestToday
{
    if (modelData && ([self.elementsArray count] == 0))
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Informacion" message:@"Hoy no hay concurso" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }    
}


- (NSString*) todaysDateString
{
    NSDate* today = [NSDate date];
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    NSString* todaysDateString = [df stringFromDate:today];
    [df release];

    return todaysDateString;
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showAlertIfNoConstestToday];
    [self setMaskAsTitleView];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.elementsArray count] <= 0)
    {
        self.noContentMessageView.hidden = NO;
        self.noContentMessageLabel.hidden = NO;
        self.noContentMessageLabel.text = @"Hoy no hay concurso";
    }
    else
    {
        noContentMessageView.hidden = YES;
        self.noContentMessageLabel.hidden = YES;
    }
}



#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self todaysDateString];
}


- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:theTableView didSelectRowAtIndexPath:indexPath];
    
    GroupDetailViewController* detailViewController = [[GroupDetailViewController alloc] initWithNibName:@"GroupDetailViewController" bundle:nil];
    detailViewController.group = [elementsArray objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];    
}


@end
