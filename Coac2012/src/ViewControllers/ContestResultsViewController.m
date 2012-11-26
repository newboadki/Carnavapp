//
//  ContestResultsViewController.m
//  Coac2012
//
//  Created by Borja Arias on 22/02/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "ContestResultsViewController.h"
#import "Agrupacion.h"
#import "GroupDetailViewController.h"
#import "YearSelectionViewController.h"
@interface ContestResultsViewController(private)
- (Agrupacion*) findGroupWithId:(int)soughtId;
@end

@implementation ContestResultsViewController



#pragma mark - Parent Class extentsion methods

- (void) updateArrayOfElements
{
    NSArray* groups = @[[self findGroupWithId:79], // Coros
                                               [self findGroupWithId:61],
                                               [self findGroupWithId:9],
                                               [self findGroupWithId:48], // Comparsas
                                               [self findGroupWithId:101],
                                               [self findGroupWithId:83],
                                               [self findGroupWithId:103], // Chirigotas
                                               [self findGroupWithId:32],
                                               [self findGroupWithId:92],
                                               [self findGroupWithId:38], // Cuartetos
                                               [self findGroupWithId:109],
                                               [self findGroupWithId:73]];
    [self setElementsArray:groups];
    [self.tableView reloadData];
}


- (void) configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath
{
    if ( (indexpath.section != 0) && ((indexpath.section != 5)))
    {
        int section = [indexpath section]-1; // Because the content sections go from 1 to 4 (because 0 is the header) but the linear index starts at 0.
        int row = [indexpath row];
        int linealIndex = row + (section * 3);
        NSLog(@"%@", elementsArray);
        Agrupacion* ag = elementsArray[linealIndex];
        UILabel* groupNameLabel = (UILabel*) [cell viewWithTag:GROUP_NAME_LABEL_TAG];
        UILabel* categoryNameLabel = (UILabel*) [cell viewWithTag:CATEGORY_LABEL_TAG];
        
        groupNameLabel.text = ag.nombre;
        categoryNameLabel.text = @"";
    }
}



#pragma mark - TableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)_tableView
{
    return 6;
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
	switch (section) {
        case 0: // Header
            return 1;
            break;
        case 5: // Footer, last one
            return 1;
            break;
        default:
            return 3;
            break;
    };
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString* title = nil;
    
    switch (section)
    {
        case 1:
            title = @"Coros";
            break;
        case 2:
            title = @"Comparsas";
            break;
        case 3:
            title = @"Chirigotas";
            break;
        case 4:
            title = @"Cuartetos";
            break;
        default:
            title = nil;
            break;
        
    }
    
    NSLog(@"Returning title %@ for section %d", title, section);
    return title;
}


- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:theTableView didSelectRowAtIndexPath:indexPath];
    
    int section = [indexPath section] - 1;
    int row = [indexPath row];
    int linealIndex = row + (section * 3);

    GroupDetailViewController* detailViewController = [[GroupDetailViewController alloc] initWithNibName:@"GroupDetailViewController" bundle:nil];
    detailViewController.group = elementsArray[linealIndex];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
//    YearSelectionViewController *yearVC = [[YearSelectionViewController alloc] initWithNibName:@"BaseCoacListViewController" bundle:nil];
//    [self.navigationController pushViewController:yearVC animated:YES];
//    [yearVC release];
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 5) {
        return 44;
    }
    else
    {
        return 60.0f;
    }
}



- (int) numberOfSections
{
    return [super numberOfSectionsInTableView:self.tableView] + 3;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setMaskAsTitleView];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark - Helpers

- (Agrupacion*) findGroupWithId:(int)soughtId
{
    NSArray* allgroups = modelData[GROUPS_KEY];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"self.identificador = %ld", soughtId];
    NSArray* results = [allgroups filteredArrayUsingPredicate:predicate];
    Agrupacion* group = nil;
    
    if ([results count] > 0)
    {
        group = results[0];        
    }
    
    return group;    
}

@end
