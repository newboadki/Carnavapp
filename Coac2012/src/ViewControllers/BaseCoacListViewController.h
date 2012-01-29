//
//  BaseCoacListViewController.h
//  Coac2012
//
//  Created by Borja Arias on 26/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCoacListViewController : UIViewController <UITableViewDataSource, UITabBarDelegate>
{
    NSDictionary* modelData;
    NSArray* elementsArray;
    UITableViewCell* cellFromNib;
    IBOutlet UITableView* tableView;
    UILabel* loadingLabel;
}

@property (nonatomic, retain) NSDictionary* modelData;
@property (nonatomic, retain) NSArray* elementsArray;
@property (nonatomic, assign) UITableViewCell* cellFromNib;
@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) UILabel* loadingLabel;

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void) setMaskAsTitleView;
- (void) handleDataIsReady:(NSNotification*)notif;

- (NSString*) normalCellNibName;
- (NSString*) selectedCellNibName;

@end
