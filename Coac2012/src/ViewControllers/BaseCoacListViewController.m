//
//  BaseCoacListViewController.m
//  Coac2012
//
//  Created by Borja Arias on 26/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "BaseCoacListViewController.h"
#import "Agrupacion.h"
#import "GroupDetailViewController.h"


@interface BaseCoacListViewController(protected)
- (void) updateArrayOfElements;
- (void) configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath;
@end

@implementation BaseCoacListViewController

@synthesize modelData;
@synthesize elementsArray;
@synthesize cellFromNib;
@synthesize tableView;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(handleDataIsReady:) 
                                                     name:MODEL_DATA_IS_READY_NOTIFICATION 
                                                   object:nil];
    }
    return self;
    
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MODEL_DATA_IS_READY_NOTIFICATION object:nil];
    [modelData release];
    [elementsArray release];
    [tableView release];
    [super dealloc];
}

- (void) handleDataIsReady:(NSNotification*)notif
{
    NSDictionary* data = [notif userInfo];
    [self setModelData:data];
    [self updateArrayOfElements];
}

- (void) updateArrayOfElements
{
    // Implement in subclasses. It's called when the data is ready. 
    // We need to access the data and update the array of elements
    // We should call tableView's reloadData method most likely
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
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [tableView release];
    tableView = nil;
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
    
    if (elementsArray) // we can just check for this as we set it as soon as we get the data
    {        
        numberOfRows = [elementsArray count];
    }
    
	return numberOfRows;	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}


- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        self.cellFromNib = [[[NSBundle mainBundle] loadNibNamed:@"GroupInfoCell" owner:self options:nil] objectAtIndex:0];
        cell = cellFromNib;
        self.cellFromNib = nil;    
    }
    
    // Configure the cell...
    [self configureCell:cell indexPath:indexPath];
    
    return cell;
}

@end
