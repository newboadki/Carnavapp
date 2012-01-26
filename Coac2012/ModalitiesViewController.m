//
//  SecondViewController.m
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "ModalitiesViewController.h"
#import "GroupsForModalityViewController.h"
#import "Agrupacion.h"


@implementation ModalitiesViewController


- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {        
    }
    
    return self;
}
					
- (void) dealloc
{
    [super dealloc];    
}


- (void) updateArrayOfElements
{
    NSDictionary* modalitiesDic = [modelData objectForKey:MODALITIES_KEY];
    NSArray* mk = [modalitiesDic allKeys];
    
    // Order an assign the relevant parts of information for this class
    mk = [mk sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString* s1 = (NSString*)obj1;
        NSString* s2 = (NSString*)obj2;
        return [s1 compare:s2];
    }];
    
    [self setElementsArray:mk];

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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark -
#pragma mark Table view data source

- (void) configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath
{
    UILabel* groupNameLabel = (UILabel*) [cell viewWithTag:GROUP_NAME_LABEL_TAG];
    UILabel* categoryNameLabel = (UILabel*) [cell viewWithTag:CATEGORY_LABEL_TAG];    
    
    NSString* currentModality = [elementsArray objectAtIndex:[indexpath row]];    
    groupNameLabel.text = currentModality;
	categoryNameLabel.text = @"";
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	/***********************************************************************************************/
	/* didSelectRowAtIndexPath.																	   */
	/***********************************************************************************************/
    NSString* selectedModality = [elementsArray objectAtIndex:[indexPath row]];
    GroupsForModalityViewController* nextController = [[GroupsForModalityViewController alloc] initWithNibName:@"GroupsForModalityViewController" bundle:nil];
    [nextController setModality:selectedModality];
    [nextController setModelData:self.modelData];
    
    [[self navigationController] pushViewController:nextController animated:YES];
    [nextController release];
}
@end
