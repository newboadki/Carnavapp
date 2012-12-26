//
//  ParserTests.m
//  Farmacy
//
//  Created by Borja Arias Drake on 23/10/2010.
//  Copyright 2010 Borja Arias Drake. All rights reserved.
//

#import "Parser_v_1_0_4Tests.h"
#import "Agrupacion.h"
#import "Video.h"
#import "Picture.h"
#import "Componente.h"
#import "Comentario.h"
#import "Link.h"
#import "Result.h"

@implementation Parser_v_1_0_4Tests

- (void) setUp
{
    NSError* err = nil;
    NSString* path = [[NSBundle bundleForClass:[self class]] pathForResource:@"group_v_1_0_4" ofType:@"xml"];
    NSData* xmlData = [[NSData alloc] initWithContentsOfFile:path options:0 error:&err];
    parser = [[CoacParser_v_1_0_4 alloc] initWithXMLData:xmlData delegate:self];
}


- (void) tearDown
{	
    [parser release];
}

- (void) testParsingAgroupation
{
    NSDictionary* results = [parser doParsingSync]; // Calling the private method as NSOperation wasn't working on the tests. 
    NSDictionary* groupsForAllYears = [results objectForKey:GROUPS_KEY];
    
    NSArray *years = [groupsForAllYears allKeys];
    STAssertTrue(2 == [years count], @"ParseGroup didn't get the right number of years");
    
    NSArray *groups2012 = [groupsForAllYears objectForKey:@"2012"];
    STAssertNotNil(groups2012, @"ParseGroup didn't parse the year 2012");
    STAssertTrue(2 == [groups2012 count], @"2012 doesn't have the right number of groups");
    NSArray *groups2013 = [groupsForAllYears objectForKey:@"2013"];
    STAssertNotNil(groups2013, @"ParseGroup didn't parse the year 2013");
    STAssertTrue(2 == [groups2013 count], @"2013 doesn't have the right number of groups");
    
    Agrupacion *a1 = [groups2012 objectAtIndex:0];    
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
    
    // Components
    NSArray* components = [a1 componentes];
    Componente* c1 = [components objectAtIndex:0];
    Componente* c2 = [components objectAtIndex:1];
    STAssertTrue([c1.nombre isEqualToString:@"Paco"], @"The components's name wasn't parsed correctly");
    STAssertTrue([c1.voz isEqualToString:@"Grave"], @"The components's voice wasn't parsed correctly");

    STAssertTrue([c2.nombre isEqualToString:@"Maruja"], @"The components's name wasn't parsed correctly");
    STAssertTrue([c2.voz isEqualToString:@"Muy Aguda"], @"The components's voice wasn't parsed correctly");


    // Comments
    NSArray* comments = [a1 comentatios];
    Comentario* co1 = [comments objectAtIndex:0];
    Comentario* co2 = [comments objectAtIndex:1];
    STAssertTrue([co1.origen isEqualToString:@"La Voz de Cadiz - Ficha"], @"The comment's origin wasn't parsed correctly");
    STAssertTrue([co1.url isEqualToString:@"http://carnaval.lavozdigital.es/agrupaciones/2012/los-hijos-del.html"], @"The comment's url wasn't parsed correctly");
    
    STAssertTrue([co2.origen isEqualToString:@"Carnavalitas - Comentario preeliminares"], @"The comment's origin wasn't parsed correctly");
    STAssertTrue([co2.url isEqualToString:@"http://coac2012.carnavalistas.com/agrupaciones?act=1"], @"The comment's url wasn't parsed correctly");

    
    
    Agrupacion *a2 = [groups2013 objectAtIndex:1];
    STAssertTrue([a2.nombre isEqualToString:@"La Tacita"], @"the name wasn't parsed correctly");
    STAssertTrue([a2.identificador intValue] == 3, @"The group's id wasn't parsed correctly");
    STAssertTrue([a2.modalidad isEqualToString:@"COMPARSA"], @"The group's modality wasn't parsed correctly");
    STAssertTrue([a2.autor isEqualToString:@"Gonzalo de Treviso"], @"The group's author wasn't parsed correctly");
    STAssertTrue([a2.director isEqualToString:@"Perra"], @"The group's director wasn't parsed correctly");
    STAssertTrue([a2.localidad isEqualToString:@"Cadiz"], @"The group's city wasn't parsed correctly");
    STAssertTrue([a2.coac2011 isEqualToString:@"La infanteria"], @"The group's coac2011 wasn't parsed correctly");
    STAssertTrue([a2.esCabezaDeSerie boolValue] == NO, @"The group's head of group wasn't parsed correctly");
    STAssertTrue([a2.info isEqualToString:@"Una comparsa con guasa"], @"The group's info wasn't parsed correctly");
    STAssertTrue([a2.urlCC isEqualToString:@"http://www.carnavaldecadiz.com/Carnaval2013/Absoluta/latacita.php"], @"The group's urlCC wasn't parsed correctly");
    STAssertTrue([a2.urlFoto isEqualToString:@"http://www.carnavaldecadiz.com/Carnaval2013/Absoluta/Imagenes/latacita.jpg"], @"The group's urlFoto wasn't parsed correctly");
    STAssertTrue([a2.urlVideos isEqualToString:@"url of the video"], @"The group's urlVideos wasn't parsed correctly");
    
    // Videos
    NSArray* a2_videos = [a2 videos];
    Video* a2_v1 = [a2_videos objectAtIndex:0];
    Video* a2_v2 = [a2_videos objectAtIndex:1];
    STAssertTrue([a2_v1.url isEqualToString:@"http://www.youtube.com/watch?v=lk8i556mc"], @"The videos's url wasn't parsed correctly");
    STAssertTrue([a2_v1.desc isEqualToString:@"Preeliminar - Actuacion completa"], @"The videos's description wasn't parsed correctly");
    STAssertTrue([a2_v2.url isEqualToString:@"http://www.youtube.com/watch?v=kk4"], @"The videos's url wasn't parsed correctly");
    STAssertTrue([a2_v2.desc isEqualToString:@"final"], @"The videos's description wasn't parsed correctly");
    
    // Pictures
    NSArray* a2_pics = [a2 fotos];
    Picture* a2_p1 = [a2_pics objectAtIndex:0];
    STAssertTrue([a2_p1.url isEqualToString:@"url1"], @"The picture's url wasn't parsed correctly");
    STAssertTrue([a2_p1.desc isEqualToString:@"foto54"], @"The picture's description wasn't parsed correctly");
    
    // Components
    NSArray* a2_components = [a2 componentes];
    Componente* a2_c1 = [a2_components objectAtIndex:0];
    Componente* a2_c2 = [a2_components objectAtIndex:1];
    STAssertTrue([a2_c1.nombre isEqualToString:@"Gonzalo"], @"The components's name wasn't parsed correctly");
    STAssertTrue([a2_c1.voz isEqualToString:@"Grave"], @"The components's voice wasn't parsed correctly");
    
    STAssertTrue([a2_c2.nombre isEqualToString:@"Lucas"], @"The components's name wasn't parsed correctly");
    STAssertTrue([a2_c2.voz isEqualToString:@"Muy Aguda"], @"The components's voice wasn't parsed correctly");
    
    
    // Comments
    NSArray* a2_comments = [a2 comentatios];
    Comentario* a2_co1 = [a2_comments objectAtIndex:0];
    Comentario* a2_co2 = [a2_comments objectAtIndex:1];
    STAssertTrue([a2_co1.origen isEqualToString:@"La Voz de Cadiz habla sobre la tacita"], @"The comment's origin wasn't parsed correctly");
    STAssertTrue([a2_co1.url isEqualToString:@"http://carnaval.lavozdigital.es/agrupaciones/2013/latacita.html"], @"The comment's url wasn't parsed correctly");
    
    STAssertTrue([a2_co2.origen isEqualToString:@"Carnavalitas - Comentario preeliminares sobre la tacita"], @"The comment's origin wasn't parsed correctly");
    STAssertTrue([a2_co2.url isEqualToString:@"http://coac2013.carnavalistas.com/agrupaciones?act=3"], @"The comment's url wasn't parsed correctly");
}


