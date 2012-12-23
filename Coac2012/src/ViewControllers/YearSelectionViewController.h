//
//  YearSelectionViewController.h
//  Coac2012
//
//  Created by Borja Arias Drake on 25/11/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "BaseCoacListViewController.h"

@interface YearSelectionViewController : BaseCoacListViewController

/** This is a generic class, therefore it can take to different view controllers. This property stores the class of the 
 view controller this class will take you to when tapping on a row.*/
@property (nonatomic, assign) Class classOfTheNextViewController;
@property (nonatomic, copy)   NSString* nibNameOfTheNextViewController;
@property (nonatomic, retain) NSDictionary *keyValuesToSetInNewInstance;
@end
