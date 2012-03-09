//
//  CoacEventDrivenParser.h
//  Coac2012
//
//  Created by Borja Arias on 03/03/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoacParserDelegateProtocol.h"
#import "Agrupacion.h"
#import "Componente.h"
#import "Video.h"
#import "Picture.h"
#import "Comentario.h"
#import "Link.h"

@interface CoacEventDrivenParser : NSObject <NSXMLParserDelegate>
{
	NSData*                         xmlData;
	id <CoacParserDelegateProtocol> delegate;
    
    NSOperationQueue* queue;
    NSXMLParser*      nsParser;
    
    // Parsed data structures
    NSMutableArray*      groups;
    NSMutableArray*      links;
    NSMutableDictionary* calendar;
    NSMutableDictionary* modalities;
    
    // Current data being parsed ivars
    Agrupacion* currentGroup;
    Video* currentVideo;
    Picture* currentPicture;
    Link* currentLink;
    Comentario* currentComment;
    Componente* currentComponent;
    NSString* currentDate;
    
}

@property (nonatomic, retain) NSData* xmlData;
@property (nonatomic, assign) id      delegate;

- (id) initWithXMLData:(NSData*)theXml delegate:(id)theDelegate;
- (void) start;

@end
