//
//  Parser.h
//  DownloadFromURL
//
//  Created by Borja Arias Drake on 25/09/2010.
//  Copyright 2010 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TouchXML.h"
#import "CoacParserDelegateProtocol.h"

// Keys for the results dictionary, it will be needed by the delegate of this class
#define GROUPS_KEY @"GroupsKey"
#define CALENDAR_KEY @"CalendarKey"
#define LINKS_KEY @"LinksKey"
#define MODALITIES_KEY @"ModalitiesKey"

@interface CoacParser : NSObject
{
    NSMutableArray*      groups;
    NSMutableArray*      links;
    NSMutableDictionary* calendar;
    NSMutableDictionary* modalities;
	NSData*              xmlData;
	id <CoacParserDelegateProtocol> delegate;
    NSOperationQueue*    queue;
}

@property (nonatomic, copy)   NSData*   xmlData;
@property (nonatomic, assign) id        delegate;

- (id) initWithXMLData:(NSData*) theXml delegate:(id)theDelegate;
- (void) start;

@end
