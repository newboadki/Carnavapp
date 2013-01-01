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

@property (nonatomic, retain) UIView* view;
@property (nonatomic, assign) id<ScrollableBoxTappedDelegateProtocol> delegate;
@property (nonatomic, copy) NSString *yearString;
@property (nonatomic, retain) NSDictionary* modelData;

- (id) initWithDelegate:(id<ScrollableBoxTappedDelegateProtocol>)del andYearString:(NSString*)year modelData:(NSDictionary*)modelData;

- (void) viewDidLoad;
- (void) viewDidUnload;
- (void) viewWillAppear:(BOOL)animated;
- (void) viewWillDisappear:(BOOL)animated;
- (void) handleTap:(id) sender;

@end
