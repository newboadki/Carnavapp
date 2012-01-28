//
//  LinkViewerViewController.m
//  Coac2012
//
//  Created by Borja Arias on 25/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "LinkViewerViewController.h"

@implementation LinkViewerViewController

@synthesize webView, link;


#pragma mark - Memory Management

- (void) dealloc
{
    [link release];
    [webView release];
    [super dealloc];
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



#pragma mark - UIWebViewDelegate protocol

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    UIActivityIndicatorView* activityIndicator = (UIActivityIndicatorView*)[self.view viewWithTag:1];
    activityIndicator.hidden = YES;

}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:link.url]];
    [webView loadRequest:request];
    self.title = link.desc;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [webView release];
    webView = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
