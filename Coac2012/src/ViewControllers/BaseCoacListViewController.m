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
#import "ContestPhaseDatesHelper.h"
#import <CoreImage/CoreImage.h>
#import "ImageManager.h"
#import <QuartzCore/QuartzCore.h>

@interface BaseCoacListViewController(protected)
- (void) updateArrayOfElements;
- (void) configureSearchResultCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath;
@end

@implementation BaseCoacListViewController

@synthesize modelData;
@synthesize elementsArray;
@synthesize cellFromNib;
@synthesize tableView;
@synthesize searchResultsTableViewController;
@synthesize noContentMessageLabel;
@synthesize noContentMessageView;
@synthesize backgroundImageView = _backgroundImageView;
@synthesize yearString = _yearString;

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
    [groupNameSearchController release];
    [modelData release];
    [elementsArray release];
    [tableView release];
    searchResultsTableViewController.selectionDelegate = nil;
    [searchResultsTableViewController release];
    [noContentMessageLabel release];
    [noContentMessageView release];
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
    
    if (self->modelData != theModelData)
    {
        [theModelData retain];
        [self->modelData release];
        self->modelData = theModelData;
        
        [self updateArrayOfElements];
    }
}


- (void) setElementsArray:(NSArray*)newElementsArray
{
    // We override it to be able to show/hide the noContent views
    if (self->elementsArray != newElementsArray)
    {
        // Set the ivar
        [newElementsArray retain];
        [self->elementsArray release];
        self->elementsArray = newElementsArray;
        
        // Show or hide the noContent views
        BOOL noContentViewHidden = ([self.elementsArray count] > 0);
        self.noContentMessageView.hidden = noContentViewHidden;
        self.noContentMessageLabel.hidden = noContentViewHidden;
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
    // Set up Search Bar
    searchResultsTableViewController.selectionDelegate = self;
    
    // We first populate the tables with the data we already had if any. 
    NSDictionary* data = (NSDictionary*)[FileSystemHelper unarchiveObjectWithFileName:MODEL_DATA_FILE_NAME];
    if (data)
    {
        [self setModelData:data];
        [self.searchResultsTableViewController setModelData:self.modelData];
    }
    
    // Set the year-dependant background
    [self setUpBackgroundForYear:self.yearString];
    
    // Round corners of noContentView
    self.noContentMessageView.layer.cornerRadius = 8.0;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    [tableView release];
    tableView = nil;    
    [noContentMessageLabel release];
    noContentMessageLabel = nil;
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
        self.cellFromNib = [[NSBundle mainBundle] loadNibNamed:[self normalCellNibName] owner:self options:nil][0];
        cell = cellFromNib;
        self.cellFromNib = nil;    
    }
    
    // Configure the cell...
    [self configureCell:cell indexPath:indexPath];
    
    return cell;
}

- (void) configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath
{
    // Implement in subclasses.
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [theTableView cellForRowAtIndexPath:indexPath];
    cell.selectedBackgroundView = [[NSBundle mainBundle] loadNibNamed:[self selectedCellNibName] owner:self options:nil][0] ;
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
    NSArray* results = resultsDictionary[SEARCH_RESULTS_KEY];
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

- (void) handleBackgroundImageFinishedProcessing
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundImageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundImageView.image = [[ImageManager sharedInstance] imageForYear:self.yearString];
            self.backgroundImageView.alpha = 0.3;
            [[NSNotificationCenter defaultCenter] removeObserver:self name:BACKGROUND_IMAGE_FINISHED_PROCESSING object:nil];
        }];
    }];
}



#pragma mark - Background Image Helpers

- (void) setUpBackgroundForYear:(NSString*)year
{
    [[ImageManager sharedInstance] setBackgroundImageInView:self.backgroundImageView forYear:year];
}

@end
