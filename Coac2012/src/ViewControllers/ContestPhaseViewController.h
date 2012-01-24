//
//  ContestPhaseViewController.h
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarScrollViewController.h"
#import "ScrollableBoxTappedDelegateProtocol.h"

@interface ContestPhaseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ScrollableBoxTappedDelegateProtocol>
{
    NSString* phase;
    CalendarScrollViewController* calendarController;
    NSDictionary* modelData;
    NSArray*      orderedGroups; // oredered by performance order. That happended during the parsing
    
    IBOutlet UITableView* tableView;
}

@property (nonatomic, retain) NSString* phase;
@property (nonatomic, retain) CalendarScrollViewController* calendarController;
@property (nonatomic, retain) NSDictionary* modelData;
@property (nonatomic, retain) NSArray*      orderedGroups;
@property (nonatomic, retain) UITableView* tableView;

@end
