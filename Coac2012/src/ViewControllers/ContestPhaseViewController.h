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
#import "HeaderAndFooterListViewController.h"

/**
 */
@interface ContestPhaseViewController : HeaderAndFooterListViewController <ScrollableBoxTappedDelegateProtocol>

/** It's the custom view controller that manages the calendar view.*/
@property (nonatomic, retain) CalendarScrollViewController* calendarController;

/** Shadow that the calendarController's view drops over the table view.*/
@property (nonatomic, retain) IBOutlet UIImageView *shadowImageView;

@end
