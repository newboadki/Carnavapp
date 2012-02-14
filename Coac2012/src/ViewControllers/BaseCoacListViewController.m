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
- (void) configureSearchResultCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath;
- (BOOL) implementsSearch;
@end

@implementation BaseCoacListViewController

@synthesize modelData;
@synthesize elementsArray;
@synthesize cellFromNib;
@synthesize tableView;
@synthesize searchResultsTableViewController;

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
        firstTimeViewWillAppear = YES;
    }
    
    return self;    
}



#pragma mark - Memory Management

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MODEL_DATA_IS_READY_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NO_NETWORK_NOTIFICATION object:nil];
    [groupNameSearchController release];
    [modelData release];
    [elementsArray release];
    [tableView release];
    searchResultsTableViewController.selectionDelegate = nil;
    [searchResultsTableViewController release];
    [super dealloc];
}



#pragma mark - Notification handlers

- (void) handleDataIsReady:(NSNotification*)notif
{
    NSDictionary* data = [notif userInfo];
    [self setModelData:data];
    [self updateArrayOfElements];
    [self.searchResultsTableViewController setModelData:self.modelData];
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
    searchResultsTableViewController.selectionDelegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [tableView release];
    tableView = nil;    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Do geometry related customization here, rather than in view did load. Navigation bars and other elements resizing have already happened by now, but not before
    if (![self implementsSearch] && firstTimeViewWillAppear)
    {
        [self setSearchResultsTableViewController:nil];
        [[self tableView] setContentOffset:CGPointMake(0, self.searchDisplayController.searchBar.frame.size.height)];
        [[self tableView] setContentInset:UIEdgeInsetsMake(-self.searchDisplayController.searchBar.frame.size.height, 0, 0, 0)];
        float newHeight = self.tableView.contentSize.height - self.searchDisplayController.searchBar.frame.size.height;
        [[self tableView] setContentSize:CGSizeMake(self.tableView.contentSize.width, newHeight)];
        self.searchDisplayController.searchBar.hidden = YES;
    }
    firstTimeViewWillAppear = NO;
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


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
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


- (BOOL) implementsSearch
{
    return NO;
}



#pragma mark - UISearchDisplayController

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSLog(@"YEAH");
    return YES;
}


#pragma mark - UISearchBarDelegateProtocol

- (GroupNameSearchController*) groupNameSearchController
{
    if (![self implementsSearch])
    {
        return nil;
    }
    else
    {
        if (!groupNameSearchController)
        {
            groupNameSearchController = [[GroupNameSearchController alloc] initWithSampleArrayinSampleArray:nil andDelegate:self];
        }
        
        return groupNameSearchController;
    }
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    GroupNameSearchController* sc = [self groupNameSearchController];
    sc.sampleArray = elementsArray;
    [sc searchResultsForString:searchText];
}


- (void) resultsAreReadyInDictionary:(NSDictionary*)resultsDictionary
{
    NSArray* results = [resultsDictionary objectForKey:SEARCH_RESULTS_KEY];
    [[self searchResultsTableViewController] setResults:results];
    [self.searchDisplayController.searchResultsTableView reloadData];
}



#pragma mark - SearchResultsTableViewControllerDelegateProtocol

- (void)selectedElement:(id)element
{    
    Agrupacion* selectedGroup = (Agrupacion*)element;
    int index = [elementsArray indexOfObject:selectedGroup];

    if (index >= 0)
    {
        NSIndexPath* ip = [NSIndexPath indexPathForRow:index inSection:0];
        [self tableView:self.tableView didSelectRowAtIndexPath:ip];
    }    
}




@end
