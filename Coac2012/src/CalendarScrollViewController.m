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
- (void) loadView;
- (void) componentesFromDateString:(NSString*)dateString day:(int*)d month:(int*)m year:(int*)y;
@end


@implementation CalendarScrollViewController

@synthesize view=scrollView;
@synthesize dates;
@synthesize delegate;

- (id) initWithDates:(NSArray*)theDates andDelegate:(id<ScrollableBoxTappedDelegateProtocol>)del
{
    self = [super init];
    
    if (self)
    {
        dates = [theDates retain];
        dayBoxControllers = [[NSMutableArray alloc] init];
        delegate = del;
    }
    
    return self;
}

- (UIView*) view
{
    if (!scrollView)
    {
        [self loadView];
    }
    
    return scrollView;
}

#define PADDING 1

- (void) loadView
{
    // Create the view
    // will only be called once, only form the view getter.
    CGRect frame = [[UIScreen mainScreen] bounds];
    frame.origin.x -= PADDING;
    frame.size.width += (2 * PADDING);

    // Create the scroll view
    UIScrollView* sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 54)];// Day boxes are 50x50, refactor to get this from the nib 
    scrollView = [sv retain];
    [sv release];
    scrollView.backgroundColor = [UIColor blackColor];
    
    // Resize scrollView contentSize
    scrollView.contentSize = CGSizeMake([dates count]*50, 54); // Day boxes are 50x50, refactor to get this from the nib
    
    // Create the dayBoxes controllers
    for (int i=0; i<[dates count]; i++)
    {
        NSString* dateString = [dates objectAtIndex:i];
        RoundedCalendarBoxController* controller = [[RoundedCalendarBoxController alloc] initWithTapDelegate:self andDateString:dateString];
        [dayBoxControllers addObject:controller];        
        
        // add the views        
        // set up the padding
        float pageWidth = controller.view.frame.size.width;
        pageWidth -= (2 * PADDING);
        CGRect pageFrame = CGRectMake(i*50+PADDING, 2, pageWidth, controller.view.frame.size.height);
        pageFrame.size.width -= (2 * PADDING); // The padding is added into the paginScrollViewBounds. So we substract it to calculate the width
        
        controller.view.frame = pageFrame;
        [scrollView addSubview:controller.view];
        [controller release];
    }
}

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
- (void) componentesFromDateString:(NSString*)dateString day:(int*)d month:(int*)m year:(int*)y
{

    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/mm/yyyy"];
    NSDate* date = [df dateFromString:dateString];
    [df release];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    *d = [components day];    
    *m = [components month];
    *y = [components year];
}

- (void) viewDidLoad
{
    // The view will be on the hierarchy already
    for (RoundedCalendarBoxController* cont in dayBoxControllers)
    {
        [cont viewDidLoad];        
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

- (void) viewWillAppear
{
    
}

- (void) viewWillDisappear
{
    
}



- (void) dealloc
{
    [dayBoxControllers release];
    [scrollView release];    
    [dates release];
    [super dealloc];
}

@end
