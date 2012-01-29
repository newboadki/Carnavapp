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



#pragma mark - super class extension methods

- (void) updateArrayOfElements
{
    NSArray* linksArray = [modelData objectForKey:LINKS_KEY];
    [self setElementsArray:linksArray];
    [self.tableView reloadData];
}

- (void) configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath
{
    // Configure the cell..
    UILabel* groupNameLabel = (UILabel*) [cell viewWithTag:GROUP_NAME_LABEL_TAG];
    
    Link* link = [elementsArray objectAtIndex:[indexpath row]];    
    groupNameLabel.text = link.desc; 
}



# pragma mark - View lifecycle mthods

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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}



#pragma mark - custom cells

- (NSString*) normalCellNibName
{
    return @"LinkCell";
}

- (NSString*) selectedCellNibName
{
    return @"LinkCellSelected";
}


@end
