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

#define GROUP_ID_KEY @"groupIdKey"
#define GROUP_MODALITY_KEY @"groupModalityKey"
#define GROUP_NAME_KEY @"groupNameKey"
#define GROUP_AUTHOR_KEY @"groupAuthorKey"
#define GROUP_DIRECTOR_KEY @"groupDirectorKey"
#define GROUP_CITY_KEY @"GroupCityKey"
#define GROUP_COAC2011_KEY @"groupCoac2011Key"
#define GROUP_HEAD_KEY @"groupHeadKey"
#define GROUP_INFO_KEY @"groupInfoKey"
#define GROUP_SCORE_KEY @"groupScoreKey"
#define GROUP_PICTURES_KEY @"geoupPicturesKey"
#define GROUP_VIDEOS_KEY @"groupVideosKey"
#define GROUP_URLCC_KEY @"groupUrlCCKey"
#define GROUP_URL_PIC_KEY @"groupUrlPicKey"
#define GROUP_URL_VIDEOS_KEY @"groupUrlVideosKey"
#define GROUP_COMMENTS_KEY @"groupCommentsKey"
#define GROUP_COMPONENTS_KEY @"groupComponentsKey"


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


- (id) initWithId:(NSNumber*)theIdentifier modality:(NSString*)modality name:(NSString*)name author:(NSString*)theAuthor director:(NSString*)theDirector city:(NSString*)city coac2011:(NSString*)theCoac2011 isHeadOfGroup:(NSNumber*)isHead info:(NSString*)theInfo score:(NSString*)score pictures:(NSArray*)pictures videos:(NSArray*)theVideos urlCC:(NSString*)theUrlCC urlFoto:(NSString*)theUrlFoto urlVideos:(NSString*)theurlVideos comments:(NSArray*)comments components:(NSArray*)components
{
    self = [super init];
    
    if(self)
    {
        identificador = [theIdentifier retain];
        modalidad = [modality copy];
        nombre = [name copy];
        autor = [theAuthor copy];
        director = [theDirector copy];
        localidad = [city copy];
        coac2011 = [theCoac2011 copy];
        esCabezaDeSerie = [isHead retain];
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
    return [self initWithId:@RESTING_GROUP_ID 
                   modality:nil 
                       name:nil 
                     author:nil 
                   director:nil 
                       city:nil 
                   coac2011:nil
              isHeadOfGroup:@NO
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


- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        identificador = [[decoder decodeObjectForKey:GROUP_ID_KEY] copy];
        modalidad = [[decoder decodeObjectForKey:GROUP_MODALITY_KEY] copy];
        nombre = [[decoder decodeObjectForKey:GROUP_NAME_KEY] copy];
        autor = [[decoder decodeObjectForKey:GROUP_AUTHOR_KEY] copy];
        director = [[decoder decodeObjectForKey:GROUP_DIRECTOR_KEY] copy];
        localidad = [[decoder decodeObjectForKey:GROUP_CITY_KEY] copy];
        coac2011 = [[decoder decodeObjectForKey:GROUP_COAC2011_KEY] copy];
        esCabezaDeSerie = [[decoder decodeObjectForKey:GROUP_HEAD_KEY] copy];
        info = [[decoder decodeObjectForKey:GROUP_INFO_KEY] copy];
        puntos = [[decoder decodeObjectForKey:GROUP_SCORE_KEY] copy];
        fotos = [[decoder decodeObjectForKey:GROUP_PICTURES_KEY] copy];
        videos = [[decoder decodeObjectForKey:GROUP_VIDEOS_KEY] copy];
        urlCC = [[decoder decodeObjectForKey:GROUP_URLCC_KEY] copy];
        urlFoto = [[decoder decodeObjectForKey:GROUP_URL_PIC_KEY] copy];
        urlVideos = [[decoder decodeObjectForKey:GROUP_URL_VIDEOS_KEY] copy];
        comentatios = [[decoder decodeObjectForKey:GROUP_COMMENTS_KEY] copy];
        componentes = [[decoder decodeObjectForKey:GROUP_COMPONENTS_KEY] copy];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.identificador forKey:GROUP_ID_KEY];
    [encoder encodeObject:self.modalidad forKey:GROUP_MODALITY_KEY];
    [encoder encodeObject:self.nombre forKey:GROUP_NAME_KEY];
    [encoder encodeObject:self.autor forKey:GROUP_AUTHOR_KEY];
    [encoder encodeObject:self.director forKey:GROUP_DIRECTOR_KEY];
    [encoder encodeObject:self.localidad forKey:GROUP_CITY_KEY];
    [encoder encodeObject:self.coac2011 forKey:GROUP_COAC2011_KEY];
    [encoder encodeObject:self.esCabezaDeSerie forKey:GROUP_HEAD_KEY];
    [encoder encodeObject:self.info forKey:GROUP_INFO_KEY];
    [encoder encodeObject:self.puntos forKey:GROUP_SCORE_KEY];
    [encoder encodeObject:self.fotos forKey:GROUP_PICTURES_KEY];
    [encoder encodeObject:self.videos forKey:GROUP_VIDEOS_KEY];
    [encoder encodeObject:self.urlCC forKey:GROUP_URLCC_KEY];
    [encoder encodeObject:self.urlFoto forKey:GROUP_URL_PIC_KEY];
    [encoder encodeObject:self.urlVideos forKey:GROUP_URL_VIDEOS_KEY];
    [encoder encodeObject:self.comentatios forKey:GROUP_COMMENTS_KEY];
    [encoder encodeObject:self.componentes forKey:GROUP_COMPONENTS_KEY];
}


+ (Agrupacion*) restingGroup
{
    return [[[self alloc] initAsRestingGroup] autorelease];
}


- (BOOL) isRestingGroup
{
    return [self.identificador integerValue] == RESTING_GROUP_ID;
}


- (NSString*) description
{
    NSString* desc = @"";
    desc = [desc stringByAppendingString:@"=======================================================\n"];
    desc = [desc stringByAppendingFormat:@"= Nombre: %@\n", self.nombre];
    desc = [desc stringByAppendingFormat:@"= Modalidad: %@\n", self.modalidad];
    desc = [desc stringByAppendingFormat:@"= Ident: %ld\n", [identificador longValue]];
    desc = [desc stringByAppendingFormat:@"= Autor: %@\n", self.autor];
    desc = [desc stringByAppendingFormat:@"= Director: %@\n", self.director];
    desc = [desc stringByAppendingFormat:@"= Localidad: %@\n", self.localidad];
    desc = [desc stringByAppendingFormat:@"= Coac2011: %@\n", self.coac2011];
    desc = [desc stringByAppendingFormat:@"= Cabeza de serie: %d\n", [self.esCabezaDeSerie boolValue]];
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

