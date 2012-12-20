//
//  Agrupacion.h
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Agrupacion : NSObject <NSCoding>
{
    @private
    NSNumber*  identificador;
    NSString* modalidad;
    NSString* nombre;
    NSString* autor;
    NSString* director;
    NSString* localidad;
    NSString* coac2011;
    NSNumber* esCabezaDeSerie;
    NSString* info;
    NSString* urlCC;
    NSString* urlFoto;
    NSString* urlVideos;
    NSString* puntos;
    NSArray*  fotos;
    NSArray*  videos;
    NSArray*  componentes;
    NSArray*  comentatios;
}

@property (nonatomic, retain) NSNumber* identificador;
@property (nonatomic, copy)   NSString* modalidad;
@property (nonatomic, copy)   NSString* nombre;
@property (nonatomic, copy)   NSString* autor;
@property (nonatomic, copy)   NSString* director;
@property (nonatomic, copy)   NSString* localidad;
@property (nonatomic, copy)   NSString* coac2011;
@property (nonatomic, retain) NSNumber* esCabezaDeSerie;
@property (nonatomic, copy)   NSString* info;
@property (nonatomic, copy)   NSString* urlCC;
@property (nonatomic, copy)   NSString* urlFoto;
@property (nonatomic, copy)   NSString* urlVideos;
@property (nonatomic, copy)   NSString* puntos;
@property (nonatomic, retain) NSArray*  fotos;
@property (nonatomic, retain) NSArray*  videos;
@property (nonatomic, retain) NSArray*  componentes;
@property (nonatomic, retain) NSArray*  comentatios;

- (id) initAsRestingGroup;

- (id) initWithId:(NSNumber*)theIdentifier
         modality:(NSString*)modality 
             name:(NSString*)name 
           author:(NSString*)theAuthor 
         director:(NSString*)theDirector 
             city:(NSString*)city 
         coac2011:(NSString*)theCoac2011 
    isHeadOfGroup:(NSNumber*)isHead 
             info:(NSString*)theInfo 
            score:(NSString*)score 
         pictures:(NSArray*)pictures 
           videos:(NSArray*)theVideos 
            urlCC:(NSString*)theUrlCC 
          urlFoto:(NSString*)theUrlFoto 
        urlVideos:(NSString*)theurlVideos 
         comments:(NSArray*)comments 
       components:(NSArray*)components;

+ (Agrupacion*) restingGroup;
- (BOOL) isRestingGroup;


@end
