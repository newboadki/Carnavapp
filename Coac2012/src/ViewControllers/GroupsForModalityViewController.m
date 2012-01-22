//
//  GroupsForModalityViewController.m
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "GroupsForModalityViewController.h"
#import "Agrupacion.h"


@interface GroupsForModalityViewController()
@property (nonatomic, retain) NSArray* orderedGroupsForModality;

- (void) handleGroupsForModality;
@end

@implementation GroupsForModalityViewController

@synthesize modelData;
@synthesize modality;
@synthesize orderedGroupsForModality;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDataIsReady:) name:MODEL_DATA_IS_READY_NOTIFICATION object:nil];
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
            
        [self handleGroupsForModality];
    }
}

- (void) handleDataIsReady:(NSNotification*)notif
{
    // Get the data
    NSDictionary* data = [notif userInfo];
    [self setModelData:data];    

    [self handleGroupsForModality]; 
}

- (void) handleGroupsForModality
{
    NSDictionary* modalitiesDic = [modelData objectForKey:MODALITIES_KEY];
    NSArray* modalityGroups = [modalitiesDic objectForKey:modality];
    
    modalityGroups = [modalityGroups sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        Agrupacion* a1 = (Agrupacion*)obj1;
        Agrupacion* a2 = (Agrupacion*)obj2;
        
        return [a1.nombre compare:a2.nombre];
    }];
    
    [self setOrderedGroupsForModality:modalityGroups];
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
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numberOfRows = 0;
    
    if (orderedGroupsForModality) // we can just check for this as we set it as soon as we get the data
    {        
        numberOfRows = [orderedGroupsForModality count];
    }
    
	return numberOfRows;	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    Agrupacion* ag = [orderedGroupsForModality objectAtIndex:[indexPath row]];
    cell.textLabel.text = ag.nombre;
    
    return cell;
}


- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MODEL_DATA_IS_READY_NOTIFICATION object:nil];
    [modelData release];
    [modality release];
    [orderedGroupsForModality release];
    [super dealloc];    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
