//
//  ContestPhasesViewController.h
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContestPhasesViewController : UITableViewController
{
    NSArray* phases;
    NSDictionary* modelData;
}

@property (nonatomic, retain) NSDictionary* modelData;

@end
