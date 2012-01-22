//
//  SecondViewController.m
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "ModalitiesViewController.h"
#import "GroupsForModalityViewController.h"

@interface ModalitiesViewController()
@property (nonatomic, retain) NSArray* orderedModalityKeys;
@end

@implementation ModalitiesViewController

@synthesize modelData;
@synthesize orderedModalityKeys;


- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDataIsReady:) name:MODEL_DATA_IS_READY_NOTIFICATION object:nil];
    }
    
    return self;
}
					
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MODEL_DATA_IS_READY_NOTIFICATION object:nil];
    [modelData release];
    [orderedModalityKeys release];
    [super dealloc];    
}

- (void) handleDataIsReady:(NSNotification*)notif
{
    // Get the data
    NSDictionary* data = [notif userInfo];
    [self setModelData:data];
    NSDictionary* modalitiesDic = [modelData objectForKey:MODALITIES_KEY];
    NSArray* mk = [modalitiesDic allKeys];
    
    // Order an assign the relevant parts of information for this class
    mk = [mk sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString* s1 = (NSString*)obj1;
        NSString* s2 = (NSString*)obj2;
        return [s1 compare:s2];
    }];
    
    [self setOrderedModalityKeys:mk];
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
    self.title = NSLocalizedString(@"Modalidades", @"Modalidades");
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	/***********************************************************************************************/
	/* numberOfSectionsInTableView.																   */
	/***********************************************************************************************/    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	/***********************************************************************************************/
	/* numberOfRowsInSection.																	   */
	/***********************************************************************************************/							
    int numberOfRows = 0;
    
    if (orderedModalityKeys)
    {        
        numberOfRows = [orderedModalityKeys count];
    }
    	
	return numberOfRows;	
}


- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
	/***********************************************************************************************/
	/* cellForRowAtIndexPath.																	   */
	/***********************************************************************************************/							
    static NSString* CellIdentifier = @"Cell";
    
    UITableViewCell* cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{		
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell..
    NSString* currentModality = [orderedModalityKeys objectAtIndex:[indexPath row]];    
    cell.textLabel.text = currentModality;
	
    return cell;
}




#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	/***********************************************************************************************/
	/* didSelectRowAtIndexPath.																	   */
	/***********************************************************************************************/
    NSString* selectedModality = [orderedModalityKeys objectAtIndex:[indexPath row]];
    GroupsForModalityViewController* nextController = [[GroupsForModalityViewController alloc] initWithNibName:@"GroupsForModalityViewController" bundle:nil];
    [nextController setModality:selectedModality];
    [nextController setModelData:self.modelData];
    
    [[self navigationController] pushViewController:nextController animated:YES];
    [nextController release];
}
@end
