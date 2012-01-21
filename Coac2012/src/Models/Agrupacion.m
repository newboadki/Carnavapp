//
//  Agrupacion.m
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "Agrupacion.h"

@implementation Agrupacion

@synthesize identificador;
@synthesize modalidad, nombre, autor, director, localidad;
@synthesize coac2011;
@synthesize esCabezaDeSerie;
@synthesize info;
@synthesize puntos;
@synthesize fotos, videos;
@synthesize urlCC, urlFoto, urlVideos;
@synthesize comentatios;
@synthesize componentes;



- (id) initWithId:(long int)theIdentifier modality:(NSString*)modality name:(NSString*)name author:(NSString*)theAuthor director:(NSString*)theDirector city:(NSString*)city coac2011:(NSString*)theCoac2011 isHeadOfGroup:(BOOL)isHead info:(NSString*)theInfo score:(NSString*)score pictures:(NSArray*)pictures videos:(NSArray*)theVideos urlCC:(NSString*)theUrlCC urlFoto:(NSString*)theUrlFoto urlVideos:(NSString*)theurlVideos comments:(NSArray*)comments components:(NSArray*)components
{
    self = [super init];
    
    if(self)
    {
        identificador = theIdentifier;
        modalidad = [modality copy];
        nombre = [name copy];
        autor = [theAuthor copy];
        director = [theDirector copy];
        localidad = [city copy];
        coac2011 = [theCoac2011 copy];
        esCabezaDeSerie = isHead;
        info = [theInfo copy];
        puntos = [score copy];
        urlCC = [theUrlCC copy];
        urlFoto = [theUrlFoto copy];
        urlVideos = [theurlVideos copy];

        fotos = [pictures retain];
        videos = [theVideos retain];
        componentes = [components retain];
        comentatios = [comments retain];
    }
    
    return self;
}


- (void) dealloc
{
    [modalidad release];
    [nombre release];
    [autor release];
    [director release];
    [localidad release];
    [coac2011 release];
    [info release];
    [puntos release];
    [urlCC release];
    [urlVideos release];
    [urlFoto release];
    [comentatios release];
    [componentes release];
    
    [super dealloc];
}

@end

