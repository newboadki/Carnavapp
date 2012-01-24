//
//  GroupDetailViewController.m
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "GroupDetailViewController.h"

@implementation GroupDetailViewController

@synthesize group;
@synthesize modalityLabel, authorLabel, directorLabel, cityLabel, nameLabel;
@synthesize imageWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (group)
    {
        self.title = NSLocalizedString(self.group.nombre, self.group.nombre);
        
        self.nameLabel.text = group.nombre;
        self.modalityLabel.text = [group.modalidad lowercaseString];
        self.authorLabel.text = group.autor;
        self.directorLabel.text = group.director;
        self.cityLabel.text = group.localidad;
        
        if ([group.urlFoto length] > 0) // The webView is transparent, if there's no url we are then showing the default image.
        {
            NSURL *url = [NSURL URLWithString:group.urlFoto];
            NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            [imageWebView loadRequest:requestObj];
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setModalityLabel:nil];
    [self setAuthorLabel:nil];
    [self setDirectorLabel:nil];
    [self setCityLabel:nil];    
    [self setNameLabel:nil];
    [self setImageWebView:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {
        modalityLabel.center = CGPointMake(300, 5);
    }
}

- (void) dealloc
{
    [group release];
    [nameLabel release];
    [modalityLabel release];
    [authorLabel release];
    [directorLabel release];
    [cityLabel release];
    [imageWebView release];
    [super dealloc];
}

@end
