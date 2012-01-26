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

@interface TodayViewController(protected)
- (void) showAlertIfNoConstestToday;
@end

@implementation TodayViewController


- (void) updateArrayOfElements
{
    NSDate* today = [NSDate date];
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    NSString* todaysDateString = [df stringFromDate:today];
    [df release];
    
    NSDictionary* calendarDictionary = [modelData objectForKey:CALENDAR_KEY];    
    NSArray* groupsForDate = [calendarDictionary objectForKey:todaysDateString];
    [self setElementsArray:groupsForDate];
    [self.tableView reloadData];
    
    [self showAlertIfNoConstestToday];
}


- (void) showAlertIfNoConstestToday
{
    if (modelData && ([elementsArray count] == 0))
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Informacion" message:@"Hoy no hay concurso" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showAlertIfNoConstestToday];
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"antifaz_52x37.png"]];    
    self.navigationItem.titleView = imageView;
}



#pragma mark - Table view data source

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
        groupNameLabel.text = @"DESCANSO";
        categoryNameLabel.text = @"";
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupDetailViewController* detailViewController = [[GroupDetailViewController alloc] initWithNibName:@"GroupDetailViewController" bundle:nil];
    detailViewController.group = [elementsArray objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];    
}


@end
