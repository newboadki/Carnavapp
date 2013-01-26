//
//  VideoViewController.h
//  Coac2012
//
//  Created by Borja Arias Drake on 17/01/2013.
//  Copyright (c) 2013 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Video.h"

@interface VideoViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, retain) Video *video;
@property (nonatomic, retain) IBOutlet UIWebView *videoWebView;

@end
