//
//  ContestPhasesViewController.m
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "ContestPhasesViewController.h"
#import "ContestPhaseViewController.h"
#import "BaseCoacListViewController+Protected.h"

@implementation ContestPhasesViewController



#pragma mark - Initializers

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.elementsArray = [[NSArray arrayWithObjects:PRELIMINAR, CUARTOS, SEMIFINALES, FINAL, nil] retain];
    }
    return self;
}



#pragma mark - View Life-cycle

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



#pragma mark - Super class extension methods

- (void) tableView:(UITableView*)theTableView configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath
{
    // Configure the cell...
    UILabel* groupNameLabel = (UILabel*) [cell viewWithTag:GROUP_NAME_LABEL_TAG];    
    groupNameLabel.text = [self.elementsArray objectAtIndex:[indexpath row]];
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    [super tableView:theTableView didSelectRowAtIndexPath:indexPath];
    

     ContestPhaseViewController *detailViewController = [[ContestPhaseViewController alloc] initWithNibName:@"ContestPhaseViewController" bundle:nil];
    detailViewController.phase = [self.elementsArray objectAtIndex:[indexPath row]];
    detailViewController.modelData = self.modelData;
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     
}



#pragma mark - custom cells

- (NSString*) normalCellNibName
{
    return @"SpacedOneLabelCell";
}

- (NSString*) selectedCellNibName
{
    return @"SpacedOneLabelSelectedCell";
}



#pragma mark - Memory Management

- (void) dealloc
{
    [super dealloc];
}

@end
