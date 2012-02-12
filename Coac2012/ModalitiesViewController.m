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



#pragma mark - Parent Class extentsion methods

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


- (void) configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath
{
    UILabel* groupNameLabel = (UILabel*) [cell viewWithTag:GROUP_NAME_LABEL_TAG];
    UILabel* categoryNameLabel = (UILabel*) [cell viewWithTag:CATEGORY_LABEL_TAG];    
    
    NSString* currentModality = [elementsArray objectAtIndex:[indexpath row]];    
    groupNameLabel.text = currentModality;
	categoryNameLabel.text = @"";
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
    self.title = NSLocalizedString(@"Modalidades", @"Modalidades");
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
    

    NSString* selectedModality = [elementsArray objectAtIndex:[indexPath row]];
    GroupsForModalityViewController* nextController = [[GroupsForModalityViewController alloc] initWithNibName:@"BaseCoacListViewController" bundle:nil];
    [nextController setModality:selectedModality];
    [nextController setModelData:self.modelData];
    
    [[self navigationController] pushViewController:nextController animated:YES];
    [nextController release];
}

@end
