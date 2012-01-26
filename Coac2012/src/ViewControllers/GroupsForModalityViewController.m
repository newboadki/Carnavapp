//
//  GroupsForModalityViewController.m
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "GroupsForModalityViewController.h"
#import "Agrupacion.h"
#import "GroupDetailViewController.h"


@interface GroupsForModalityViewController(protected)
- (void) updateArrayOfElements;
@end

@implementation GroupsForModalityViewController

@synthesize modality;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    
    return self;
}

- (void) setModelData:(NSDictionary *)theModelData
{
    if (self->modelData != theModelData)
    {
        [theModelData retain];
        [self->modelData release];
        self->modelData = theModelData;
            
        [self updateArrayOfElements];
    }
}


- (void) updateArrayOfElements
{
    NSDictionary* modalitiesDic = [modelData objectForKey:MODALITIES_KEY];
    NSArray* modalityGroups = [modalitiesDic objectForKey:modality];
    
    modalityGroups = [modalityGroups sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        Agrupacion* a1 = (Agrupacion*)obj1;
        Agrupacion* a2 = (Agrupacion*)obj2;
        
        return [a1.nombre compare:a2.nombre];
    }];
    
    [self setElementsArray:modalityGroups];
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

    self.title = NSLocalizedString(self.modality, self.modality);
}

- (void)viewDidUnload
{
    [super viewDidUnload];    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table view data source

- (void) configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath
{
    // Configure the cell...
    Agrupacion* ag = [elementsArray objectAtIndex:[indexpath row]];
    UILabel* groupNameLabel = (UILabel*) [cell viewWithTag:GROUP_NAME_LABEL_TAG];
    UILabel* categoryNameLabel = (UILabel*) [cell viewWithTag:CATEGORY_LABEL_TAG];    
    
    if ([ag identificador] != -1)
    {
        groupNameLabel.text = ag.nombre;
        categoryNameLabel.text = [NSString stringWithFormat:@"%@ (%@)", ag.modalidad, ag.localidad];
    }    

}


- (void) dealloc
{
    [modality release];
    [super dealloc];    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupDetailViewController* detailViewController = [[GroupDetailViewController alloc] initWithNibName:@"GroupDetailViewController" bundle:nil];
    detailViewController.group = [elementsArray objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
     
}

@end
