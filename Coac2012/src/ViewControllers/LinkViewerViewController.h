//
//  LinkViewerViewController.h
//  Coac2012
//
//  Created by Borja Arias on 25/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Link.h"


@interface LinkViewerViewController : UIViewController
{
    IBOutlet UIWebView* webView;    
    Link* link;
}

@property (nonatomic, retain) UIWebView* webView;
@property (nonatomic, retain) Link* link;

@end
