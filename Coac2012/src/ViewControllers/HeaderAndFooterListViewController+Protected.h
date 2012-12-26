//
//  HeaderAndFooterListViewController+Protected.h
//  Coac2012
//
//  Created by Borja Arias Drake on 24/12/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeaderAndFooterListViewController (Protected)
- (NSInteger) numberOfContentSections;
- (NSInteger) numberOfRowsContentSection:(NSInteger)contentSection;
- (void) configureHeaderCell:(UITableViewCell*)cell inTableView:(UITableView*)theTableView;
- (void) configureFooterCell:(UITableViewCell*)cell inTableView:(UITableView*)theTableView;
- (void) configureContentCell:(UITableViewCell*)cell inTableView:(UITableView*)theTableView indexPath:(NSIndexPath*)indexpath;
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInContentSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void) handleFooterSelected:(UITableViewCell*)footerCell;
@end