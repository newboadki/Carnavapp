//
//  CalendarScrollViewController.m
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "CalendarScrollViewController.h"
#import "RoundedCalendarBoxController.h"
#import "ContestPhaseDatesHelper.h"

@interface CalendarScrollViewController()
- (void) loadView;
- (NSString*) todaysDateString;
@end


@implementation CalendarScrollViewController

@synthesize view=scrollView;
@synthesize dates;
@synthesize delegate;
@synthesize yearString = _yearString;


#pragma mark - Initializators

- (id) initWithDates:(NSArray*)theDates andDelegate:(id<ScrollableBoxTappedDelegateProtocol>)del andYearString:(NSString*)year
{
    self = [super init];
    
    if (self)
    {
        dates = [theDates retain];
        dayBoxControllers = [[NSMutableArray alloc] init];
        delegate = del;
        _yearString = [year copy];
    }
    
    return self;
}



#pragma mark - Accessors

- (UIView*) view
{
    if (!scrollView)
    {
        [self loadView];
    }
    
    return scrollView;
}



#pragma mark - View Related methods

#define PADDING 0.1

- (void) loadView
{
    // Create the view
    // will only be called once, only form the view getter.
    CGRect frame = [[UIScreen mainScreen] bounds];
    frame.origin.x -= PADDING;
    frame.size.width += (2 * PADDING);

    // Create the scroll view
    UIScrollView* sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 71)];// Day boxes are 50x50, refactor to get this from the nib 
    scrollView = [sv retain];
    [sv release];
    scrollView.backgroundColor = [UIColor clearColor];
    
    // Resize scrollView contentSize
    scrollView.contentSize = CGSizeMake([dates count]*45, 71); // Day boxes are 45x68, refactor to get this from the nib
    
    // Create the dayBoxes controllers
    for (int i=0; i<[dates count]; i++)
    {
        
        NSString* dateString = dates[i];
        RoundedCalendarBoxController* controller = [[RoundedCalendarBoxController alloc] initWithTapDelegate:self andDateString:dateString andContestPhasesDatesInYear:[ContestPhaseDatesHelper phasesDates][self.yearString]];
        [dayBoxControllers addObject:controller];        

        // add the views        
        // set up the padding
        float pageWidth = controller.view.frame.size.width;
        pageWidth -= (2 * PADDING);
        CGRect pageFrame = CGRectMake(i*45+PADDING, 0, pageWidth, controller.view.frame.size.height);
        pageFrame.size.width -= (2 * PADDING); // The padding is added into the paginScrollViewBounds. So we substract it to calculate the width
        
        controller.view.frame = pageFrame;
        [scrollView addSubview:controller.view];
        [controller release];
    }
}


- (void) viewDidLoad
{
    // The view will be on the hierarchy already
    BOOL todayIsInTheList = NO;
    for (RoundedCalendarBoxController* cont in dayBoxControllers)
    {
        NSString* todaysDateString = [self todaysDateString];
        if ([cont.dateString isEqualToString:todaysDateString])
        {
            todayIsInTheList = YES;
            [cont setActiveLook];            
        }

        [cont viewDidLoad];        
    }

    if (!todayIsInTheList)
    {
        RoundedCalendarBoxController* firstController = dayBoxControllers[0];
        [firstController setActiveLook];        
    }
}

- (void) viewDidUnload
{
    // We assume that this view will be contained by another one. That view's controller will execure viewDidUnload (our superview), so our view will be out of the hierarchy anyway. That's why I'm not calling [scrollView removeFromSuperview];
    for (RoundedCalendarBoxController* cont in dayBoxControllers)
    {
        [cont viewDidUnload];
    }
}


- (void) viewWillAppear:(BOOL)animated
{
    for (RoundedCalendarBoxController* cont in dayBoxControllers)
    {
        [cont viewWillAppear];
    }    
}


- (void) viewWillDisappear:(BOOL)animated
{    
    for (RoundedCalendarBoxController* cont in dayBoxControllers)
    {
        [cont viewWillDisappear];
    }
}



#pragma mark - Event Handlers

- (void) handleTap:(id) sender
{
    
    RoundedCalendarBoxController* tappedBox = (RoundedCalendarBoxController*)sender;
    for (RoundedCalendarBoxController* cont in dayBoxControllers)
    {
        if (cont != tappedBox)
        {
            [cont setNormalLook];
        }
    }
    
    [delegate scrollableBoxTappedWith:tappedBox.dateString];
}

- (NSString*) todaysDateString
{
    NSDate* today = [NSDate date];
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    NSString* todaysDateString = [df stringFromDate:today];
    [df release];
    
    return todaysDateString;
}


#pragma mark - Memory Management

- (void) dealloc
{
    [dayBoxControllers release];
    [scrollView release];    
    [dates release];
    [_yearString release];
    [super dealloc];
}

@end
