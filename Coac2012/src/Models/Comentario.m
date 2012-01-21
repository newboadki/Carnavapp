//
//  Comentario.m
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "Comentario.h"

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


- (void) dealloc
{
    [origen release];
    [url release];
    [super dealloc];
}

@end
