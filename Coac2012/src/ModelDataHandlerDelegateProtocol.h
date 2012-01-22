//
//  ModelDataHandlerDelegateProtocol.h
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelDataHandlerDelegateProtocol <NSObject>
- (void) dataIsReady:(NSDictionary*)data;
@end