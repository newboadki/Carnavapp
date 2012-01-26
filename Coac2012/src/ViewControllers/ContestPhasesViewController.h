//
//  ContestPhasesViewController.h
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContestPhasesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray* phases;
    NSDictionary* modelData;
    IBOutlet UITableView* tableView;
    UITableViewCell* cellFromNib;
}

@property (nonatomic, retain) NSDictionary* modelData;
@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, assign) UITableViewCell* cellFromNib;

@end