- (void) testParsingCalendar
{
    NSDictionary* results = [parser doParsingSync]; // Calling the private method as NSOperation wasn't working on the tests. 
    NSDictionary* calendar = [results objectForKey:CALENDAR_KEY];
    NSDictionary* calendar2012 = calendar[@"2012"];
    NSDictionary* calendar2013 = calendar[@"2013"];
    
    // 2012, date 1
    NSArray* groupsForDate1_2012 = [calendar2012 objectForKey:@"21/01/2012"];
    Agrupacion* ag1 = [groupsForDate1_2012 objectAtIndex:0];
    Agrupacion* ag2 = [groupsForDate1_2012 objectAtIndex:1];
    STAssertTrue(2 == [groupsForDate1_2012 count], @"wrong number of groups for date1");
    STAssertTrue([ag1.identificador intValue] == 1, @"The group's id wasn't parsed correctly");
    STAssertTrue([ag2.identificador intValue] == 2, @"The group's id wasn't parsed correctly");

    // 2012, date 2
    NSArray* groupsForDate2_2012 = [calendar2012 objectForKey:@"22/01/2012"];
    ag1 = [groupsForDate2_2012 objectAtIndex:0];
    ag2 = [groupsForDate2_2012 objectAtIndex:1];
    STAssertTrue(2 == [groupsForDate1_2012 count], @"wrong number of groups for date2");
    STAssertTrue([ag1.identificador intValue] == 2, @"The group's id wasn't parsed correctly");
    STAssertTrue([ag2.identificador intValue] == 1, @"The group's id wasn't parsed correctly");

    
    
    // 2013, date 1
    NSArray* groupsForDate1_2013 = [calendar2013 objectForKey:@"18/01/2013"];
    ag1 = [groupsForDate1_2013 objectAtIndex:0];
    Agrupacion* ag3 = [groupsForDate1_2013 objectAtIndex:1];
    STAssertTrue(2 == [groupsForDate1_2012 count], @"wrong number of groups for date1");
    STAssertTrue([ag1.identificador intValue] == 1, @"The group's id wasn't parsed correctly");
    STAssertTrue([ag3.identificador intValue] == 3, @"The group's id wasn't parsed correctly");
    
    // 2013, date 2
    NSArray* groupsForDate2_2013 = [calendar2013 objectForKey:@"24/02/2013"];
    ag1 = [groupsForDate2_2013 objectAtIndex:1];
    ag3 = [groupsForDate2_2013 objectAtIndex:0];
    STAssertTrue(2 == [groupsForDate2_2013 count], @"wrong number of groups for date2");
    STAssertTrue([ag3.identificador intValue] == 3, @"The group's id wasn't parsed correctly");
    STAssertTrue([ag1.identificador intValue] == 1, @"The group's id wasn't parsed correctly");

}

