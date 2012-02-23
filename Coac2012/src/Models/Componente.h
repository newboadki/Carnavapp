//
//  Componente.h
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Componente : NSObject <NSCoding>
{
    @private
    NSString* nombre;
    NSString* voz;
}

@property (nonatomic, copy) NSString* nombre;
@property (nonatomic, copy) NSString* voz;

- (id) initWithName:(NSString*)name andVoice:(NSString*)voice;

@end
