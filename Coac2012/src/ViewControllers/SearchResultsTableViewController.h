//
//  SearchResultsTableViewController.h
//  Coac2012
//
//  Created by Borja Arias on 13/02/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchResultsTableViewControllerDelegateProtocol <NSObject>
- (void)selectedElement:(id)element;
@end

@interface SearchResultsTableViewController : UITableViewController
{
    NSArray* results;
    UITableViewCell* cellFromNib;
    NSDictionary* modelData;
    id<SearchResultsTableViewControllerDelegateProtocol> selectionDelegate;
}

@property (nonatomic, retain) NSArray* results;
@property (nonatomic, retain) NSDictionary* modelData;
@property (nonatomic, assign) UITableViewCell* cellFromNib;
@property (nonatomic, assign) id<SearchResultsTableViewControllerDelegateProtocol> selectionDelegate;

@end
