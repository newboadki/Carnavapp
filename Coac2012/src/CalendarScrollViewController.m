//
//  CalendarScrollViewController.m
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "CalendarScrollViewController.h"
#import "RoundedCalendarBoxController.h"

@interface CalendarScrollViewController()

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *dayBoxControllers;

- (void) loadView;
- (NSString*) todaysDateString;
@end


@implementation CalendarScrollViewController



#pragma mark - Initializators

- (id) initWithDelegate:(id<ScrollableBoxTappedDelegateProtocol>)del andYearString:(NSString*)year modelData:(NSDictionary*)modelData
{
    self = [super init];
    
    if (self)
    {
        _dayBoxControllers = [[NSMutableArray alloc] init];
        _delegate = del;
        _yearString = [year copy];
        _modelData = [modelData retain];
    }
    
    return self;
}



#pragma mark - Accessors

- (UIView*) view
{
    if (!self.scrollView)
    {
        [self loadView];
    }
    
    return self.scrollView;
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
    self.scrollView = [sv retain];
    [sv release];
    self.scrollView.backgroundColor = [UIColor clearColor];
    
    // Resize scrollView contentSize
    self.scrollView.contentSize = CGSizeMake([[self allDaysForContestInYear:self.yearString] count]*45, 71); // Day boxes are 45x68, refactor to get this from the nib
    
    // Create the dayBoxes controllers
    for (int i=0; i<[[self allDaysForContestInYear:self.yearString] count]; i++)
    {
        
        NSString* dateString = [self allDaysForContestInYear:self.yearString][i];
        RoundedCalendarBoxController* controller = [[RoundedCalendarBoxController alloc] initWithTapDelegate:self andDateString:dateString andContestPhasesDatesInYear:self.modelData[DAYS_FOR_PHASES_KEY][self.yearString]];
        [self.dayBoxControllers addObject:controller];        

        // add the views        
        // set up the padding
        float pageWidth = controller.view.frame.size.width;
        pageWidth -= (2 * PADDING);
        CGRect pageFrame = CGRectMake(i*45+PADDING, 0, pageWidth, controller.view.frame.size.height);
        pageFrame.size.width -= (2 * PADDING); // The padding is added into the paginScrollViewBounds. So we substract it to calculate the width
        
        controller.view.frame = pageFrame;
        [self.scrollView addSubview:controller.view];
        [controller release];
    }
}


- (void) viewDidLoad
{
    // The view will be on the hierarchy already
    BOOL todayIsInTheList = NO;
    for (RoundedCalendarBoxController* cont in self.dayBoxControllers)
    {
        NSString* todaysDateString = [self todaysDateString];
        if ([cont.dateString isEqualToString:todaysDateString])
        {
            todayIsInTheList = YES;
            [cont setActiveLook];
            [self.scrollView scrollRectToVisible:cont.view.frame animated:YES];
        }

        [cont viewDidLoad];        
    }

    if (!todayIsInTheList)
    {
        if ([self.dayBoxControllers count] > 0)
        {
            RoundedCalendarBoxController* firstController = self.dayBoxControllers[0];
            [firstController setActiveLook];
        }
    }
}

- (void) viewDidUnload
{
    // We assume that this view will be contained by another one. That view's controller will execure viewDidUnload (our superview), so our view will be out of the hierarchy anyway. That's why I'm not calling [scrollView removeFromSuperview];
    for (RoundedCalendarBoxController* cont in self.dayBoxControllers)
    {
        [cont viewDidUnload];
    }
}


- (void) viewWillAppear:(BOOL)animated
{
    for (RoundedCalendarBoxController* cont in self.dayBoxControllers)
    {
        [cont viewWillAppear];
    }    
}


- (void) viewWillDisappear:(BOOL)animated
{    
    for (RoundedCalendarBoxController* cont in self.dayBoxControllers)
    {
        [cont viewWillDisappear];
    }
}



#pragma mark - Event Handlers

- (void) handleTap:(id) sender
{
    
    RoundedCalendarBoxController* tappedBox = (RoundedCalendarBoxController*)sender;
    for (RoundedCalendarBoxController* cont in self.dayBoxControllers)
    {
        if (cont != tappedBox)
        {
            [cont setNormalLook];
        }
    }
    
    [self.delegate scrollableBoxTappedWith:tappedBox.dateString];
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


- (NSArray*) allDaysForContestInYear:(NSString*)year
{
    NSMutableArray* result = [NSMutableArray array];
    NSArray* daysForPreliminaresInYear = self.modelData[DAYS_FOR_PHASES_KEY][year][PRELIMINAR];
    NSArray* daysForCuartosInYear = self.modelData[DAYS_FOR_PHASES_KEY][year][CUARTOS];
    NSArray* daysForSemifinalesInYear = self.modelData[DAYS_FOR_PHASES_KEY][year][SEMIFINALES];
    NSArray* daysForFinalInYear = self.modelData[DAYS_FOR_PHASES_KEY][year][FINAL];
    
    [result addObjectsFromArray:daysForPreliminaresInYear];
    [result addObjectsFromArray:daysForCuartosInYear];
    [result addObjectsFromArray:daysForSemifinalesInYear];
    [result addObjectsFromArray:daysForFinalInYear];
    
    return result;
}


#pragma mark - Memory Management

- (void) dealloc
{
    [_dayBoxControllers release];
    [_scrollView release];
    [_yearString release];
    [_modelData release];
    [super dealloc];
}

@end
