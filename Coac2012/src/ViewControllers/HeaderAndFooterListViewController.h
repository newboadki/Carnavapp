//
//  HeaderAndFooterListViewController.h
//  Coac2012
//
//  Created by Borja Arias Drake on 25/11/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "BaseCoacListViewController.h"

@interface HeaderAndFooterListViewController : BaseCoacListViewController

@property (nonatomic, assign) BOOL showHeader;
@property (nonatomic, assign) BOOL showFooter;

- (NSString*) headerCellNibName;
- (NSString*) footerCellNibName;


//make protected
- (NSInteger) numberOfContentSections;
- (NSInteger) numberOfRowsContentSection:(NSInteger)contentSection;
- (void) configureHeaderCell:(UITableViewCell*)cell inTableView:(UITableView*)theTableView;
- (void) configureFooterCell:(UITableViewCell*)cell inTableView:(UITableView*)theTableView;
- (void) configureContentCell:(UITableViewCell*)cell inTableView:(UITableView*)theTableView indexPath:(NSIndexPath*)indexpath;
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInContentSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
