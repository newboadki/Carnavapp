//
//  Comentario.m
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "Comentario.h"

#define COMMENT_URL_KEY  @"commentUrlKey"
#define COMMENT_ORIGEN_KEY @"commentOrigenKey"

@implementation Comentario

@synthesize origen, url;

- (id) initWithOrigen:(NSString *)theOrigen url:(NSString *)theUrl
{
    self = [super init];
    
    if(self)
    {
        origen = [theOrigen copy];
        url = [theUrl copy];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ([super init])
    {
        url = [[decoder decodeObjectForKey:COMMENT_URL_KEY] copy];
        origen = [[decoder decodeObjectForKey:COMMENT_ORIGEN_KEY] copy];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.url forKey:COMMENT_URL_KEY];
    [encoder encodeObject:self.origen forKey:COMMENT_ORIGEN_KEY];
}

- (void) dealloc
{
    [origen release];
    [url release];
    [super dealloc];
}

@end
