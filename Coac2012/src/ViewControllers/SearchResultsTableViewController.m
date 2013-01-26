//
//  SearchResultsTableViewController.m
//  Coac2012
//
//  Created by Borja Arias on 13/02/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "SearchResultsTableViewController.h"
#import "Agrupacion.h"
#import "GroupsForModalityViewController.h"

@interface SearchResultsTableViewController(private)
- (void) tableView:(UITableView*)theTableView configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath;
@end

@implementation SearchResultsTableViewController



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void) dealloc
{
    [_results release];
    [_modelData release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [self.results count];
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SearchCell";
    
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        self.cellFromNib = [[NSBundle mainBundle] loadNibNamed:@"SearchresultCell" owner:self options:nil][0];
        cell = self.cellFromNib;
        self.cellFromNib = nil;    
    }
    
    // Configure the cell...
    [self tableView:theTableView configureCell:cell indexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (void) tableView:(UITableView*)theTableView configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath
{
    Agrupacion* ag = self.results[[indexpath row]];
    UILabel* groupNameLabel = (UILabel*) [cell viewWithTag:GROUP_NAME_LABEL_TAG];
    UILabel* categoryNameLabel = (UILabel*) [cell viewWithTag:CATEGORY_LABEL_TAG];        
        groupNameLabel.text = ag.nombre;
        categoryNameLabel.text = @"";


}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	/***********************************************************************************************/
	/* didSelectRowAtIndexPath.																	   */
	/***********************************************************************************************/
    Agrupacion* selectedGroup = self.results[[indexPath row]];
    [self.selectionDelegate tableView:theTableView selectedElement:selectedGroup];
}



#pragma mark - UISearchDisplayController

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller  shouldReloadTableForSearchString:(NSString *)searchString
{
    return NO;
}

@end
