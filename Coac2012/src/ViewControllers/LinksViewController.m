//
//  LinksViewController.m
//  Coac2012
//
//  Created by Borja Arias on 25/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "LinksViewController.h"
#import "Link.h"
#import "LinkViewerViewController.h"



@implementation LinksViewController



- (void) updateArrayOfElements
{
    NSArray* linksArray = [modelData objectForKey:LINKS_KEY];
    [self setElementsArray:linksArray];
    NSLog(@">>> %@", tableView);
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setMaskAsTitleView];
}



#pragma mark - Table view data source

- (void) configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath
{
    // Configure the cell..
    UILabel* groupNameLabel = (UILabel*) [cell viewWithTag:GROUP_NAME_LABEL_TAG];
    UILabel* categoryNameLabel = (UILabel*) [cell viewWithTag:CATEGORY_LABEL_TAG];    

    Link* link = [elementsArray objectAtIndex:[indexpath row]];    
    NSLog(@"- %@", link.desc);
    groupNameLabel.text = link.desc;
    categoryNameLabel.text = @"";

}



#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	/***********************************************************************************************/
	/* didSelectRowAtIndexPath.																	   */
	/***********************************************************************************************/
    [super tableView:theTableView didSelectRowAtIndexPath:indexPath];
    

    Link* selectedLink = [elementsArray objectAtIndex:[indexPath row]];
    NSLog(@"link: %@", selectedLink.url);
    LinkViewerViewController* nextController = [[LinkViewerViewController alloc] initWithNibName:@"LinkViewerViewController" bundle:nil];
    [nextController setLink:selectedLink];
    
    [[self navigationController] pushViewController:nextController animated:YES];
    [nextController release];
}

@end
