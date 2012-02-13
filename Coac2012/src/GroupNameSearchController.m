//
//  BaseStringSearchController.m
//  Coac2012
//
//  Created by Borja Arias on 12/02/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "GroupNameSearchController.h"
#import "Agrupacion.h"

@implementation GroupNameSearchController

@synthesize resultsDelegate;
@synthesize sampleArray;

- (id) initWithSampleArrayinSampleArray:(NSArray*)array andDelegate:(id<GroupNameSearchControllerDelegateProtocol>)del
{
    self = [super init];
    
    if (self)
    {
        resultsDelegate = del;
        sampleArray = [array retain];
    }
    
    return self;
}


- (void) searchResultsForString:(NSString*)searchString
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"nombre CONTAINS[c] %@", searchString]; // [c] to do a non case-sensitive search
    NSArray* results = [sampleArray filteredArrayUsingPredicate:predicate];
    [resultsDelegate resultsAreReady:results forSearchString:searchString];
}

- (void) dealloc
{
    [sampleArray release];
    [super dealloc];
}

@end