//
//  SecondViewController.h
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface ModalitiesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSDictionary* modelData;
    IBOutlet UITableView* tableView;
    UITableViewCell* cellFromNib;
}

@property (nonatomic, retain) NSDictionary* modelData;
@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, assign) UITableViewCell* cellFromNib;

@end
