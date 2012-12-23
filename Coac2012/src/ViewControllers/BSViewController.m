//
//  BSViewController.m
//  Coac2012
//
//  Created by Borja Arias on 19/05/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "BSViewController.h"

@implementation BSViewController

@synthesize view;
@synthesize nibName, nibBundle;



#pragma mark - Init

- (id)initWithNibName:(NSString *)theNibName bundle:(NSBundle *)theNibBundle
{
    self = [super init];
    
    if (self)
    {
        _nibName = [theNibName copy];
        _nibBundle = [theNibBundle retain];
    }
    
    return self;

}

- (id) init
{
    NSString *theNibName = [[self class] description];
    NSBundle *theNibBundle = [NSBundle bundleForClass:[self class]];
    
    return [self initWithNibName:theNibName bundle:theNibBundle];
}



#pragma mark - dealloc

- (void) dealloc
{
    [_nibName release];
    [_nibBundle release];
    [_view release];
    [super dealloc];
}



#pragma mark - Accessor Methods

- (UIView*) view
{
    if (!view)
    {
        [self loadView];
    }
    
    return view;
}



#pragma mark - Managing the View

- (void) loadView
{
    /************************************************************************************/
	/* Should not be called from subclasses.                                            */
	/************************************************************************************/	
    view = [[self.nibBundle loadNibNamed:self.nibName owner:self options:nil][0] retain];
}


- (BOOL) isViewLoaded
{
    return (self.view != nil);
}


- (void) viewDidLoad
{
    /************************************************************************************/
	/*This method will get called when the controller's view object exists.             */
	/************************************************************************************/	
    #ifdef DEBUG
        assert([self isViewLoaded]);
        _viewDidLoadHappened = YES;
    #endif
}


- (void)didReceiveMemoryWarning
{
    /************************************************************************************/
	/* According to Apple's docs, this is the only method that actually tries to release*/
    /* The view                                                                         */
	/************************************************************************************/	
    if (![self.view superview])
    {
        [self viewWillUnload];
        [_view release];
        _view = nil;        
        [self viewDidUnload];
        
        _viewWillAppearHappened = NO;
        _viewDidAppearHappened = NO;
        _viewDidLoadHappened = NO;
        _viewWillDisappearHappened = NO;
        _viewDidDisappearHappened = NO;
        _viewWillUnloadHappened = NO;
        _viewDidUnloadHappened = NO;
    }
}


- (void) viewWillUnload
{
    /************************************************************************************/
	/* Called by the container controller, right before the view is destroyed           */
	/************************************************************************************/	
    #ifdef DEBUG
        assert([self isViewLoaded]);
        _viewWillUnloadHappened = YES;
    #endif    
}


- (void) viewDidUnload
{
    /************************************************************************************/
	/* Called by the container controller, right after the view has been destroyed      */
	/************************************************************************************/
    #ifdef DEBUG
        assert(![self isViewLoaded]);
        _viewDidUnloadHappened = YES;
    #endif
}



#pragma mark - View Events

- (void) viewWillAppear:(BOOL)animated
{
    /************************************************************************************/
	/* Called by the container controller, right before the view has been added to the  */
    /* view hirarchy                                                                    */
	/************************************************************************************/	
    #ifdef DEBUG
        assert(_viewDidLoadHappened);
        assert([self.view superview] == nil);
        _viewWillAppearHappened = YES;
    #endif
}


- (void) viewDidAppear:(BOOL)animated
{
    /************************************************************************************/
	/* Called by the container controller, when view has been added to the hierarchy    */
	/************************************************************************************/	
    #ifdef DEBUG
        assert(_viewWillAppearHappened);
        assert([self.view superview] != nil);
        _viewDidAppearHappened = YES;
    #endif
}


- (void) viewWillDisappear:(BOOL)animated
{
    /************************************************************************************/
	/* Called by the container controller, right before the view will be removed from the*/
    /* view hirarchy                                                                    */
	/************************************************************************************/	
    #ifdef DEBUG
        assert(_viewDidAppearHappened);
        assert([self.view superview] != nil);
        _viewWillDisappearHappened = YES;
    #endif
}


- (void) viewDidDisappear:(BOOL)animated
{
    /************************************************************************************/
	/* Called by the container controller, when view has been removed to the hierarchy  */
	/************************************************************************************/	
    #ifdef DEBUG
        assert(_viewWillDisappearHappened);
        assert([self.view superview] == nil);
        _viewDidDisappearHappened = YES;
    #endif
}


- (void) viewWillLayoutSubviews{}
- (void) viewDidLayoutSubviews{}


@end
