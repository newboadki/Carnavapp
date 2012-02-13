//
//  SearchResultsTableViewController.h
//  Coac2012
//
//  Created by Borja Arias on 13/02/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultsTableViewController : UITableViewController
{
    NSArray* results;
    UITableViewCell* cellFromNib;
}

@property (nonatomic, retain) NSArray* results;
@property (nonatomic, assign) UITableViewCell* cellFromNib;

@end
