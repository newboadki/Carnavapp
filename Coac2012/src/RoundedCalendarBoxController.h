//
//  RoundedCalendarBoxController.h
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarScrollViewController.h"

@interface RoundedCalendarBoxController : NSObject
{
    IBOutlet UIView* view;
    IBOutlet UILabel* monthLabel;
    IBOutlet UILabel* dayLabel;
    IBOutlet UIImageView* backgroundView;
    
    CalendarScrollViewController* tapDelegate;
    NSString* dateString;
    NSDictionary* monthsNames;
}

@property (nonatomic, retain) UILabel* monthLabel;
@property (nonatomic, retain) UILabel* dayLabel;
@property (nonatomic, retain) UIView*  view;
@property (nonatomic, retain) UIImageView* backgroundView;
@property (nonatomic, assign) CalendarScrollViewController* tapDelegate;
@property (nonatomic, copy) NSString*  dateString;

- (void) viewDidLoad;
- (void) viewDidUnload;
- (void) viewWillAppear;
- (void) viewWillDisappear;

- (void) setNormalLook;
- (void) setActiveLook;

- (id) initWithTapDelegate:(CalendarScrollViewController*)delegate andDateString:(NSString*)ds;

@end
