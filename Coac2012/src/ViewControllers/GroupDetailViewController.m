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
    // Do any additional setup after loading the view from its nib.
    if (group)
    {
        self.nameLabel.text = group.nombre;
        self.modalityLabel.text = [group.modalidad lowercaseString];
        self.authorLabel.text = group.autor;
        self.directorLabel.text = group.director;
        self.cityLabel.text = group.localidad;
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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) dealloc
{
    [group release];
    [nameLabel release];
    [modalityLabel release];
    [authorLabel release];
    [directorLabel release];
    [cityLabel release];
    [super dealloc];
}

@end
