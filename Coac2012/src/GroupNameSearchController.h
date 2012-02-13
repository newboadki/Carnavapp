//
//  BaseStringSearchController.h
//  Coac2012
//
//  Created by Borja Arias on 12/02/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>


#define SEARCH_RESULTS_KEY @"resultsKey"
#define SEARCH_STRING_KEY @"searchStringKey"


@protocol GroupNameSearchControllerDelegateProtocol <NSObject>
- (void) resultsAreReadyInDictionary:(NSDictionary*)resultsDictionary;
@end

@interface GroupNameSearchController : NSObject
{
    id<GroupNameSearchControllerDelegateProtocol> resultsDelegate;
    NSArray* sampleArray;
    NSOperationQueue* queue;
}

@property (nonatomic, assign) id<GroupNameSearchControllerDelegateProtocol> resultsDelegate;
@property (nonatomic, retain) NSArray* sampleArray;

- (void) searchResultsForString:(NSString*)searchString;
- (id) initWithSampleArrayinSampleArray:(NSArray*)array andDelegate:(id<GroupNameSearchControllerDelegateProtocol>)del;
@end
