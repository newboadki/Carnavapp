//
//  GroupsForModalityViewController.h
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupsForModalityViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSDictionary* modelData;
    NSString* modality;
    IBOutlet UITableView* tableView;
    UITableViewCell* cellFromNib;
}

@property (nonatomic, retain) NSDictionary* modelData;
@property (nonatomic, retain) NSString* modality;
@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, assign) UITableViewCell* cellFromNib;
@end
