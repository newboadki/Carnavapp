//
//  RoundedCalendarBoxController.m
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "RoundedCalendarBoxController.h"

@interface RoundedCalendarBoxController()
- (void) loadView;
- (void) componentesFromDateString:(NSString*)ds day:(int*)d month:(int*)m year:(int*)y;
- (void) handleTap:(id)sender;
@end

@implementation RoundedCalendarBoxController

@synthesize tapDelegate;
@synthesize dateString;
@synthesize monthLabel, dayLabel, view;
@synthesize backgroundView;



#pragma mark - Initializators

- (id) initWithTapDelegate:(CalendarScrollViewController*)delegate andDateString:(NSString*)ds
{
    self = [super init];
    if (self)
    {
        tapDelegate = delegate;
        dateString = [ds copy];
        monthsNames = [[NSDictionary dictionaryWithObjectsAndKeys:@"ENE", [NSNumber numberWithInt:1],@"FEB", [NSNumber numberWithInt:2],@"MAR", [NSNumber numberWithInt:3],@"ABR", [NSNumber numberWithInt:4],@"MAY", [NSNumber numberWithInt:5],@"JUN", [NSNumber numberWithInt:6],@"JUL", [NSNumber numberWithInt:7],@"AGO", [NSNumber numberWithInt:8],@"SEP", [NSNumber numberWithInt:9],@"OCT", [NSNumber numberWithInt:10],@"NOV", [NSNumber numberWithInt:11],@"DIC", [NSNumber numberWithInt:12], nil] retain];
    }
    
    return self;
}



#pragma mark - Accessor Methods

- (UIView*) view
{
    if (!view)
    {
        [self loadView];
    }
    
    return view;
}


- (UIView*) monthLabel
{
    if (!view)
    {
        [self loadView];
    }
    
    return monthLabel;
}


- (UIView*) dayLabel
{
    if (!view)
    {
        [self loadView];
    }
    
    return dayLabel;
}



#pragma mark - View handling related Methods

- (void) loadView
{
    // Create the view
    // will only be called once, only form the view getter.
    view = [[[[NSBundle mainBundle] loadNibNamed:@"RoundedCalendarBoxView" owner:self options:nil] objectAtIndex:0] retain];            
    
    // Gesture recognizer
    UITapGestureRecognizer* tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [view addGestureRecognizer:tgr];
    [tgr release];    
    
}


- (void) viewDidLoad
{
    // The view will be on the hierarchy already    
    int day, month, year;
    [self componentesFromDateString:dateString day:(&day) month:(&month) year:(&year)];
    self.monthLabel.text = [NSString stringWithFormat:@"%@", [monthsNames objectForKey:[NSNumber numberWithInt:month]]];
    self.dayLabel.text = [NSString stringWithFormat:@"%d", day];
}


- (void) viewDidUnload
{
    // We assume that this view will be contained by another one. That view's controller will execure viewDidUnload (our superview), so our view will be out of the hierarchy anyway. That's why I'm not calling [scrollView removeFromSuperview];
    [monthLabel release];
    monthLabel = nil;
    [dayLabel release];
    dayLabel = nil;
    [backgroundView release];
    backgroundView = nil;

}


- (void) viewWillAppear
{
    
}


- (void) viewWillDisappear
{
    
}



#pragma mark - Event Handlers

- (void) handleTap:(id)sender
{
    [tapDelegate handleTap:self];
    [self setActiveLook];
}


- (void) setNormalLook
{
    self.backgroundView.image = [UIImage imageNamed:@"inactiveDay_45x68.png"];
}


- (void) setActiveLook
{
    self.backgroundView.image = [UIImage imageNamed:@"activeDay_45x68.png"];
}



#pragma mark - Helpers

- (void) componentesFromDateString:(NSString*)ds day:(int*)d month:(int*)m year:(int*)y
{    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    NSDate* date = [df dateFromString:ds];
    [df release];

    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit 
                                                                   fromDate:date];
    *d = [components day];    
    *m = [components month];
    *y = [components year];
}



#pragma mark - Memory Management

- (void) dealloc
{
    [monthsNames release];
    [dateString release];
    [monthLabel release];
    [dayLabel release];
    [backgroundView release];
    [view release];
    [super dealloc];
}

@end
