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
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



#pragma mark - Table view data source

- (void) configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath
{
    // Configure the cell..
    Link* link = [elementsArray objectAtIndex:[indexpath row]];    
    cell.textLabel.text = link.desc;

}



#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	/***********************************************************************************************/
	/* didSelectRowAtIndexPath.																	   */
	/***********************************************************************************************/
    Link* selectedLink = [elementsArray objectAtIndex:[indexPath row]];
    NSLog(@"link: %@", selectedLink.url);
    LinkViewerViewController* nextController = [[LinkViewerViewController alloc] initWithNibName:@"LinkViewerViewController" bundle:nil];
    [nextController setLink:selectedLink];
    
    [[self navigationController] pushViewController:nextController animated:YES];
    [nextController release];
}

@end
