//
//  Parser.m
//  DownloadFromURL
//
//  Created by Borja Arias Drake on 25/09/2010.
//  Copyright 2010 Borja Arias Drake. All rights reserved.
//

#import "CoacParser_v_1_0_4.h"
#import "Agrupacion.h"
#import "Componente.h"
#import "Video.h"
#import "Picture.h"
#import "Comentario.h"
#import "Link.h"
#import "Result.h"

#define YEAR_ATTRIBUTE @"anio"
#define RESULTS_TAG @"puntuaciones"
#define RESULT_TAG @"puntuacion"

#define CALENDAR_DATE_ATTRIBUTE_NAME        @"fecha"
#define CALENDAR_POSITION_TAG_NAME          @"puesto"
#define CALENDAR_GROUP_ATTRIBUTE_NAME       @"agrupacion"
#define CALENDAR_REST_TOKEN                 @"DESCANSO"

#define RESULTS_GROUP_ID_TAG   @"agrupacion"
#define RESULTS_PHASE_TAG      @"fase"
#define RESULTS_POINTS_TAG     @"puntos"

#define URL_ATTRIBUTE_NAME             @"url"
#define TYPE_ATTRIBUTE_NAME            @"tipo"
#define DESCRIPTION_ATTRIBUTE_NAME     @"descripcion"
#define NAME_ATTRIBUTE                 @"nombre"
#define VOICE_ATTRIBUTE                @"voz"
#define ORIGEN_ATTRIBUTE_NAME          @"origen"


#define GROUP_NAME_ATTRIBUTE          @"nombre"
#define GROUP_MODALITY_ATTRIBUTE      @"modalidad"
#define GROUP_ID_ATTRIBUTE            @"id"
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

#define CALENDAR_DAY_TAG @"dia"
#define CALENDAR_TAG @"calendario"
#define GROUPS_TAG @"agrupaciones"
#define GROUP_TAG @"agrupacion"
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


@interface CoacParser_v_1_0_4(private)
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
- (NSDictionary*) doParsingSync;
@end


@implementation CoacParser_v_1_0_4


@synthesize xmlData;
@synthesize delegate;

- (id) initWithXMLData:(NSData*)theXml delegate:(id)theDelegate
{
	/************************************************************************************/
	/* Custom init method																*/
	/************************************************************************************/	
	if(self = [super init])
	{
		xmlData = [theXml retain];
        delegate = theDelegate;
        
        groups = [[NSMutableDictionary alloc] init];        
        calendar = [[NSMutableDictionary alloc] init];
        links = [[NSMutableArray alloc] init];
        modalities = [[NSMutableDictionary alloc] init];
        _yearKeys = [[NSMutableArray alloc] initWithObjects:@"2013", @"2012", nil];
        _results = [[NSMutableDictionary alloc] init];
        
        
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
        NSDictionary* results = [self doParsingSync];
        [(id)delegate performSelectorOnMainThread:@selector(parsingDidFinishWithResultsDictionary:) withObject:results waitUntilDone:YES];    
        
    }];
    
    [queue addOperation:op];   
}


- (NSDictionary*) doParsingSync
{
    // Clear data structures before loading any parsed data        
    [groups removeAllObjects];
    [calendar removeAllObjects];
    [links removeAllObjects];
    [modalities removeAllObjects];
    
    // Parse
    [self parseElementsOfXpath:@"/carnavapp/anio"];
    [self parseElementsOfXpath:@"/carnavapp/enlaces/enlace"];
    
    // Debugging
    /*[self showAgrupaciones];
     [self showCalendar];
     [self showLinks];
     [self showModalities];*/
    
    
    NSDictionary* results = @{ GROUPS_KEY: groups,
                               CALENDAR_KEY: calendar,
                               LINKS_KEY: links,
                               MODALITIES_KEY: modalities,
                               YEARS_KEY:_yearKeys,
                               RESULTS_KEY: _results};
    return results;
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
			if([xpath isEqualToString:@"/carnavapp/anio"])		
            {
				[self parseYear:node];
            }            
            else if ([xpath isEqualToString:@"/carnavapp/enlaces/enlace"])
            {
                [self parseLink:node];
            }
		}
	}
}

