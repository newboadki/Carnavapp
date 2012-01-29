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
#import "AppDelegate.h"

@interface BaseCoacListViewController(protected)
- (void) updateArrayOfElements;
- (void) configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath;
@end

@implementation BaseCoacListViewController

@synthesize modelData;
@synthesize elementsArray;
@synthesize cellFromNib;
@synthesize tableView;
@synthesize loadingLabel;


#pragma mark - Initializer methods

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(handleDataIsReady:) 
                                                     name:MODEL_DATA_IS_READY_NOTIFICATION 
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(handleNoNetwork:) 
                                                     name:NO_NETWORK_NOTIFICATION 
                                                   object:nil];

    }
    return self;
    
}



#pragma mark - Memory Management

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MODEL_DATA_IS_READY_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NO_NETWORK_NOTIFICATION object:nil];
    [modelData release];
    [elementsArray release];
    [tableView release];
    [super dealloc];
}



#pragma mark - Notification handlers

- (void) handleDataIsReady:(NSNotification*)notif
{
    NSDictionary* data = [notif userInfo];
    [self setModelData:data];
    [self updateArrayOfElements];
    [loadingLabel setAlpha:0];
}

- (void) handleNoNetwork:(NSNotification*)notif
{

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
    loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    loadingLabel.center = CGPointMake(self.view.frame.size.width/2, (self.view.frame.size.height/2)-55);
    loadingLabel.text = @"Loading...";
    loadingLabel.font = [UIFont boldSystemFontOfSize:18];
    loadingLabel.backgroundColor = [UIColor clearColor];
    if (!self.modelData)
    {
        [self.view addSubview:loadingLabel];
    }
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [tableView release];
    tableView = nil;
    
    [loadingLabel release];
    loadingLabel = nil;
    
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
        self.cellFromNib = [[[NSBundle mainBundle] loadNibNamed:[self normalCellNibName] owner:self options:nil] objectAtIndex:0];
        cell = cellFromNib;
        self.cellFromNib = nil;    
    }
    
    // Configure the cell...
    [self configureCell:cell indexPath:indexPath];
    
    return cell;
}


- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [theTableView cellForRowAtIndexPath:indexPath];
    cell.selectedBackgroundView = [[[NSBundle mainBundle] loadNibNamed:[self selectedCellNibName] owner:self options:nil] objectAtIndex:0] ;
    [self configureCell:cell indexPath:indexPath]; 
    
    [UIView animateWithDuration:0.5 animations:^{
        [[[tableView cellForRowAtIndexPath:indexPath] selectedBackgroundView] setAlpha:0.0];
    } completion:^(BOOL finished) {
        
        [[tableView cellForRowAtIndexPath:indexPath] setSelectedBackgroundView:nil];
    }];
}


- (void) setMaskAsTitleView
{
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"antifaz_52x37.png"]];    
    [self.navigationItem setTitleView:imageView];
    [imageView release];
}

- (NSString*) normalCellNibName
{
    return @"GroupInfoCell";
}

- (NSString*) selectedCellNibName
{
    return @"GroupInfoCellSelected";
}

@end
