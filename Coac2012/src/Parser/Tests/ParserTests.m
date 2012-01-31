//
//  ParserTests.m
//  Farmacy
//
//  Created by Borja Arias Drake on 23/10/2010.
//  Copyright 2010 Borja Arias Drake. All rights reserved.
//

#import "ParserTests.h"
#import "Agrupacion.h"

@implementation ParserTests

- (void) setUp
{

}


- (void) tearDown
{	
    
}

- (void) testParsingAgroupation
{
    NSError* err = nil;
    NSString* path = [[NSBundle bundleForClass:[self class]] pathForResource:@"group" ofType:@"xml"];
    NSData* xmlData = [[NSData alloc] initWithContentsOfFile:path options:NULL error:&err];
    parser = [[CoacParser alloc] initWithXMLData:xmlData delegate:self];

    NSDictionary* results = [parser doParsingSync]; // Call the private method as NSOperation wasn't working on the tests. 
    NSArray* groups = [results objectForKey:GROUPS_KEY];
    Agrupacion* a1 = [groups objectAtIndex:0];
    STAssertTrue([a1.nombre isEqualToString:@"Los hijos del 78"], @"");
    STAssertTrue(a1.identificador == 1, @"");

}

- (void) parsingDidFinishWithResultsDictionary:(NSDictionary*)resultsDictionary
{
    self->results = [resultsDictionary retain];
}


@end
