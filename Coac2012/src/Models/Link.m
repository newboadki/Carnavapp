//
//  Link.m
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "Link.h"

#define LINK_TYPE_KEY @"linkTypeKey"
#define LINK_URL_KEY @"linkUrlKey"
#define LINK_DESC_KEY @"linkDescKey"

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


- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        type = [[decoder decodeObjectForKey:LINK_TYPE_KEY] copy];
        url = [[decoder decodeObjectForKey:LINK_URL_KEY] copy];
        desc = [[decoder decodeObjectForKey:LINK_DESC_KEY] copy];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.type forKey:LINK_TYPE_KEY];
    [encoder encodeObject:self.url forKey:LINK_URL_KEY];
    [encoder encodeObject:self.desc forKey:LINK_DESC_KEY];
}


- (void) dealloc
{
    [type release];
    [url  release];
    [desc release];
    [super dealloc];
}


@end
