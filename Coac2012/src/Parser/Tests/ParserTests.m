//
//  ParserTests.m
//  Farmacy
//
//  Created by Borja Arias Drake on 23/10/2010.
//  Copyright 2010 Borja Arias Drake. All rights reserved.
//

#import "ParserTests.h"
#import "Agrupacion.h"
#import "Video.h"
#import "Picture.h"
#import "Componente.h"
#import "Comentario.h"
#import "Link.h"

@implementation ParserTests

- (void) setUp
{
    NSError* err = nil;
    NSString* path = [[NSBundle bundleForClass:[self class]] pathForResource:@"group" ofType:@"xml"];
    NSData* xmlData = [[NSData alloc] initWithContentsOfFile:path options:NULL error:&err];
    parser = [[CoacParser alloc] initWithXMLData:xmlData delegate:self];
}


- (void) tearDown
{	
    [parser release];
}

- (void) testParsingAgroupation
{
    NSDictionary* results = [parser doParsingSync]; // Calling the private method as NSOperation wasn't working on the tests. 
    NSDictionary* groups = [results objectForKey:GROUPS_KEY];
    Agrupacion* a1 = [groups objectAtIndex:0];
    
    STAssertTrue([a1.nombre isEqualToString:@"Los hijos del 78"], @"");
    STAssertTrue([a1.identificador intValue] == 1, @"The group's id wasn't parsed correctly");
    STAssertTrue([a1.modalidad isEqualToString:@"CORO"], @"The group's modality wasn't parsed correctly");
    STAssertTrue([a1.autor isEqualToString:@"Francisco Javier Sevilla"], @"The group's author wasn't parsed correctly");
    STAssertTrue([a1.director isEqualToString:@"Antonio Cuesta Pino"], @"The group's director wasn't parsed correctly");
    STAssertTrue([a1.localidad isEqualToString:@"Cadiz"], @"The group's city wasn't parsed correctly");
    STAssertTrue([a1.coac2011 isEqualToString:@"La infanteria"], @"The group's coac2011 wasn't parsed correctly");
    STAssertTrue([a1.esCabezaDeSerie boolValue] == NO, @"The group's head of group wasn't parsed correctly");
    STAssertTrue([a1.info isEqualToString:@"El coro a pie"], @"The group's info wasn't parsed correctly");
    STAssertTrue([a1.urlCC isEqualToString:@"http://www.carnavaldecadiz.com/Carnaval2012/Absoluta/Los_hijos_del_78.php"], @"The group's urlCC wasn't parsed correctly");
    STAssertTrue([a1.urlFoto isEqualToString:@"http://www.carnavaldecadiz.com/Carnaval2012/Absoluta/Imagenes/Los_hijos_del_78_1.jpg"], @"The group's urlFoto wasn't parsed correctly");
    STAssertTrue([a1.urlVideos isEqualToString:@"url of the video"], @"The group's urlVideos wasn't parsed correctly");

    // Videos
    NSArray* videos = [a1 videos];
    Video* v1 = [videos objectAtIndex:0];
    Video* v2 = [videos objectAtIndex:1];
    STAssertTrue([v1.url isEqualToString:@"http://www.youtube.com/watch?v=lk8imaJGu6c"], @"The videos's url wasn't parsed correctly");
    STAssertTrue([v1.desc isEqualToString:@"Preeliminar - Actuacion completa"], @"The videos's description wasn't parsed correctly");
    STAssertTrue([v2.url isEqualToString:@"http://www.youtube.com/watch?v=kk"], @"The videos's url wasn't parsed correctly");
    STAssertTrue([v2.desc isEqualToString:@"final"], @"The videos's description wasn't parsed correctly");

    // Pictures
    NSArray* pics = [a1 fotos];
    Picture* p1 = [pics objectAtIndex:0];
    STAssertTrue([p1.url isEqualToString:@"url1"], @"The picture's url wasn't parsed correctly");
    STAssertTrue([p1.desc isEqualToString:@"foto1"], @"The picture's description wasn't parsed correctly");
    
    // Componentes
    NSArray* components = [a1 componentes];
    Componente* c1 = [components objectAtIndex:0];
    Componente* c2 = [components objectAtIndex:1];
    STAssertTrue([c1.nombre isEqualToString:@"Paco"], @"The components's name wasn't parsed correctly");
    STAssertTrue([c1.voz isEqualToString:@"Grave"], @"The components's voice wasn't parsed correctly");

    STAssertTrue([c2.nombre isEqualToString:@"Maruja"], @"The components's name wasn't parsed correctly");
    STAssertTrue([c2.voz isEqualToString:@"Muy Aguda"], @"The components's voice wasn't parsed correctly");


    // Componentes
    NSArray* comments = [a1 comentatios];
    Comentario* co1 = [comments objectAtIndex:0];
    Comentario* co2 = [comments objectAtIndex:1];
    STAssertTrue([co1.origen isEqualToString:@"La Voz de Cadiz - Ficha"], @"The comment's origin wasn't parsed correctly");
    STAssertTrue([co1.url isEqualToString:@"http://carnaval.lavozdigital.es/agrupaciones/2012/los-hijos-del.html"], @"The comment's url wasn't parsed correctly");
    
    STAssertTrue([co2.origen isEqualToString:@"Carnavalitas - Comentario preeliminares"], @"The comment's origin wasn't parsed correctly");
    STAssertTrue([co2.url isEqualToString:@"http://coac2012.carnavalistas.com/agrupaciones?act=1"], @"The comment's url wasn't parsed correctly");

}


- (void) testParsingCalendar
{
    NSDictionary* results = [parser doParsingSync]; // Calling the private method as NSOperation wasn't working on the tests. 
    NSDictionary* calendar = [results objectForKey:CALENDAR_KEY];
    NSArray* groupsForDate1 = [calendar objectForKey:@"21/01/2012"];
    Agrupacion* ag1 = [groupsForDate1 objectAtIndex:0];
    STAssertTrue([ag1.identificador intValue] == 1, @"The group's id wasn't parsed correctly");
    
    NSArray* groupsForDate2 = [calendar objectForKey:@"22/01/2012"];
    Agrupacion* ag2 = [groupsForDate2 objectAtIndex:0];
    
    STAssertTrue([ag2.identificador intValue] == 1, @"The group's id wasn't parsed correctly");
}


- (void) testParsingLinks
{
    NSDictionary* results = [parser doParsingSync]; // Calling the private method as NSOperation wasn't working on the tests. 
    NSArray* links = [results objectForKey:LINKS_KEY];

    Link* l1 = [links objectAtIndex:0];
    Link* l2 = [links objectAtIndex:1];
    
    STAssertTrue([l1.type isEqualToString:@"Agrupaciones"], @"The link's type wasn't parsed correctly");
    STAssertTrue([l1.desc isEqualToString:@"La Comparsa de Tino"], @"The link's desc wasn't parsed correctly");
    STAssertTrue([l1.url isEqualToString:@"http://www.lacomparsadetino.com/"], @"The link's iurld wasn't parsed correctly");
    STAssertTrue([l2.type isEqualToString:@"Agrupaciones"], @"The link's type wasn't parsed correctly");
    STAssertTrue([l2.desc isEqualToString:@"La Comparsa de J.C.Aragon"], @"The link's desc wasn't parsed correctly");
    STAssertTrue([l2.url isEqualToString:@"http://www.lacomparsadejuancarlos.com/"], @"The link's iurld wasn't parsed correctly");

}
- (void) parsingDidFinishWithResultsDictionary:(NSDictionary*)resultsDictionary
{
    //self->results = [resultsDictionary retain];
}


@end
