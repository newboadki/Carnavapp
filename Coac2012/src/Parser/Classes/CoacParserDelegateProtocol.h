//
//  CoacParserDelegateProtocol.h
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CoacParserDelegateProtocol
- (void) parsingDidFinishWithGroups:(NSArray*)groups calendar:(NSDictionary*)calendar links:(NSArray*)links;
@end
