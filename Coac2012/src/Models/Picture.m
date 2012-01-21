//
//  Picture.m
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "Picture.h"

@implementation Picture

@synthesize desc, url;

- (id) initWithDescription:(NSString*)theDesc url:(NSString*)theUrl
{
    self = [super init];
    
    if(self)
    {
        url =  [theUrl  copy];
        desc = [theDesc copy];
    }
    
    return self;
}


- (void) dealloc
{
    [url  release];
    [desc release];
    [super dealloc];
}


@end
