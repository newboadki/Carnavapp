//
//  Componente.m
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "Componente.h"

#define COMPONENT_NAME_KEY @"componentNameKey"
#define COMPONENT_VOICE_KEY @"componentVoiceKey"

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


- (id)initWithCoder:(NSCoder *)decoder
{
    if ([super init])
    {
        nombre = [[decoder decodeObjectForKey:COMPONENT_NAME_KEY] copy];
        voz = [[decoder decodeObjectForKey:COMPONENT_VOICE_KEY] copy];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.nombre forKey:COMPONENT_NAME_KEY];
    [encoder encodeObject:self.voz forKey:COMPONENT_VOICE_KEY];
}


- (void) dealloc
{
    [nombre release];
    [voz release];
    [super dealloc];
}


@end
