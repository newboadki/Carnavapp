//
//  Picture.m
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "Picture.h"

#define PIC_URL_KEY  @"picUrlKey"
#define PIC_DESC_KEY @"picDescKey"

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


- (id)initWithCoder:(NSCoder *)decoder
{
    if ([super init])
    {
        url = [[decoder decodeObjectForKey:PIC_URL_KEY] copy];
        desc = [[decoder decodeObjectForKey:PIC_DESC_KEY] copy];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.url forKey:PIC_URL_KEY];
    [encoder encodeObject:self.desc forKey:PIC_DESC_KEY];
}


- (void) dealloc
{
    [url  release];
    [desc release];
    [super dealloc];
}


@end
