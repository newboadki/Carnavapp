//
//  CoacPaser_v_1_0_3.h
//  DownloadFromURL
//
//  Created by Borja Arias Drake on 16/12/2012.
//  Copyright 2010 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TouchXML.h"
#import "CoacParserDelegateProtocol.h"
#import "Constants.h"

@interface CoacParser_v_1_0_3 : NSObject
{
    NSMutableArray*      groups;
    NSMutableArray*      links;
    NSMutableDictionary* calendar;
    NSMutableDictionary* modalities;
    NSMutableArray*      _yearKeys;
	NSData*              xmlData;
	id <CoacParserDelegateProtocol> delegate;
    NSOperationQueue*    queue;
}

@property (nonatomic, retain)   NSData*   xmlData;
@property (nonatomic, assign) id        delegate;

- (id) initWithXMLData:(NSData*) theXml delegate:(id)theDelegate;
- (void) start;

@end


