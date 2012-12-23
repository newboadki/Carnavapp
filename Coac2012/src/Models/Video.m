//
//  Video.m
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "Video.h"

#define VIDEO_URL_KEY  @"videoUrlKey"
#define VIDEO_DESC_KEY @"videoDescKey"


@implementation Video

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
    if (self = [super init])
    {
        url = [[decoder decodeObjectForKey:VIDEO_URL_KEY] copy];
        desc = [[decoder decodeObjectForKey:VIDEO_DESC_KEY] copy];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.url forKey:VIDEO_URL_KEY];
    [encoder encodeObject:self.desc forKey:VIDEO_DESC_KEY];
}


- (void) dealloc
{
    [url  release];
    [desc release];
    [super dealloc];
}

@end
