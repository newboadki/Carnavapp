//
//  CoacEventDrivenParser.m
//  Coac2012
//
//  Created by Borja Arias on 03/03/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "CoacEventDrivenParser.h"

// XML Elements tags
#define GROUPS_TAG @"agrupaciones"
#define GROUP_TAG @"agrupacion"
#define CALENDAR_TAG @"calendario"
#define CALENDAR_DAY_ENTRY_TAG @"dia"
#define LINKS_TAG @"enlances"
#define LINK_TAG @"enlance"
#define COMPONENTS_TAG @"componentes"
#define COMPONENT_TAG @"componente"
#define COMMENTS_TAG @"comentarios"
#define COMMENT_TAG @"comentario"
#define VIDEOS_TAG @"videos"
#define VIDEO_TAG @"video"
#define PICTURES_TAG @"fotos"
#define PICTURE_TAG @"foto"

// Attributes
#define CALENDAR_DATE_ATTRIBUTE_NAME        @"fecha"
#define CALENDAR_POSITION_TAG_NAME          @"puesto"
#define CALENDAR_GROUP_ATTRIBUTE_NAME       @"agrupacion"
#define CALENDAR_REST_TOKEN                 @"DESCANSO"

#define URL_ATTRIBUTE_NAME             @"url"
#define TYPE_ATTRIBUTE_NAME            @"tipo"
#define DESCRIPTION_ATTRIBUTE_NAME     @"descripcion"
#define NAME_ATTRIBUTE @"nombre"
#define VOICE_ATTRIBUTE @"voz"
#define ORIGEN_ATTRIBUTE_NAME @"origen"

#define GROUP_NAME_ATTRIBUTE @"nombre"
#define GROUP_MODALITY_ATTRIBUTE @"modalidad"
#define GROUP_ID_ATTRIBUTE @"id"
#define GROUP_AUTHOR_ATTRIBUTE @"autor"
#define GROUP_DIRECTOR_ATTRIBUTE @"director"
#define GROUP_CITY_ATTRIBUTE @"localidad"
#define GROUP_COAC2011_ATTRIBUTE @"coac2011"
#define GROUP_HEAD_OF_GROUP_ATTRIBUTE @"cabeza_serie"
#define GROUP_INFO_ATTRIBUTE @"info"
#define GROUP_URL_CC_ATTRIBUTE @"url_cc"
#define GROUP_URL_PICTURE_ATTRIBUTE @"url_foto"
#define GROUP_URL_VIDEOS_ATTRIBUTE @"url_videos"
#define GROUP_SCORE_ATTRIBUTE @"puntos"


// Modalities
#define MODALIDAD_COMPARSA "COMPARSA";
#define MODALIDAD_CHIRIGOTA "CHIRIGOTA";
#define MODALIDAD_CORO "CORO";
#define MODALIDAD_CUARTETO "CUARTETO";
#define MODALIDAD_INFANTIL "INFANTIL";
#define MODALIDAD_JUVENIL "JUVENIL";
#define MODALIDAD_CALLEJERA "CALLEJERA";
#define MODALIDAD_ROMANCERO "ROMANCERO";

@implementation CoacEventDrivenParser

@synthesize xmlData, delegate;


- (id) initWithXMLData:(NSData*)theXml delegate:(id)theDelegate
{
	/************************************************************************************/
	/* Custom init method																*/
	/************************************************************************************/	
	if(self = [super init])
	{
		xmlData = [theXml retain];
        delegate = theDelegate;
        
        queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 1;
        
        nsParser = [[NSXMLParser alloc] initWithData:xmlData];
        [nsParser setDelegate:self];
	}
	
	return self;	
}



#pragma mark - NSXMLParserDelegate Protocol

