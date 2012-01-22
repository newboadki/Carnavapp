//
//  Parser.m
//  DownloadFromURL
//
//  Created by Borja Arias Drake on 25/09/2010.
//  Copyright 2010 Borja Arias Drake. All rights reserved.
//

#import "CoacParser.h"
#import "Agrupacion.h"
#import "Componente.h"
#import "Video.h"
#import "Picture.h"
#import "Comentario.h"
#import "Link.h"


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

#define COMPONENTS_TAG @"componentes"
#define COMPONENT_TAG @"componente"
#define COMMENTS_TAG @"comentarios"
#define COMMENT_TAG @"comentario"
#define VIDEOS_TAG @"videos"
#define VIDEO_TAG @"video"
#define PICTURES_TAG @"fotos"
#define PICTURE_TAG @"foto"

#define MODALIDAD_COMPARSA "COMPARSA";
#define MODALIDAD_CHIRIGOTA "CHIRIGOTA";
#define MODALIDAD_CORO "CORO";
#define MODALIDAD_CUARTETO "CUARTETO";
#define MODALIDAD_INFANTIL "INFANTIL";
#define MODALIDAD_JUVENIL "JUVENIL";
#define MODALIDAD_CALLEJERA "CALLEJERA";
#define MODALIDAD_ROMANCERO "ROMANCERO";




@interface CoacParser(private)
- (void) storeNode:(CXMLElement*)node asClass:(Class*) klass;
- (void) parseAgrupacion:(CXMLElement*) node;
- (NSArray*) parseVideos:(CXMLElement*)videosElement;
- (NSArray*) parseComponents:(CXMLElement*) node;
- (NSArray*) parseComments:(CXMLElement*)commentsElement;
- (NSArray*) parsePictures:(CXMLElement*)fotosElement;
- (void) parseElementsOfXpath:(NSString*)xpath;
- (void) parseDay:(CXMLElement*) node;
- (void) parseLink:(CXMLElement*) node;
- (Agrupacion*) groupWithID:(int)groupId inGroups:(NSArray*)groups;

- (NSMutableArray*) getObjectsOfClass:(NSString*) kclass withId:(int) obj_id andError:(NSError*) error;
- (void) showAgrupaciones;
- (void) showCalendar;
- (void) showLinks;
- (void) showModalities;
@end


@implementation CoacParser


@synthesize xmlData;
@synthesize delegate;

- (id) initWithXMLData:(NSData*)theXml delegate:(id)theDelegate;
{
	/************************************************************************************/
	/* Custom init method																*/
	/************************************************************************************/	
	if(self = [super init])
	{
		xmlData = [theXml copy];
        delegate = theDelegate;
        groups = [[NSMutableArray alloc] init];
        calendar = [[NSMutableDictionary alloc] init];
        links = [[NSMutableArray alloc] init];
        modalities = [[NSMutableDictionary alloc] init];
        
        queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 1;
	}
	
	return self;	
}



#pragma mark - Public Interface

- (void) start
{
	/************************************************************************************/
	/* Parse the contents of the xml file and create a representation of it in the core */
	/* stack.																			*/
	/************************************************************************************/    
    NSBlockOperation* op = [NSBlockOperation blockOperationWithBlock:^{
        // Clear data structures before loading any parsed data        
        [groups removeAllObjects];
        [calendar removeAllObjects];
        [links removeAllObjects];
        [modalities removeAllObjects];
        
        // Parse
        [self parseElementsOfXpath:@"/coac2012/agrupaciones/agrupacion"];
        [self parseElementsOfXpath:@"/coac2012/calendario/dia"];
        [self parseElementsOfXpath:@"/coac2012/enlaces/enlace"];    
        
        // Debugging
        [self showAgrupaciones];
        [self showCalendar];
        [self showLinks];
        [self showModalities];        
        
        [delegate parsingDidFinishWithGroups:groups calendar:calendar links:links];
    }];
	
    [queue addOperation:op];    
}



#pragma mark - Parsing Helpers

- (void) parseElementsOfXpath:(NSString*)xpath
{
	/************************************************************************************/
	/* Parse the elements that match the given xpath. Stores each of those elements as  */
	/* objects of type klass.															*/
	/************************************************************************************/	
	NSError* err;
	CXMLDocument* doc = [[[CXMLDocument alloc] initWithData:xmlData options:0 error:&err] autorelease];
	
	if(err)
	{
		DebugLog(@"ERROR in parseElementsOfXpath; %@", [err description]);
	}
	else
	{
		NSArray* nodes = nil;		
        err = nil;
		nodes = [doc nodesForXPath:xpath error:&err];

		for (CXMLElement* node in nodes)			
		{
			if([xpath isEqualToString:@"/coac2012/agrupaciones/agrupacion"])		
            {
				[self parseAgrupacion:node];                
            }
            else if ([xpath isEqualToString:@"/coac2012/calendario/dia"])
            {
                [self parseDay:node];
            }
            else if ([xpath isEqualToString:@"/coac2012/enlaces/enlace"])
            {
                [self parseLink:node];
            }
		}
	}
}