- (void) parseYear:(CXMLElement*)yearNode
{
    NSString *yearString = [[yearNode attributeForName:YEAR_ATTRIBUTE] stringValue];
    NSArray* groupsNode = [yearNode elementsForName:GROUPS_TAG];
    NSArray* groupNodes = nil;
    NSArray* resultsNode = [yearNode elementsForName:RESULTS_TAG];
    NSArray* resultNodes = nil;
    NSArray* calendarNode = [yearNode elementsForName:CALENDAR_TAG];
    NSArray* dayNodes = nil;

    if ([groupsNode count] > 0)
    {
        groupNodes = [[groupsNode objectAtIndex:0] elementsForName:GROUP_TAG];
        for (CXMLElement* groupNode in groupNodes) {
            [self parseAgrupacion:groupNode fromYear:yearString];
        }
    }
    
    if ([resultsNode count] > 0)
    {
        resultNodes = [[resultsNode objectAtIndex:0] elementsForName:RESULT_TAG];
        for (CXMLElement* resultNode in resultNodes) {
            [self parseResultsNode:resultNode fromYear:yearString];
        }
    }

    if ([calendarNode count] > 0)
    {
        dayNodes = [[calendarNode objectAtIndex:0] elementsForName:CALENDAR_DAY_TAG];
        for (CXMLElement* dayNode in dayNodes) {
            [self parseDay:dayNode fromYear:yearString];
        }
    }

}

- (void) parseGroups:(CXMLElement*)groupsNode
{
    NSString *yearString = [[groupsNode attributeForName:YEAR_ATTRIBUTE] stringValue];    
    NSArray* groupNodes = [groupsNode elementsForName:GROUP_TAG];
    
    for (CXMLElement* groupNode in groupNodes)
    {
        [self parseAgrupacion:groupNode fromYear:yearString];
    }
}


- (void) parseCalendar:(CXMLElement*)calendarNode
{
    NSString *yearString = [[calendarNode attributeForName:YEAR_ATTRIBUTE] stringValue];
    NSArray* dayNodes = [calendarNode elementsForName:CALENDAR_DAY_TAG];
    
    for (CXMLElement* dayNode in dayNodes)
    {
        [self parseDay:dayNode fromYear:yearString];
    }
}


- (void) parseResultsNode:(CXMLElement*)resultNode fromYear:(NSString*)yearString
{
    NSString* groupId = [[resultNode attributeForName:RESULTS_GROUP_ID_TAG] stringValue];
    NSString* phase = [[resultNode attributeForName:RESULTS_PHASE_TAG] stringValue];
    NSNumber* points = [NSNumber numberWithInt:[[[resultNode attributeForName:RESULTS_POINTS_TAG] stringValue] intValue]];
    
    NSMutableArray* resultsForYear = _results[yearString];

    if (!resultsForYear)
    {
        resultsForYear = [[NSMutableArray alloc] init];
        [_results setObject:resultsForYear forKey:yearString];
        [resultsForYear release];
    }

    Agrupacion *ag = [self groupWithID:[groupId intValue] inGroups:[groups objectForKey:yearString]];
    if (ag)
    {
        Result* result = [[Result alloc] initWithGroupId:groupId phase:phase points:points modality:ag.modalidad];
        [resultsForYear addObject:result];
        [result release];
    }
}


