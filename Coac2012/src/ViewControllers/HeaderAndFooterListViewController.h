//
//  HeaderAndFooterListViewController.h
//  Coac2012
//
//  Created by Borja Arias Drake on 25/11/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "BaseCoacListViewController.h"

@interface HeaderAndFooterListViewController : BaseCoacListViewController


- (NSString*) headerCellNibName;
- (NSString*) footerCellNibName;

- (NSInteger) numberOfSections;//make protected
@end