- (void) parseDay:(CXMLElement*) node
{
    NSString* dateString = [[node attributeForName:CALENDAR_DATE_ATTRIBUTE_NAME] stringValue];
    
    NSMutableArray*  groupsInDay = [NSMutableArray array];
    NSArray*  positionsNode = [node elementsForName:CALENDAR_POSITION_TAG_NAME];

    for (CXMLElement* position in positionsNode)
    {        
        NSString* agIdString = [[position attributeForName:CALENDAR_GROUP_ATTRIBUTE_NAME] stringValue];
        
        Agrupacion* ag = nil;
        if ([agIdString isEqualToString:CALENDAR_REST_TOKEN])
        {
            // Agrupacion descanso
            ag = [Agrupacion restingGroup];
            [groupsInDay addObject:ag];
        }
        else
        {            
            ag = [self groupWithID:[agIdString intValue] inGroups:groups];
            if (ag)
            {
                [groupsInDay addObject:ag];
            }
        }
    }
    
    [calendar setObject:groupsInDay forKey:dateString];
}


- (void) parseLink:(CXMLElement *)linkElement
{
    
    Link* l = [[Link alloc] init];
    l.url = [[linkElement attributeForName:URL_ATTRIBUTE_NAME] stringValue];
    l.type = [[linkElement attributeForName:TYPE_ATTRIBUTE_NAME] stringValue];
    l.desc = [[linkElement attributeForName:DESCRIPTION_ATTRIBUTE_NAME] stringValue];

    [links addObject:l];
}


- (void) parseAgrupacion:(CXMLElement*) node
{
	/************************************************************************************/
	/* Given a node, it stores it as a group.                                           */
	/************************************************************************************/
    Agrupacion* ag = [[Agrupacion alloc] init];
    
    ag.nombre = [[node attributeForName:GROUP_NAME_ATTRIBUTE] stringValue];
    ag.modalidad = [[node attributeForName:GROUP_MODALITY_ATTRIBUTE] stringValue];
    ag.identificador = [[[node attributeForName:GROUP_ID_ATTRIBUTE] stringValue] intValue];
    ag.autor = [[node attributeForName:GROUP_AUTHOR_ATTRIBUTE] stringValue];
    ag.director = [[node attributeForName:GROUP_DIRECTOR_ATTRIBUTE] stringValue];
    ag.localidad = [[node attributeForName:GROUP_CITY_ATTRIBUTE] stringValue];
    ag.coac2011 = [[node attributeForName:GROUP_COAC2011_ATTRIBUTE] stringValue];
    ag.esCabezaDeSerie = [[[node attributeForName:GROUP_HEAD_OF_GROUP_ATTRIBUTE] stringValue] boolValue];
    ag.info = [[node attributeForName:GROUP_INFO_ATTRIBUTE] stringValue];
    ag.urlCC = [[node attributeForName:GROUP_URL_CC_ATTRIBUTE] stringValue];
    ag.urlFoto = [[node attributeForName:GROUP_URL_PICTURE_ATTRIBUTE] stringValue];
    ag.urlVideos = [[node attributeForName:GROUP_URL_VIDEOS_ATTRIBUTE] stringValue];
    ag.puntos = [[node attributeForName:GROUP_SCORE_ATTRIBUTE] stringValue];
    
    NSArray* componentes = nil;
    NSArray*  componentsNodes = [node elementsForName:COMPONENTS_TAG];
    if ([componentsNodes count] > 0)
    {
        CXMLElement* componentsElement = [componentsNodes objectAtIndex:0];
        componentes = [self parseComponents:componentsElement];
    }    
    ag.componentes = componentes;

    
    NSArray* videos = nil;
    NSArray*  videosNodes = [node elementsForName:VIDEOS_TAG];
    if ([videosNodes count] > 0)
    {
        CXMLElement* videosElement = [videosNodes objectAtIndex:0];
        videos = [self parseVideos:videosElement];
    }    
    ag.videos = videos;

    NSArray* fotos = nil;
    NSArray*  fotosNodes = [node elementsForName:PICTURES_TAG];
    if ([fotosNodes count] > 0)
    {
        CXMLElement* fotosElement = [fotosNodes objectAtIndex:0];
        fotos = [self parsePictures:fotosElement];
    }    
    ag.fotos = fotos;

    NSArray* comentarios = nil;
    NSArray*  comentariosNodes = [node elementsForName:COMMENTS_TAG];
    if ([comentariosNodes count] > 0)
    {
        CXMLElement* comentariosElement = [comentariosNodes objectAtIndex:0];
        comentarios = [self parseComments:comentariosElement];
    }    
    ag.comentatios = comentarios;

    
    // Add it to the collection
    [groups addObject:ag];
    NSString* modality = [ag.modalidad capitalizedString];
    NSMutableArray* groupsForModality = [modalities objectForKey:modality];
    if (groupsForModality)
    {
        [groupsForModality addObject:ag];
    }
    else
    {
        NSMutableArray* newGroupsForModalidy = [[NSMutableArray alloc] init];
        [newGroupsForModalidy addObject:ag];
        [modalities setObject:newGroupsForModalidy forKey:modality];
        [newGroupsForModalidy release];
    }
}