- (void) parseDay:(CXMLElement*)node fromYear:(NSString*)yearString
{
    NSString* dateString = [[node attributeForName:CALENDAR_DATE_ATTRIBUTE_NAME] stringValue];
    NSMutableArray*  groupsInDay = [NSMutableArray array];
    NSArray*  positionsNode = [node elementsForName:CALENDAR_POSITION_TAG_NAME];

    NSMutableDictionary* calendarForGivenYear = calendar[yearString];
    if (!calendarForGivenYear) {
        calendarForGivenYear = [[NSMutableDictionary alloc] init];
        calendar[yearString] = calendarForGivenYear;
        [calendarForGivenYear release];
    }
    
    NSMutableArray* groupsForDateInYear = calendarForGivenYear[dateString];
    if (!groupsForDateInYear) {
        groupsForDateInYear = [[NSMutableArray alloc] init];
        calendarForGivenYear[dateString] = groupsForDateInYear;
        [groupsForDateInYear release];
    }
    
    
    
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
            NSMutableArray *groupsForYear = [groups objectForKey:yearString];
            if (!groupsForYear) {
                groupsForYear = [[[NSMutableArray alloc] init] autorelease];
                [groups setObject:groupsForYear forKey:yearString];
            }

            ag = [self groupWithID:[agIdString intValue] inGroups:groupsForYear];
            if (ag)
            {
                [groupsForDateInYear addObject:ag];
            }
        }
    }
}


- (void) parseLink:(CXMLElement *)linkElement
{
    
    Link* l = [[Link alloc] init];
    l.url = [[linkElement attributeForName:URL_ATTRIBUTE_NAME] stringValue];
    l.type = [[linkElement attributeForName:TYPE_ATTRIBUTE_NAME] stringValue];
    l.desc = [[linkElement attributeForName:DESCRIPTION_ATTRIBUTE_NAME] stringValue];

    [links addObject:l];
    [l release];
}


- (void) parseAgrupacion:(CXMLElement*)node fromYear:(NSString*)yearString
{
	/************************************************************************************/
	/* Given a node, it stores it as a group.                                           */
	/************************************************************************************/
    Agrupacion* ag = [[Agrupacion alloc] init];
    
    ag.nombre = [[node attributeForName:GROUP_NAME_ATTRIBUTE] stringValue];
    ag.modalidad = [[node attributeForName:GROUP_MODALITY_ATTRIBUTE] stringValue];
    ag.identificador = @([[[node attributeForName:GROUP_ID_ATTRIBUTE] stringValue] intValue]);
    ag.autor = [[node attributeForName:GROUP_AUTHOR_ATTRIBUTE] stringValue];
    ag.director = [[node attributeForName:GROUP_DIRECTOR_ATTRIBUTE] stringValue];
    ag.localidad = [[node attributeForName:GROUP_CITY_ATTRIBUTE] stringValue];
    ag.coac2011 = [[node attributeForName:GROUP_COAC2011_ATTRIBUTE] stringValue];
    ag.esCabezaDeSerie = @([[[node attributeForName:GROUP_HEAD_OF_GROUP_ATTRIBUTE] stringValue] boolValue]);
    ag.info = [[node attributeForName:GROUP_INFO_ATTRIBUTE] stringValue];
    ag.urlCC = [[node attributeForName:GROUP_URL_CC_ATTRIBUTE] stringValue];
    ag.urlFoto = [[node attributeForName:GROUP_URL_PICTURE_ATTRIBUTE] stringValue];
    ag.urlVideos = [[node attributeForName:GROUP_URL_VIDEOS_ATTRIBUTE] stringValue];
    ag.puntos = [[node attributeForName:GROUP_SCORE_ATTRIBUTE] stringValue];
    
    NSArray* componentes = nil;
    NSArray*  componentsNodes = [node elementsForName:COMPONENTS_TAG];
    if ([componentsNodes count] > 0)
    {
        CXMLElement* componentsElement = componentsNodes[0];
        componentes = [self parseComponents:componentsElement];
    }    
    ag.componentes = componentes;

    
    NSArray* videos = nil;
    NSArray*  videosNodes = [node elementsForName:VIDEOS_TAG];
    if ([videosNodes count] > 0)
    {
        CXMLElement* videosElement = videosNodes[0];
        videos = [self parseVideos:videosElement];
    }    
    ag.videos = videos;

    NSArray* fotos = nil;
    NSArray*  fotosNodes = [node elementsForName:PICTURES_TAG];
    if ([fotosNodes count] > 0)
    {
        CXMLElement* fotosElement = fotosNodes[0];
        fotos = [self parsePictures:fotosElement];
    }    
    ag.fotos = fotos;

    NSArray* comentarios = nil;
    NSArray*  comentariosNodes = [node elementsForName:COMMENTS_TAG];
    if ([comentariosNodes count] > 0)
    {
        CXMLElement* comentariosElement = comentariosNodes[0];
        comentarios = [self parseComments:comentariosElement];
    }    
    ag.comentatios = comentarios;

    
    // Add it to groups collection
    NSMutableArray *groupsForYear = [groups objectForKey:yearString];
    if (!groupsForYear) {
        groupsForYear = [[[NSMutableArray alloc] init] autorelease];
        [groups setObject:groupsForYear forKey:yearString];        
    }
    [groupsForYear addObject:ag];
    
    // Add it to the modalities collection
    NSString* modality = [ag.modalidad capitalizedString];
    NSMutableDictionary* groupsForModalityIncludingAllYears = modalities[modality];
    
    if (!groupsForModalityIncludingAllYears) {
        groupsForModalityIncludingAllYears = [[NSMutableDictionary alloc] init];
        [modalities setObject:groupsForModalityIncludingAllYears forKey:modality];
        [groupsForModalityIncludingAllYears release];
    }
        
    NSMutableArray *groupsForModalityInYear = groupsForModalityIncludingAllYears[yearString];
    if (!groupsForModalityInYear) {
        groupsForModalityInYear = [[NSMutableArray alloc] init];
        [groupsForModalityIncludingAllYears setObject:groupsForModalityInYear forKey:yearString];
        [groupsForModalityInYear release];
    }
    
    [groupsForModalityInYear addObject:ag];
        
    [ag release];
}


