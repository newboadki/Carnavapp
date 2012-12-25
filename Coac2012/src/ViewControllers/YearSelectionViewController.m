//
//  YearSelectionViewController.m
//  Coac2012
//
//  Created by Borja Arias Drake on 25/11/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "YearSelectionViewController.h"
#import "BaseCoacListViewController+Protected.h"


@implementation YearSelectionViewController

@synthesize classOfTheNextViewController = _classOfTheNextViewController;
@synthesize nibNameOfTheNextViewController = _nibNameOfTheNextViewController;
@synthesize keyValuesToSetInNewInstance;

#pragma mark - Parent Class extentsion methods

- (void) updateArrayOfElements
{
    //NSArray* yearKeys = modelData[YEARS_KEY];
    
    NSArray* years = self.modelData[YEARS_KEY];
    NSArray* pastYears = [years subarrayWithRange:NSMakeRange(1, [years count]-1)];
    [self setElementsArray:pastYears];
}


- (void) configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath
{
    UILabel* groupNameLabel = (UILabel*) [cell viewWithTag:GROUP_NAME_LABEL_TAG];
    UILabel* categoryNameLabel = (UILabel*) [cell viewWithTag:CATEGORY_LABEL_TAG];
    
    NSString* yearItem = self.elementsArray[[indexpath row]];
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
    self.title = NSLocalizedString(@"Selecciona año", nil);
}



#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	/***********************************************************************************************/
	/* didSelectRowAtIndexPath.																	   */
	/***********************************************************************************************/
    [super tableView:theTableView didSelectRowAtIndexPath:indexPath];
    NSString* selectedYear = self.elementsArray[[indexPath row]];
    id nextController = [[self.classOfTheNextViewController alloc] initWithNibName:self.nibNameOfTheNextViewController bundle:nil];
    
    for (id key in [self.keyValuesToSetInNewInstance allKeys])
    {
        if ([nextController respondsToSelector:NSSelectorFromString(key)]) {
            id value = [self.keyValuesToSetInNewInstance valueForKey:key];
            [nextController setValue:value forKey:key];
        }
    }
    
    [nextController performSelector:@selector(setYearString:) withObject:selectedYear];
    [nextController setModelData:self.modelData];
    //[nextController performSelector:@selector(updateArrayOfElements)];
    
    [[self navigationController] pushViewController:nextController animated:YES];
    [nextController release];
}


- (void) dealloc
{
    [keyValuesToSetInNewInstance release];
    [_nibNameOfTheNextViewController release];
    [super dealloc];
}

@end
