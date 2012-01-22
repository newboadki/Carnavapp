//
//  Agrupacion.m
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "Agrupacion.h"
#import "Comentario.h"
#import "Componente.h"
#import "Video.h"
#import "Picture.h"

#define RESTING_GROUP_ID -1

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


- (id) initAsRestingGroup
{
    return [self initWithId:RESTING_GROUP_ID 
                   modality:nil 
                       name:nil 
                     author:nil 
                   director:nil 
                       city:nil 
                   coac2011:nil
              isHeadOfGroup:NO 
                       info:nil 
                      score:nil 
                   pictures:nil 
                     videos:nil 
                      urlCC:nil 
                    urlFoto:nil 
                  urlVideos:nil 
                   comments:nil 
                 components:nil];
}

+ (Agrupacion*) restingGroup
{
    return [[[self alloc] initAsRestingGroup] autorelease];
}


- (NSString*) description
{
    NSString* desc = @"";
    desc = [desc stringByAppendingString:@"=======================================================\n"];
    desc = [desc stringByAppendingFormat:@"= Nombre: %@\n", self.nombre];
    desc = [desc stringByAppendingFormat:@"= Modalidad: %@\n", self.modalidad];
    desc = [desc stringByAppendingFormat:@"= Ident: %ld\n", identificador];
    desc = [desc stringByAppendingFormat:@"= Autor: %@\n", self.autor];
    desc = [desc stringByAppendingFormat:@"= Director: %@\n", self.director];
    desc = [desc stringByAppendingFormat:@"= Localidad: %@\n", self.localidad];
    desc = [desc stringByAppendingFormat:@"= Coac2011: %@\n", self.coac2011];
    desc = [desc stringByAppendingFormat:@"= Cabeza de serie: %d\n", self.esCabezaDeSerie];
    desc = [desc stringByAppendingFormat:@"= Info: %@\n", self.info];
    desc = [desc stringByAppendingFormat:@"= urlCC: %@\n", self.urlCC];
    desc = [desc stringByAppendingFormat:@"= urlFoto: %@\n", self.urlFoto];
    desc = [desc stringByAppendingFormat:@"= urlVideo: %@\n", self.urlVideos];
    desc = [desc stringByAppendingFormat:@"= puntos: %@\n", self.puntos];
        
    desc = [desc stringByAppendingString:@"= Componentes - - - - \n"];
    for (Componente* c in self.componentes)
    {
        desc = [desc stringByAppendingFormat:@"- Nombre: %@, Voz:%@\n", c.nombre, c.voz];
    }
    desc = [desc stringByAppendingString:@"= - - - - - - - - - \n"];
    
    desc = [desc stringByAppendingString:@"=  Videos- - - - - - - - - \n"];
    for (Video* v in self.videos)
    {
        desc = [desc stringByAppendingFormat:@"- Desc: %@, URL:%@\n", v.desc, v.url];
    }
    desc = [desc stringByAppendingString:@"= - - - - - - - - - \n"];
    
    desc = [desc stringByAppendingString:@"= Pictures - - - - - - - - - \n"];
    for (Picture* p in self.fotos)
    {        
        desc = [desc stringByAppendingFormat:@"- Desc: %@, URL:%@\n", p.desc, p.url];
    }
    desc = [desc stringByAppendingString:@"= - - - - - - - - - \n"];
    
    desc = [desc stringByAppendingString:@"=Comments  - - - - - - - - - \n"];
    for (Comentario* c in self.comentatios)
    {   
        desc = [desc stringByAppendingFormat:@"- Origen: %@, URL:%@\n", c.origen, c.url];
    }
    desc = [desc stringByAppendingString:@"= - - - - - - - - - \n"];
    
    desc = [desc stringByAppendingString:@"=======================================================\n"];
    
    return desc;
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

