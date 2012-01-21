//
//  Comentario.h
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comentario : NSObject
{
    @private
    NSString* origen;
    NSString* url;
}

@property (nonatomic, copy) NSString* origen;
@property (nonatomic, copy) NSString* url;

- (id) initWithOrigen:(NSString*)theOrigen url:(NSString*)theUrl;

@end
