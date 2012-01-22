//
//  GroupsForModalityViewController.h
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface GroupsForModalityViewController : UITableViewController
{
    NSDictionary* modelData;
    NSString* modality;
}

@property (nonatomic, retain) NSDictionary* modelData;
@property (nonatomic, retain) NSString* modality;

@end
