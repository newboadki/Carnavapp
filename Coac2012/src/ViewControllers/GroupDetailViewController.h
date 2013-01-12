//
//  GroupDetailViewController.h
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Agrupacion.h"


@interface GroupDetailViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, retain) Agrupacion*   group;
@property (nonatomic, retain) IBOutlet UILabel* nameLabel;

@property (nonatomic, retain) IBOutlet UIWebView* imageWebView;
@property (nonatomic, retain) IBOutlet UIImageView* backgroundDefaultImage;
@property (nonatomic, retain) IBOutlet UIImageView* backgroundImage;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* loadingIndicator;
@property (nonatomic, retain) IBOutlet UIButton* videosButton;
@property (nonatomic, retain) IBOutlet UITableView* groupDetailsTableView;
@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;

- (IBAction) videosButtonPressed;


@end
