//
//  LoadingScreenViewController.m
//  Coac2012
//
//  Created by Borja Arias Drake on 14/12/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "LoadingScreenViewController.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface LoadingScreenViewController ()

@end

@implementation LoadingScreenViewController

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

    if (IS_IPHONE_5)
    {
        self.imageView.image = [UIImage imageNamed:@"Default-568h@2x.png"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