- (void) parser: (NSXMLParser*)parser didStartElement: (NSString*)elementName
                                         namespaceURI: (NSString*)namespaceURI 
                                        qualifiedName: (NSString*)qName
                                           attributes: (NSDictionary*)attributeDict
{

    // Groups related tags
    if ([elementName isEqualToString:GROUPS_TAG])
    {
        if (!groups)
        {
            groups = [[NSMutableArray alloc] init];
        }
        
        return;
    }

    if ([elementName isEqualToString:GROUP_TAG])
    {
        currentGroup = [[Agrupacion alloc] init];
        
        NSString* idString = [attributeDict objectForKey:GROUP_ID_ATTRIBUTE];
        NSString* modalityString = [attributeDict objectForKey:GROUP_MODALITY_ATTRIBUTE];
        NSString* nameString = [attributeDict objectForKey:GROUP_NAME_ATTRIBUTE];
        NSString* authorString = [attributeDict objectForKey:GROUP_AUTHOR_ATTRIBUTE];
        NSString* directorString = [attributeDict objectForKey:GROUP_DIRECTOR_ATTRIBUTE];
        NSString* cityString = [attributeDict objectForKey:GROUP_CITY_ATTRIBUTE];
        NSString* coac2011String = [attributeDict objectForKey:GROUP_COAC2011_ATTRIBUTE];        
        NSString* headString = [attributeDict objectForKey:GROUP_HEAD_OF_GROUP_ATTRIBUTE];
        NSString* infoString = [attributeDict objectForKey:GROUP_INFO_ATTRIBUTE];
        NSString* urlCCString = [attributeDict objectForKey:GROUP_URL_CC_ATTRIBUTE];
        NSString* urlPictureString = [attributeDict objectForKey:GROUP_URL_PICTURE_ATTRIBUTE];
        NSString* urlVideosString = [attributeDict objectForKey:GROUP_URL_VIDEOS_ATTRIBUTE];
        NSString* scoreString = [attributeDict objectForKey:GROUP_SCORE_ATTRIBUTE];
                
        if (idString)
        {
            [currentGroup setIdentificador:[NSNumber numberWithInt:idString]];
        }
        
        if (modalityString)
        {
            [currentGroup setModalidad:modalityString];
        }

        if (nameString)
        {
            [currentGroup setNombre:nameString];
        }
        
        if (authorString)
        {
            [currentGroup setAutor:authorString];
        }
        
        if (directorString)
        {
            [currentGroup setDirector:directorString];
        }
        
        if (cityString)
        {
            [currentGroup setLocalidad:cityString];
        }
        
        if (coac2011String)
        {
            [currentGroup setCoac2011:coac2011String];
        }
        
        if (headString)
        {            
            [currentGroup setEsCabezaDeSerie:[NSNumber numberWithBool:[headString boolValue]]];
        }
        
        if (infoString)
        {
            [currentGroup setInfo:infoString];
        }
        
        if (urlCCString)
        {
            [currentGroup setUrlCC:urlCCString];
        }
        
        if (urlPictureString)
        {
            [currentGroup setUrlFoto:urlPictureString];
        }
        
        if (urlVideosString)
        {
            [currentGroup setUrlVideos:urlVideosString];
        }
        
        if (scoreString)
        {
            [currentGroup setPuntos:scoreString];
        }
        
        return;
    }

    if ([elementName isEqualToString:VIDEOS_TAG])
    {
        NSMutableArray* videos = [NSMutableArray array];
        [currentGroup setVideos:videos];
        
        return;
    }
    
    if ([elementName isEqualToString:VIDEO_TAG])
    {
        currentVideo = [[Video alloc] init];
        
        NSString* description = [attributeDict objectForKey:DESCRIPTION_ATTRIBUTE_NAME];
        NSString* url = [attributeDict objectForKey:URL_ATTRIBUTE_NAME];
        
        if (description)
        {
            [currentVideo setDesc:description];
        }

        if (url)
        {
            [currentVideo setUrl:url];
        }
        
        return;
    }


    if ([elementName isEqualToString:COMMENTS_TAG])
    {
        NSMutableArray* comments = [NSMutableArray array];
        [currentGroup setComentarios:comments];
   
        return;
    }


    if ([elementName isEqualToString:COMMENT_TAG])
    {
        currentComment = [[Comentario alloc] init];
        
        NSString* origen = [attributeDict objectForKey:ORIGEN_ATTRIBUTE_NAME];
        NSString* url = [attributeDict objectForKey:URL_ATTRIBUTE_NAME];
        
        if (origen)
        {
            [currentComment setOrigen:origen];
        }
        
        if (url)
        {
            [currentComment setUrl:url];
        }

        return;
    }
    
    if ([elementName isEqualToString:COMPONENTS_TAG])
    {
        NSMutableArray* componets = [NSMutableArray array];
        [currentGroup setComponentes:componets];

        return;
    }

    if ([elementName isEqualToString:COMPONENT_TAG])
    {        
        currentComponent = [[Componente alloc] init];
        
        NSString* name = [attributeDict objectForKey:NAME_ATTRIBUTE];
        NSString* voice = [attributeDict objectForKey:VOICE_ATTRIBUTE];
        
        if (name)
        {
            [currentComponent setName:origen];
        }
        
        if (voice)
        {
            [currentComponent setVoz:voice];
        }

        return;
    }



    if ([elementName isEqualToString:PICTURES_TAG])
    {
        NSMutableArray* pictures = [NSMutableArray array];
        [currentGroup setFotos:pictures];

        return;
    }
    
    if ([elementName isEqualToString:PICTURE_TAG])
    {
        currentPicture = [[Foto alloc] init];
        
        NSString* description = [attributeDict objectForKey:DESCRIPTION_ATTRIBUTE_NAME];
        NSString* url = [attributeDict objectForKey:URL_ATTRIBUTE_NAME];
        
        if (description)
        {
            [currentPicture setDesc:description];
        }
        
        if (url)
        {
            [currentPicture setUrl:url];
        }

        return;
    }


    // Calendar related tags
    if ([elementName isEqualToString:CALENDAR_TAG])
    {
        if (!calendar)
        {        
            calendar = [[NSMutableDictionary alloc] init];
        }
        
        return;
    }

    if ([elementName isEqualToString:DAY_TAG])
    {
        NSString* dateString = [attributeDict objectForKey:CALENDAR_DATE_ATTRIBUTE_NAME];
        currentDate = dateString;
        [calendar setObject:[NSMutableArray array] forKey:dateString];        
        return;
    }

    if ([elementName isEqualToString:CALENDAR_POSITION_TAG_NAME])
    {
        NSString* groupIdString = [attributeDict objectForKey:CALENDAR_GROUP_ATTRIBUTE_NAME];
         // Agrupacion* ag = findAgWithID;
        
        if (ag)
        {
            NSMutableArray* groupsForDate = [calendar objectForKey:currentDate];
            [groupsForDate addObject:ag];
        }
    }
    
    
    
    // Links related tags
    if ([elementName isEqualToString:LINKS_TAG])
    {
        if (!links)
        {
            links = [[NSMutableArray alloc] init];
        }
        
        return;
    }
    
    if ([elementName isEqualToString:LINKS_TAG])
    {
        currentLink = [[Link alloc] init];
        
        NSString* type = [attributeDict objectForKey:TYPE_ATTRIBUTE_NAME];
        NSString* description = [attributeDict objectForKey:DESCRIPTION_ATTRIBUTE_NAME];
        NSString* url = [attributeDict objectForKey:URL_ATTRIBUTE_NAME];

        if (type)
        {
            [currentLink setType:type];
        }

        if (description)
        {
            [currentLink setDesc:description];
        }
        
        if (url)
        {
            [currentLink setUrl:url];
        }
        
        return;
    }

}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    // Groups related tags
    if ([elementName isEqualToString:GROUPS_TAG] || [elementName isEqualToString:CALENDAR_TAG] || [elementName isEqualToString:LINKS_TAG] || [elementName isEqualToString:VIDEOS_TAG] || [elementName isEqualToString:PICTURES_TAG] || [elementName isEqualToString:COMMENTS_TAG] || [elementName isEqualToString:COMPONENTS_TAG] || [elementName isEqualToString:CALENDAR_POSITION_TAG_NAME] || [elementName isEqualToString:DAY_TAG])
    {        
        return;
    }
    
    if ([elementName isEqualToString:GROUP_TAG])
    {
        [groups addObject:currentGroup];
        [currentGroup release];
        return;
    }
    
    if ([elementName isEqualToString:VIDEO_TAG])
    {
        [[currentGroup videos] addObject:currentVideo];
        [currentVideo release];
        return;
    }
    
    if ([elementName isEqualToString:COMMENT_TAG])
    {
        [[currentGroup comentarios] addObject:currentComment];
        [currentComment release];
        return;
    }
    
    
    if ([elementName isEqualToString:PICTURE_TAG])
    {
        [[currentGroup fotos] addObject:currentPicture];
        [currentPicture release];
        return;
    }
    
    
    if ([elementName isEqualToString:LINK_TAG])
    {
        [[currentGroup enlances] addObject:currentLink];
        [currentLink release];

        return;
    }    
}


#pragma mark - Helpers



#pragma mark - Memory management

- (void) dealloc
{
	/************************************************************************************/
	/* Tidy-up.																			*/
	/************************************************************************************/	
	[xmlData release];
    [queue release];
    [nsParser release];
    
	[super dealloc];
}


@end
