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


- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        //self.title = NSLocalizedString(@"Hoy", @"Hoy");
    }

    return self;    
}

- (void) dealloc
{

    [super dealloc];
}


- (void) updateArrayOfElements
{
    NSDate* today = [NSDate date];
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    NSString* todaysDateString = [df stringFromDate:today];
    NSLog(@"--- %@", todaysDateString);
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showAlertIfNoConstestToday];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"antifaz_52x37.png"]];
    //imageView.frame = CGRectMake(0, 0, 52, 37);
    
    self.navigationItem.titleView = imageView;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
