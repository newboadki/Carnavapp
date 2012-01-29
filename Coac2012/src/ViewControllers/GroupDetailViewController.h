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
{
    Agrupacion*   group;
    
    IBOutlet UILabel* nameLabel;
    IBOutlet UILabel* modalityLabel;
    IBOutlet UILabel* authorLabel;
    IBOutlet UILabel* directorLabel;
    IBOutlet UILabel* cityLabel;
    IBOutlet UIWebView* imageWebView;
    IBOutlet UIImageView* backgroundDefaultImage;
    IBOutlet UIActivityIndicatorView* loadingIndicator;
}

@property (nonatomic, retain) Agrupacion*   group;
@property (nonatomic, retain) UILabel* nameLabel;
@property (nonatomic, retain) UILabel* modalityLabel;
@property (nonatomic, retain) UILabel* authorLabel;
@property (nonatomic, retain) UILabel* directorLabel;
@property (nonatomic, retain) UILabel* cityLabel;
@property (nonatomic, retain) UIWebView* imageWebView;
@property (nonatomic, retain) UIImageView* backgroundDefaultImage;
@property (nonatomic, retain) UIActivityIndicatorView* loadingIndicator;

@end
