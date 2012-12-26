//
//  BaseCoacListViewController.h
//  Coac2012
//
//  Created by Borja Arias on 26/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupNameSearchController.h"
#import "SearchResultsTableViewController.h"
#import "FileSystemHelper.h"

@interface BaseCoacListViewController : UIViewController <UITableViewDataSource, UITabBarDelegate, UISearchDisplayDelegate, GroupNameSearchControllerDelegateProtocol, SearchResultsTableViewControllerDelegateProtocol>

@property (nonatomic, retain) NSDictionary* modelData;
@property (nonatomic, retain) NSArray* elementsArray;
@property (nonatomic, assign) UITableViewCell* cellFromNib;
@property (nonatomic, retain) IBOutlet UITableView* tableView;
@property (nonatomic, retain) IBOutlet SearchResultsTableViewController* searchResultsTableViewController;
@property (nonatomic, retain) IBOutlet UILabel* noContentMessageLabel;
@property (nonatomic, retain) IBOutlet UIView* noContentMessageView;
@property (nonatomic, retain) IBOutlet UIImageView *backgroundImageView;

/** Defines the year the viewController is showing information from.*/
@property (nonatomic, retain) NSString *yearString;

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

// Customising the look of the view controller
- (void) setMaskAsTitleView;
- (NSString*) normalCellNibName;
- (NSString*) selectedCellNibName;
- (BOOL) implementsSearch;

- (void) updateArrayOfElements; // Made public because the app delegate uses them


@end