- (NSArray*) parseComponents:(CXMLElement*)componentsElement
{
    NSMutableArray* components = [[NSMutableArray alloc] init];
    NSArray* componenteNodes = [componentsElement elementsForName:COMPONENT_TAG];
    
    for (CXMLElement* componentElement in componenteNodes)
    {
        Componente* c = [[Componente alloc] init];
        c.nombre = [[componentElement attributeForName:NAME_ATTRIBUTE] stringValue];
        c.voz = [[componentElement attributeForName:VOICE_ATTRIBUTE] stringValue];
        [components addObject:c];
        [c release];
    }
    
    return [NSArray arrayWithArray:components];

}


- (NSArray*) parseVideos:(CXMLElement*)videosElement
{
    NSMutableArray* videos = [[NSMutableArray alloc] init];
    NSArray* videosNodes = [videosElement elementsForName:VIDEO_TAG];
    
    for (CXMLElement* videoElement in videosNodes)
    {
        
        Video* v = [[Video alloc] init];
        v.desc = [[videoElement attributeForName:DESCRIPTION_ATTRIBUTE_NAME] stringValue];
        v.url = [[videoElement attributeForName:URL_ATTRIBUTE_NAME] stringValue];
        [videos addObject:v];
        [v release];
    }
    
    return [NSArray arrayWithArray:videos];    
}


- (NSArray*) parsePictures:(CXMLElement*)fotosElement
{
    NSMutableArray* fotos = [[NSMutableArray alloc] init];
    NSArray* fotosNodes = [fotosElement elementsForName:PICTURE_TAG];
    
    for (CXMLElement* fotoElement in fotosNodes)
    {
        
        Picture* p = [[Picture alloc] init];
        p.desc = [[fotoElement attributeForName:DESCRIPTION_ATTRIBUTE_NAME] stringValue];
        p.url = [[fotoElement attributeForName:URL_ATTRIBUTE_NAME] stringValue];
        [fotos addObject:p];
        [p release];
    }
    
    return [NSArray arrayWithArray:fotos];    
}


- (NSArray*) parseComments:(CXMLElement*)commentsElement
{
    NSMutableArray* comments = [[NSMutableArray alloc] init];
    NSArray* commentsNodes = [commentsElement elementsForName:COMMENT_TAG];
    
    for (CXMLElement* commentElement in commentsNodes)
    {        
        Comentario* c = [[Comentario alloc] init];
        c.origen = [[commentElement attributeForName:ORIGEN_ATTRIBUTE_NAME] stringValue];
        c.url = [[commentElement attributeForName:URL_ATTRIBUTE_NAME] stringValue];
        [comments addObject:c];
        [c release];
    }
    
    return [NSArray arrayWithArray:comments];
}


- (Agrupacion*) groupWithID:(int)groupId inGroups:(NSArray*)theGroups
{
    Agrupacion* result = nil;
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"identificador=%d", groupId];
    NSArray* filteredArray = [theGroups filteredArrayUsingPredicate:predicate];
    
    if([filteredArray count] > 0)
    {
        result = [filteredArray objectAtIndex:0];
    }
    
    return result;    
}



#pragma mark - Logger helpers

- (void) showCalendar
{
    NSArray* keys = [calendar allKeys];
    
    for (NSString* key in keys)
    {
        NSLog(@"- %@  -----------------", key);
        NSArray* agrupaciones = [calendar objectForKey:key];
        for (Agrupacion* ag in agrupaciones)
        {
            NSLog(@"Ag: %ld", [ag identificador]);
        }
        NSLog(@"-----------------------");
    }
}

- (void) showModalities
{
    NSArray* keys = [modalities allKeys];
    
    for (NSString* key in keys)
    {
        NSLog(@"- %@  -----------------", key);
        NSArray* agrupaciones = [modalities objectForKey:key];
        for (Agrupacion* ag in agrupaciones)
        {
            NSLog(@"Ag: %@", [ag nombre]);
        }
        NSLog(@"-----------------------");
    }
}



- (void) showAgrupaciones
{
    for (Agrupacion* ag in groups)
    {
        DebugLog(@"%@", ag);
    }
}

- (void) showLinks
{
    for (Link* l in links)
    {
        NSLog(@"- LINK: url:%@, type:%@, desc:%@", l.url, l.type, l.desc);
    }
}

- (void) dealloc
{
	/************************************************************************************/
	/* Tidy-up.																			*/
	/************************************************************************************/	
    [calendar release];
    [groups release];
	[xmlData release];
    [links release];
    [modalities release];
    [queue release];
	[super dealloc];
}

@end