- (void) testParsingResults
{
    NSDictionary* results = [parser doParsingSync]; // Calling the private method as NSOperation wasn't working on the tests.
    NSDictionary* calendar = [results objectForKey:RESULTS_KEY];
    NSArray* results2012 = calendar[@"2012"];
    NSArray* results2013 = calendar[@"2013"];
    
    NSArray *points2012 = [results2012 valueForKeyPath:@"points"];
    NSArray *phases2012 = [results2012 valueForKeyPath:@"phase"];
    NSArray *groupIds2012 = [results2012 valueForKeyPath:@"groupId"];
    
    Result * r1 = results2012[0];
    STAssertTrue([r1.groupId isEqualToString:@"2"], @"Results for 2012 should contain the ID 1");
    STAssertTrue([r1.points isEqualToNumber:@23], @"Results for 2012 should contain the points 23");
    STAssertTrue([r1.phase isEqualToString:@"FINAL"], @"Results for 2012 should contain the phase FINAL");
    Result * r2 = results2012[1];
    STAssertTrue([r2.groupId isEqualToString:@"1"], @"Results for 2012 should contain the ID 2");
    STAssertTrue([r2.points isEqualToNumber:@31], @"Results for 2012 should contain the points 31");
    STAssertTrue([r2.phase isEqualToString:@"CUARTOS"], @"Results for 2012 should contain the phase CUARTOS");
        
    STAssertTrue(0 == [results2013 count], @"Results for 2013 should be empty");
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