- (NSArray*) parseComponents:(CXMLElement*)componentsElement
{
    NSMutableArray* components = [[[NSMutableArray alloc] init] autorelease];
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
    NSMutableArray* videos = [[[NSMutableArray alloc] init] autorelease];
    NSArray* videosNodes = [videosElement elementsForName:VIDEO_TAG];
    
    for (CXMLElement* videoElement in videosNodes)
    {
        
        Video* v = [[Video alloc] init];
        v.desc = [[videoElement attributeForName:DESCRIPTION_ATTRIBUTE_NAME] stringValue];
        v.url = [[videoElement attributeForName:URL_ATTRIBUTE_NAME] stringValue];
        
        if (([v.desc length] > 0) && [v.url length] > 0)
        {
            [videos addObject:v];
        }        
        
        [v release];
    }
    
    return [NSArray arrayWithArray:videos];    
}


- (NSArray*) parsePictures:(CXMLElement*)fotosElement
{
    NSMutableArray* fotos = [[[NSMutableArray alloc] init] autorelease];
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
    NSMutableArray* comments = [[[NSMutableArray alloc] init] autorelease];
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
        result = filteredArray[0];
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
        NSArray* agrupaciones = calendar[key];
        for (Agrupacion* ag in agrupaciones)
        {
            NSLog(@"Ag: %d", [[ag identificador] intValue]);
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
        NSArray* agrupaciones = modalities[key];
        for (Agrupacion* ag in agrupaciones)
        {
            NSLog(@"Ag: %@", [ag nombre]);
        }
        NSLog(@"-----------------------");
    }
}



- (void) showAgrupaciones
{
    for (NSString* yearKey in [groups allKeys])
    {
        for (Agrupacion* ag in groups[yearKey])
        {
            DebugLog(@"%@", ag);
        }        
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
    [_yearKeys release];
    [_results release];
    [queue release];
	[super dealloc];
}

@end
