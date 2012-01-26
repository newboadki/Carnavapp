//
//  GroupsForModalityViewController.h
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCoacListViewController.h"

@interface GroupsForModalityViewController : BaseCoacListViewController
{
    NSString* modality;
}

@property (nonatomic, retain) NSString* modality;

@end
