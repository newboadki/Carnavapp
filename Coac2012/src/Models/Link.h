//
//  Link.h
//  Coac2012
//
//  Created by Borja Arias on 21/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Link : NSObject
{
    @private
    NSString* type;
    NSString* desc;
    NSString* url;
}

@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* desc;
@property (nonatomic, copy) NSString* url;

- (id) initWithType:(NSString*)theType description:(NSString*)theDesc url:(NSString*)theUrl;

@end
