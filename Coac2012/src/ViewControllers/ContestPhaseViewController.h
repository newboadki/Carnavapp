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
#import "BaseCoacListViewController.h"


@interface ContestPhaseViewController : BaseCoacListViewController <ScrollableBoxTappedDelegateProtocol>
{
    NSString* phase;
    CalendarScrollViewController* calendarController;
}

@property (nonatomic, retain) NSString* phase;
@property (nonatomic, retain) CalendarScrollViewController* calendarController;

@end
