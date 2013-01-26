//
//  BaseCoacListViewController+Protected.h
//  Coac2012
//
//  Created by Borja Arias Drake on 24/12/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseCoacListViewController ()

@property (nonatomic, retain) GroupNameSearchController *groupNameSearchController;

- (void) handleDataIsReady:(NSNotification*)notif;
- (void) tableView:(UITableView*)theTableView configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath;

@end
