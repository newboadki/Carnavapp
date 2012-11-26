//
//  YearSelectionViewController.m
//  Coac2012
//
//  Created by Borja Arias Drake on 25/11/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "YearSelectionViewController.h"

@interface YearSelectionViewController ()

@end

@implementation YearSelectionViewController

@synthesize classOfTheNextViewController = _classOfTheNextViewController;


#pragma mark - Parent Class extentsion methods

- (void) updateArrayOfElements
{
    //NSArray* yearKeys = modelData[YEARS_KEY];
    
    [self setElementsArray:@[@"2013", @"2012"]];
}


- (void) configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath
{
    UILabel* groupNameLabel = (UILabel*) [cell viewWithTag:GROUP_NAME_LABEL_TAG];
    UILabel* categoryNameLabel = (UILabel*) [cell viewWithTag:CATEGORY_LABEL_TAG];
    
    NSString* yearItem = elementsArray[[indexpath row]];
    groupNameLabel.text = yearItem;
	categoryNameLabel.text = @""; // We are not using this here
}




#pragma mark - custom cells

- (NSString*) normalCellNibName
{
    return @"SpacedOneLabelCell";
}

- (NSString*) selectedCellNibName
{
    return @"SpacedOneLabelSlectedCell";
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Select a Year", nil);
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
    
//    NSString* selectedModality = elementsArray[[indexPath row]];
//    GroupsForModalityViewController* nextController = [[GroupsForModalityViewController alloc] initWithNibName:@"BaseCoacListViewController" bundle:nil];
//    [nextController setModality:selectedModality];
//    [nextController setModelData:self.modelData];
//    
//    [[self navigationController] pushViewController:nextController animated:YES];
//    [nextController release];
}

@end
