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

@interface TodayViewController()
- (void) handleGroupsForToday;
- (void) showAlertIfNoConstestToday;
@end

@implementation TodayViewController

@synthesize modelData;
@synthesize groupsForToday;


- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.title = NSLocalizedString(@"Hoy", @"Hoy");
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDataIsReady:) name:MODEL_DATA_IS_READY_NOTIFICATION object:nil];
    }
    return self;
    
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MODEL_DATA_IS_READY_NOTIFICATION object:nil];
    [modelData release];
    [groupsForToday release];
    [super dealloc];
}

- (void) handleDataIsReady:(NSNotification*)notif
{
    NSDictionary* data = [notif userInfo];
    [self setModelData:data];
    [self handleGroupsForToday];
}

- (void) handleGroupsForToday
{
    NSDate* today = [NSDate date];
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    NSString* todaysDateString = [df stringFromDate:today];
    NSLog(@"--- %@", todaysDateString);
    [df release];
    
    NSDictionary* calendarDictionary = [modelData objectForKey:CALENDAR_KEY];    
    NSArray* groupsForDate = [calendarDictionary objectForKey:todaysDateString];
    [self setGroupsForToday:groupsForDate];
    [self.tableView reloadData];
    
    [self showAlertIfNoConstestToday];
}


- (void) showAlertIfNoConstestToday
{
    if (modelData && ([groupsForToday count] == 0))
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numberOfRows = 0;
    
    if (groupsForToday) // we can just check for this as we set it as soon as we get the data
    {        
        numberOfRows = [groupsForToday count];
    }
    
	return numberOfRows;	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    Agrupacion* ag = [groupsForToday objectAtIndex:[indexPath row]];
    cell.textLabel.text = ag.nombre;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupDetailViewController* detailViewController = [[GroupDetailViewController alloc] initWithNibName:@"GroupDetailViewController" bundle:nil];
    detailViewController.group = [groupsForToday objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];    
}


@end
