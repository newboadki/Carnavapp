//
//  VideoViewController.m
//  Coac2012
//
//  Created by Borja Arias Drake on 17/01/2013.
//  Copyright (c) 2013 Borja Arias Drake. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()

@end

@implementation VideoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.video.desc;
    
    NSString *videoID = [self.video.url componentsSeparatedByString:@"v="][1];
    NSString *videoWidth = [NSString stringWithFormat:@"%d", (int)self.videoWebView.frame.size.width];
    NSString *videoHeight = [NSString stringWithFormat:@"%d", (int)self.videoWebView.frame.size.height];
    NSString *videoURL = [NSString stringWithFormat:@"http://www.youtube.com/v/%@", videoID ];
    
    // This HTML has the dimensions of the thumbnail of the video
    NSString *htmlString = [NSString stringWithFormat:@"<html><head><meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = %@\"/></head><body style=\"background:#000;margin-top:0px;margin-left:0px\"><div><object width=\"%@\" height=\"%@\"><param name=\"movie\" value=\"%@\"></param><param name=\"wmode\" value=\"transparent\"></param><embed src=\"%@\"type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"%@\" height=\"%@\"></embed></object></div></body></html>",videoWidth, videoWidth, videoHeight, videoURL, videoURL, videoWidth, videoHeight];
    
    // This is just the thumbnail !
    [self.videoWebView loadHTMLString:htmlString baseURL:[NSURL URLWithString:videoURL]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}


- (void)dealloc
{
    [_video release];
    [_videoWebView release];
    [super dealloc];
}
@end
