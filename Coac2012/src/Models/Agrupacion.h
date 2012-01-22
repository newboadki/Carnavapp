//
//  Agrupacion.h
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Agrupacion : NSObject
{
    @private
    long int  identificador;
    NSString* modalidad;
    NSString* nombre;
    NSString* autor;
    NSString* director;
    NSString* localidad;
    NSString* coac2011;
    BOOL      esCabezaDeSerie;
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

@property (nonatomic, assign) long int  identificador;
@property (nonatomic, copy)   NSString* modalidad;
@property (nonatomic, copy)   NSString* nombre;
@property (nonatomic, copy)   NSString* autor;
@property (nonatomic, copy)   NSString* director;
@property (nonatomic, copy)   NSString* localidad;
@property (nonatomic, copy)   NSString* coac2011;
@property (nonatomic, assign) BOOL      esCabezaDeSerie;
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

- (id) initWithId:(long int)theIdentifier
         modality:(NSString*)modality 
             name:(NSString*)name 
           author:(NSString*)theAuthor 
         director:(NSString*)theDirector 
             city:(NSString*)city 
         coac2011:(NSString*)theCoac2011 
    isHeadOfGroup:(BOOL)isHead 
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

@end
