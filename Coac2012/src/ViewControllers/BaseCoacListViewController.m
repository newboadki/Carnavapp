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
#import <CoreImage/CoreImage.h>
#import "BackgroundImageManager.h"
#import <QuartzCore/QuartzCore.h>
#import "BaseCoacListViewController+Protected.h"
#import "ContestPhaseDatesHelper.h"

@implementation BaseCoacListViewController



#pragma mark - Initializer methods

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Subscribe to notifications
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(handleDataIsReady:)
                                                     name: MODEL_DATA_IS_READY_NOTIFICATION
                                                   object: nil];
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(handleBackgroundImageFinishedProcessing)
                                                     name: BACKGROUND_IMAGE_FINISHED_PROCESSING
                                                   object: nil];
        
        // Default the year to the last one. There are circumstances where we can not set it before the view did load.
        self.yearString = [[[[ContestPhaseDatesHelper yearKeys] lastObject] copy] autorelease];
    }
    
    return self;    
}



#pragma mark - Memory Management

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MODEL_DATA_IS_READY_NOTIFICATION object:nil];
    [_groupNameSearchController release];
    [_modelData release];
    [_elementsArray release];
    [_tableView release];
    _searchResultsTableViewController.selectionDelegate = nil;
    [_searchResultsTableViewController release];
    [_noContentMessageLabel release];
    [_noContentMessageView release];
    [_backgroundImageView release];
    [_yearString release];
    [super dealloc];
}



#pragma mark - Notification handlers

- (void) handleDataIsReady:(NSNotification*)notif
{
    NSDictionary* data = [notif userInfo];
    [self setModelData:data];
    [self.searchResultsTableViewController setModelData:self.modelData];
}


- (void) updateArrayOfElements
{
    // Implement in subclasses. It's called when the data is ready. 
    // We need to access the data and update the array of elements
    // We should call tableView's reloadData method most likely
}


- (void) setModelData:(NSDictionary *)theModelData
{
    
    if (_modelData != theModelData)
    {
        [theModelData retain];
        [_modelData release];
        _modelData = theModelData;
        
        [self updateArrayOfElements];
    }
}


- (void) setElementsArray:(NSArray*)newElementsArray
{
    // We override it to be able to show/hide the noContent views
    if (_elementsArray != newElementsArray)
    {
        // Set the ivar
        [newElementsArray retain];
        [_elementsArray release];
        _elementsArray = newElementsArray;
        
        // Show or hide the noContent views
        BOOL noContentViewHidden = ([self.elementsArray count] > 0);
        self.noContentMessageView.hidden = noContentViewHidden;
        self.noContentMessageLabel.hidden = noContentViewHidden;
    }
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set up Search Bar
    self.searchResultsTableViewController.selectionDelegate = self;
    
    // We first populate the tables with the data we already had if any. 
    NSDictionary* data = (NSDictionary*)[FileSystemHelper unarchiveObjectWithFileName:MODEL_DATA_FILE_NAME];
    if (data)
    {
        [self setModelData:data];
        [self.searchResultsTableViewController setModelData:self.modelData];
    }
    
    // Set the year-dependant background
    [[BackgroundImageManager sharedInstance] setBackgroundImageInView:self.backgroundImageView forYear:self.yearString];
    
    // Round corners of noContentView
    self.noContentMessageView.layer.cornerRadius = 8.0;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    [_tableView release];
    _tableView = nil;
    [_noContentMessageLabel release];
    _noContentMessageLabel = nil;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Do geometry related customization here, rather than in view did load. Navigation bars and other elements resizing have already happened by now, but not before
    if (![self implementsSearch])
    {
        // Hide the Search Bar
        [self setSearchResultsTableViewController:nil];
        [[self tableView] setContentOffset:CGPointMake(0, self.searchDisplayController.searchBar.frame.size.height)];
        [[self tableView] setContentInset:UIEdgeInsetsMake(-self.searchDisplayController.searchBar.frame.size.height, 0, 0, 0)];
        self.searchDisplayController.searchBar.hidden = YES;
    }
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}




#pragma mark - Rotation

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
    
    if (self.elementsArray) // we can just check for this as we set it as soon as we get the data
    {        
        numberOfRows = [self.elementsArray count];
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
        self.cellFromNib = [[NSBundle mainBundle] loadNibNamed:[self normalCellNibName] owner:self options:nil][0];
        cell = self.cellFromNib;
        self.cellFromNib = nil;    
    }
    
    // Configure the cell...
    [self tableView:theTableView configureCell:cell indexPath:indexPath];
    
    return cell;
}

- (void) tableView:(UITableView*)theTableView configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath
{
    // Implement in subclasses.
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [theTableView cellForRowAtIndexPath:indexPath];
    cell.selectedBackgroundView = [[NSBundle mainBundle] loadNibNamed:[self selectedCellNibName] owner:self options:nil][0];
    [self tableView:theTableView configureCell:cell indexPath:indexPath];
    
    [UIView animateWithDuration:0.5 animations:^{
        [[[theTableView cellForRowAtIndexPath:indexPath] selectedBackgroundView] setAlpha:0.0];
    } completion:^(BOOL finished) {
        
        [[theTableView cellForRowAtIndexPath:indexPath] setSelectedBackgroundView:nil];
    }];
}



#pragma mark - Table View Customization

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



#pragma mark - UISearchBarDelegateProtocol

- (GroupNameSearchController*) groupNameSearchController
{
    if (![self implementsSearch])
    {
        return nil;
    }
    else
    {
        if (!_groupNameSearchController)
        {
            _groupNameSearchController = [[GroupNameSearchController alloc] initWithSampleArrayinSampleArray:nil andDelegate:self];
        }
        
        return _groupNameSearchController;
    }
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    GroupNameSearchController* sc = [self groupNameSearchController];
    sc.sampleArray = [self searchDataSource];
    [sc searchResultsForString:searchText];
}

- (NSArray*) searchDataSource
{
    return self.elementsArray;
}



- (void) resultsAreReadyInDictionary:(NSDictionary*)resultsDictionary
{
    NSArray* results = resultsDictionary[SEARCH_RESULTS_KEY];
    [[self searchResultsTableViewController] setResults:results];
    [self.searchDisplayController.searchResultsTableView reloadData];
}



#pragma mark - SearchResultsTableViewControllerDelegateProtocol

- (void)tableView:(UITableView *)theTableView selectedElement:(id)element
{    
    Agrupacion* selectedGroup = (Agrupacion*)element;
    int index = [self.elementsArray indexOfObject:selectedGroup];

    if (index >= 0)
    {
        NSIndexPath* ip = [NSIndexPath indexPathForRow:index inSection:0];
        [self tableView:self.tableView didSelectRowAtIndexPath:ip];
    }    
}



#pragma mark - Background Image

- (void) handleBackgroundImageFinishedProcessing
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundImageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundImageView.image = [[BackgroundImageManager sharedInstance] imageForYear:self.yearString];
            self.backgroundImageView.alpha = 0.3;
            [[NSNotificationCenter defaultCenter] removeObserver:self name:BACKGROUND_IMAGE_FINISHED_PROCESSING object:nil];
        }];
    }];
}


@end
