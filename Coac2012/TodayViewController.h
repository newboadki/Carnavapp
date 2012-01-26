//
//  FirstViewController.h
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface TodayViewController : UIViewController <UITableViewDataSource, UITabBarDelegate>
{
    NSDictionary* modelData;
    NSArray* groupsForToday;
    UITableViewCell* cellFromNib;
    IBOutlet UITableView* tableView;
}

@property (nonatomic, retain) NSDictionary* modelData;
@property (nonatomic, retain) NSArray* groupsForToday;
@property (nonatomic, assign) UITableViewCell* cellFromNib;
@property (nonatomic, retain) UITableView* tableView;
@end
