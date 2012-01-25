//
//  FirstViewController.h
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface TodayViewController : UITableViewController
{
    NSDictionary* modelData;
    NSArray* groupsForToday;
}

@property (nonatomic, retain) NSDictionary* modelData;
@property (nonatomic, retain) NSArray* groupsForToday;

@end
