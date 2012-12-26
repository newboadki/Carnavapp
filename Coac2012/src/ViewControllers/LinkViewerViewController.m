//
//  LinkViewerViewController.m
//  Coac2012
//
//  Created by Borja Arias on 25/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "LinkViewerViewController.h"
#import "UIApplication+PRPNetworkActivity.h"

@implementation LinkViewerViewController



#pragma mark - Memory Management

- (void) dealloc
{
    [_link release];
    _webView.delegate = nil;
    [_webView release];
    [_loadingIndicator release];
    
    [super dealloc];    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



#pragma mark - UIWebViewDelegate protocol

- (void)webViewDidStartLoad:(UIWebView*)webView
{
    [self.loadingIndicator setHidesWhenStopped:NO];
    [self.loadingIndicator startAnimating];
    [[UIApplication sharedApplication] prp_pushNetworkActivity];
}


- (void)webViewDidFinishLoad:(UIWebView*)webView
{
    [self.loadingIndicator setHidesWhenStopped:YES];
    [self.loadingIndicator stopAnimating];
    [[UIApplication sharedApplication] prp_popNetworkActivity];
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.link.url]];
    [self.webView loadRequest:request];
    self.title = self.link.desc;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self.webView release];
    self.webView = nil;
    [self.loadingIndicator release];
    self.loadingIndicator = nil;
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] prp_popNetworkActivity];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
