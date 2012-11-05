//
//  CalendarScrollViewController.h
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScrollableBoxTappedDelegateProtocol.h"


@interface CalendarScrollViewController : NSObject
{
    UIScrollView* scrollView;
    @private    
    NSArray* dates;
    NSMutableArray* dayBoxControllers;
    id<ScrollableBoxTappedDelegateProtocol> delegate;
}

@property (nonatomic, retain) UIView* view;
@property (nonatomic, retain) NSArray* dates;
@property (nonatomic, assign) id<ScrollableBoxTappedDelegateProtocol> delegate;

- (id) initWithDates:(NSArray*)theDates andDelegate:(id<ScrollableBoxTappedDelegateProtocol>)del;

- (void) viewDidLoad;
- (void) viewDidUnload;
- (void) viewWillAppear:(BOOL)animated;
- (void) viewWillDisappear:(BOOL)animated;

- (void) handleTap:(id) sender;

@end
