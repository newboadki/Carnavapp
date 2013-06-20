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
#import "BaseCoacListViewController+Protected.h"
#import "ContestPhaseDatesHelper.h"
#import "GroupDetailViewController.h"

@interface ModalitiesViewController ()
@property (nonatomic, retain) NSArray *searchControllerDataSource;
@end

@implementation ModalitiesViewController



#pragma mark - Parent Class extentsion methods

- (void) updateArrayOfElements
{
    NSDictionary* modalitiesDic = self.modelData[MODALITIES_KEY];
    NSArray* mk = [modalitiesDic allKeys];
    
    // Order an assign the relevant parts of information for this class
    mk = [mk sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString* s1 = (NSString*)obj1;
        NSString* s2 = (NSString*)obj2;
        return [s1 compare:s2];
    }];
    
    [self setElementsArray:mk];
    [self setSearchControllerDataSource:[self allGroupsFromModelData:self.modelData]];
    
}


- (NSArray*) allGroupsFromModelData:(NSDictionary*)data
{
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSString* yearKey in data[GROUPS_KEY]) {
        [result addObjectsFromArray:data[GROUPS_KEY][yearKey]];
    }
    
    return result;
}


- (void) tableView:(UITableView*)theTableView configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath
{
    [super tableView:theTableView configureCell:cell indexPath:indexpath];
    
    if (theTableView == self.tableView)
    {
        UILabel* groupNameLabel = (UILabel*) [cell viewWithTag:GROUP_NAME_LABEL_TAG];
        UILabel* categoryNameLabel = (UILabel*) [cell viewWithTag:CATEGORY_LABEL_TAG];
        
        NSString* currentModality = self.elementsArray[[indexpath row]];
        groupNameLabel.text = currentModality;
        categoryNameLabel.text = @"";
    }
        
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



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.
    self.title = NSLocalizedString(@"Modalidades", @"Modalidades");
    [self setMaskAsTitleView];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.contentOffset = CGPointMake(0, self.searchDisplayController.searchBar.frame.size.height);
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	/***********************************************************************************************/
	/* didSelectRowAtIndexPath.																	   */
	/***********************************************************************************************/
        
    // it's not coming from the search bar
    [super tableView:theTableView didSelectRowAtIndexPath:indexPath];
    
    NSString* selectedModality = self.elementsArray[[indexPath row]];
    GroupsForModalityViewController* nextController = [[GroupsForModalityViewController alloc] initWithNibName:@"BaseCoacListViewController" bundle:nil];
    nextController.showHeader = NO;
    nextController.showFooter = YES;
    [nextController setModality:selectedModality];
    [nextController setModelData:self.modelData];
    [nextController setYearString:[[ContestPhaseDatesHelper yearKeys] lastObject]];
    
    [[self navigationController] pushViewController:nextController animated:YES];
    [nextController release];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}


#pragma mark - SearchResultsTableViewControllerDelegateProtocol

- (void)tableView:(UITableView *)theTableView selectedElement:(id)element
{
    
    if (theTableView != self.tableView)
    {

        Agrupacion* selectedGroup = (Agrupacion*)element;
        GroupDetailViewController *vc = [[GroupDetailViewController alloc] init];
        vc.group = selectedGroup;
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
    
}


#pragma mark - Search

- (BOOL) implementsSearch
{
    return YES;
}


- (NSArray*) searchDataSource
{
    return self.searchControllerDataSource;
}


@end
