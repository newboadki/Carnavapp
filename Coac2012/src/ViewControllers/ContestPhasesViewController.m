//
//  ContestPhasesViewController.m
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "ContestPhasesViewController.h"
#import "ContestPhaseViewController.h"


@implementation ContestPhasesViewController


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        elementsArray = [[NSArray arrayWithObjects:PRELIMINAR, CUARTOS, SEMIFINALES, FINAL, nil] retain];
    }
    return self;
}

- (void) dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self setMaskAsTitleView];
}

#pragma mark - Table view data source

- (void) configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath
{
    // Configure the cell...
    UILabel* groupNameLabel = (UILabel*) [cell viewWithTag:GROUP_NAME_LABEL_TAG];
    UILabel* categoryNameLabel = (UILabel*) [cell viewWithTag:CATEGORY_LABEL_TAG];    
    
    groupNameLabel.text = [elementsArray objectAtIndex:[indexpath row]];
    categoryNameLabel.text = @"";

}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    [super tableView:theTableView didSelectRowAtIndexPath:indexPath];
    

     ContestPhaseViewController *detailViewController = [[ContestPhaseViewController alloc] initWithNibName:@"ContestPhaseViewController" bundle:nil];
    detailViewController.phase = [elementsArray objectAtIndex:[indexPath row]];
    detailViewController.modelData = self.modelData;
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     
}

@end
