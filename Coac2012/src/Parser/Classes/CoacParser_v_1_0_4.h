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
#import "Constants.h"

@interface CoacParser_v_1_0_4 : NSObject
{
    NSMutableDictionary*            groups;
    NSMutableArray*                 links;
    NSMutableDictionary*            calendar;
    NSMutableDictionary*            _daysForPhases;
    NSMutableDictionary*            modalities;
    NSMutableArray*                 _yearKeys;
    NSMutableDictionary*            _results;
	NSData*                         xmlData;
	id <CoacParserDelegateProtocol> delegate;
    NSOperationQueue*               queue;
}

@property (nonatomic, retain) NSData*   xmlData;
@property (nonatomic, assign) id        delegate;

- (id) initWithXMLData:(NSData*) theXml delegate:(id)theDelegate;
- (void) start;

@end
