//
//  GroupDetailViewController.m
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "GroupDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIApplication+PRPNetworkActivity.h"
#import "VideosForGroupViewController.h"
#import "VideoViewController.h"

#define DETAIL_LABEL_FONT_SIZE 14.0
#define BOTTOM_MARGIN 15.0

@interface GroupDetailViewController()
@property (nonatomic, retain) NSArray *groupDetailsTableViewDataSource;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellFromNib;
- (void) roundCornersForView:(UIView*)theView;
@end

@implementation GroupDetailViewController



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Stretch the background image
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.backgroundImage.frame = CGRectMake(self.backgroundImage.frame.origin.x, self.backgroundImage.frame.origin.y, screenWidth, screenHeight);
    
    // Show the Gruop's details
    if (self.group)
    {
        // Data Source
        self.groupDetailsTableViewDataSource = @[ @{@"key" : @"Modalidad:", @"value" : self.group.modalidad},
                                                  @{@"key" : @"Autor:",     @"value" : self.group.autor},
                                                  @{@"key" : @"Director:",  @"value" : self.group.director},
                                                  @{@"key" : @"Localidad:", @"value" : self.group.localidad} ];
        
        // Set Up title and group's name label
        self.title = NSLocalizedString(self.group.nombre, self.group.nombre);
        self.nameLabel.text = self.group.nombre;
        
        // Show video button.
        if ([self.group.videos count] > 0)
        {
            [self.videosButton setHidden:NO];
        }
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setImageWebView:nil];
    [self setBackgroundDefaultImage:nil];    
    [self setLoadingIndicator:nil];
    [self setVideosButton:nil];
    [self setNameLabel:nil];
    [self setScrollView:nil];
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // We need to do this geometry related operations in viewWillAppear
    [self setDimensionsOfDetailsTableView];
    [self setDimensionsOfScrollView];
    
    // By loading the image view here, we allow after-regaining-conectivity recovery
    [self setUpImageView];
}


- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] prp_popNetworkActivity];    
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



#pragma mark - Helpers

- (void) roundCornersForView:(UIView*)theView
{
    CALayer* layer = theView.layer;
    [layer setBorderWidth:0.5];
    [layer setCornerRadius:6.0];
    [layer setBorderColor:[[UIColor blackColor] CGColor]];    
}


- (void) setDimensionsOfDetailsTableView
{
    float height = 0.0;
    for (NSDictionary* detail in self.groupDetailsTableViewDataSource)
    {
        NSString* value = detail[@"value"];
        height += [self sizeOfCellForText:value].height;
    }
    
    CGRect newFrame = self.groupDetailsTableView.frame;
    newFrame.size.height = height;
    self.groupDetailsTableView.frame = newFrame;
}


- (void) setDimensionsOfScrollView
{
    CGFloat scrollViewWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat scrollViewHeight = self.groupDetailsTableView.frame.origin.y + self.groupDetailsTableView.frame.size.height;
    self.scrollView.contentSize = CGSizeMake(scrollViewWidth, scrollViewHeight + BOTTOM_MARGIN);
}


- (void) setUpImageView
{
    if ([self.group.urlFoto length] > 0)// The webView is transparent, if there's no url we are then showing the default image.
    {
        NSURL *url = [NSURL URLWithString:self.group.urlFoto];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [self.imageWebView loadRequest:requestObj];
    }
    [self roundCornersForView:self.imageWebView];
    [self roundCornersForView:self.backgroundDefaultImage];
}



#pragma UIWEbViewDelegate protocol

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.loadingIndicator setHidden:NO];
    [self.loadingIndicator startAnimating];
    [[UIApplication sharedApplication] prp_pushNetworkActivity];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.imageWebView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self.loadingIndicator stopAnimating];
        [[UIApplication sharedApplication] prp_popNetworkActivity];
    }];
}



#pragma mark - IBActions

- (IBAction) videosButtonPressed
{
    if ([self.group.videos count] > 0)
    {
        VideosForGroupViewController* controller = [[VideosForGroupViewController alloc] initWithNibName:@"BaseCoacListViewController" bundle:nil];
        
        [controller setElementsArray:self.group.videos];
        [[self navigationController] pushViewController:controller animated:YES];
        [controller release];
    }
}



#pragma mark - group details table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{    
	return [self.groupDetailsTableViewDataSource count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *detail = [self.groupDetailsTableViewDataSource objectAtIndex:indexPath.row];
    NSString *detailString = detail[@"value"];
    
    return [self sizeOfCellForText:detailString].height;
}


- (CGSize) sizeOfCellForText:(NSString*)text
{
    CGSize result = [text sizeWithFont:[UIFont systemFontOfSize:DETAIL_LABEL_FONT_SIZE] constrainedToSize:CGSizeMake(176.0, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    return CGSizeMake(result.width, MAX(result.height, 25.0));
}


- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        self.cellFromNib = [[NSBundle mainBundle] loadNibNamed:@"GroupDetailCell" owner:self options:nil][0];
        cell = self.cellFromNib;
        self.cellFromNib = nil;
    }
    
    // Configure the cell...
    [self tableView:theTableView configureCell:cell indexPath:indexPath];
    
    return cell;
}


- (void) tableView:(UITableView*)theTableView configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath
{
    NSDictionary *detail = [self.groupDetailsTableViewDataSource objectAtIndex:indexpath.row];
    UILabel *keyLabel = (UILabel*)[cell viewWithTag:1];
    UILabel *valueLabel = (UILabel*)[cell viewWithTag:2];
    
    keyLabel.text = detail[@"key"];
    valueLabel.text = detail[@"value"];
    CGRect newFrame = valueLabel.frame;
    newFrame.size = [self sizeOfCellForText:detail[@"value"]];
    valueLabel.frame = newFrame;
    
    CGPoint newCenter = keyLabel.center;
    newCenter.y = valueLabel.center.y;
    keyLabel.center = newCenter;
    
    
    CGSize size = [self sizeOfCellForText:detail[@"value"]];
    newFrame.size = CGSizeMake(newFrame.size.width, size.height);
    cell.frame = newFrame;
}


- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}



#pragma mark - Memory Management

- (void) dealloc
{
    _imageWebView.delegate = nil;
    [_group release];
    [_nameLabel release];
    [_imageWebView release];
    [_backgroundDefaultImage release];
    [_loadingIndicator release];
    [_videosButton release];
    [_backgroundImage release];
    [_groupDetailsTableView release];
    [_groupDetailsTableViewDataSource release];
    [_scrollView release];
    [super dealloc];
}

@end
