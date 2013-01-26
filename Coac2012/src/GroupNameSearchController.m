//
//  BaseStringSearchController.m
//  Coac2012
//
//  Created by Borja Arias on 12/02/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "GroupNameSearchController.h"
#import "Agrupacion.h"

@interface GroupNameSearchController ()
@property (nonatomic, retain) NSOperationQueue* queue;
@end


@implementation GroupNameSearchController


- (id) initWithSampleArrayinSampleArray:(NSArray*)array andDelegate:(id<GroupNameSearchControllerDelegateProtocol>)del
{
    self = [super init];
    
    if (self)
    {
        _resultsDelegate = del;
        _sampleArray = [array retain];
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 1;
    }
    
    return self;
}


- (void) searchResultsForString:(NSString*)searchString
{
    [self.queue addOperationWithBlock:^{
        
        NSPredicate* byNamePredicate = [NSPredicate predicateWithFormat:@"nombre CONTAINS[c] %@", searchString]; // [c] to do a non case-sensitive search
        NSPredicate* byAuthorpredicate = [NSPredicate predicateWithFormat:@"autor CONTAINS[c] %@", searchString];
        NSPredicate *predicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[byNamePredicate, byAuthorpredicate]];
        NSArray* results = [self.sampleArray filteredArrayUsingPredicate:predicate];
        if (!results)
        {
            results = @[];
        }
        
        NSDictionary* resultsDic = @{SEARCH_RESULTS_KEY: results, SEARCH_STRING_KEY: searchString};        
        [(NSObject*)self.resultsDelegate performSelectorOnMainThread:@selector(resultsAreReadyInDictionary:) withObject:resultsDic waitUntilDone:YES];
    }];
}

- (void) dealloc
{
    [_sampleArray release];
    [_queue release];
    [super dealloc];
}

@end