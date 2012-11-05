//
//  BSViewController.h
//  Coac2012
//
//  Created by Borja Arias on 19/05/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSViewController : NSObject
{
    @protected
    UIView *_view;
    NSString *_nibName;
    NSBundle *_nibBundle;
    
    BOOL _viewWillAppearHappened;
    BOOL _viewDidAppearHappened;
    BOOL _viewDidLoadHappened;
    BOOL _viewWillDisappearHappened;
    BOOL _viewDidDisappearHappened;
    BOOL _viewWillUnloadHappened;
    BOOL _viewDidUnloadHappened;

}

@property (nonatomic, retain) UIView *view;
@property (nonatomic, readonly, copy) NSString *nibName;
@property (nonatomic, readonly, retain) NSBundle *nibBundle;


- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle;
- (BOOL) isViewLoaded;

@end
