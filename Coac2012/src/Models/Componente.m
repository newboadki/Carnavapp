//
//  Componente.m
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "Componente.h"

@implementation Componente

@synthesize nombre, voz;

- (id) initWithName:(NSString*)name andVoice:(NSString*)voice
{
    self = [super init];
    
    if(self)
    {
        nombre = [name copy];
        voz = [voice copy];
    }
    
    return self;
}


- (void) dealloc
{
    [nombre release];
    [voz release];
    [super dealloc];
}


@end
