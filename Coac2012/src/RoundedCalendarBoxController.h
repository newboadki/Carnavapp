//
//  RoundedCalendarBoxController.h
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarScrollViewController.h"
#import "Constants.h"

@interface RoundedCalendarBoxController : NSObject

@property (nonatomic, retain) IBOutlet UILabel* monthLabel;
@property (nonatomic, retain) IBOutlet UILabel* dayLabel;
@property (nonatomic, retain) IBOutlet UILabel* phaseLabel;
@property (nonatomic, retain) IBOutlet UIView*  view;
@property (nonatomic, retain) IBOutlet UIView*  coloredAreaView;
@property (nonatomic, retain) IBOutlet UIImageView* backgroundView;
@property (nonatomic, assign) CalendarScrollViewController* tapDelegate;
@property (nonatomic, copy) NSString*  dateString;

- (void) viewDidLoad;
- (void) viewDidUnload;
- (void) viewWillAppear;
- (void) viewWillDisappear;

- (void) setNormalLook;
- (void) setActiveLook;

- (id) initWithTapDelegate:(CalendarScrollViewController*)delegate andDateString:(NSString*)ds andContestPhasesDatesInYear:(NSDictionary*)phasesDictionaryInYear;

@end
