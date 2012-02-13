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
        queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 1;
    }
    
    return self;
}


- (void) searchResultsForString:(NSString*)searchString
{
    [queue addOperationWithBlock:^{
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"nombre CONTAINS[c] %@", searchString]; // [c] to do a non case-sensitive search
        NSArray* results = [sampleArray filteredArrayUsingPredicate:predicate];
        
        NSDictionary* resultsDic = [NSDictionary dictionaryWithObjectsAndKeys:results, SEARCH_RESULTS_KEY, searchString, SEARCH_STRING_KEY, nil];        
        [(NSObject*)resultsDelegate performSelectorOnMainThread:@selector(resultsAreReadyInDictionary:) withObject:resultsDic waitUntilDone:YES];
    }];
}

- (void) dealloc
{
    [sampleArray release];
    [queue release];
    [super dealloc];
}

@end