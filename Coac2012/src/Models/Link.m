//
//  Link.m
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "Link.h"

@implementation Link

@synthesize type, desc, url;

- (id) initWithType:(NSString*)theType description:(NSString*)theDesc url:(NSString*)theUrl
{
    self = [super init];
    
    if(self)
    {
        type = [theType copy];
        url =  [theUrl  copy];
        desc = [theDesc copy];
    }
    
    return self;
}


- (void) dealloc
{
    [type release];
    [url  release];
    [desc release];
    [super dealloc];
}


@end
