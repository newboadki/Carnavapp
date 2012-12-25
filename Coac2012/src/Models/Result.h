//
//  Result.h
//  Coac2012
//
//  Created by Borja Arias Drake on 24/12/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Result : NSObject


@property (nonatomic, copy) NSString* groupId;
@property (nonatomic, copy) NSString* phase;
@property (nonatomic, retain) NSNumber* points;
@property (nonatomic, copy) NSString* modality;

- (id) initWithGroupId:(NSString*)theGroupId
                 phase:(NSString*)thePhase
                points:(NSNumber*)thePoints
              modality:(NSString*)theModality;

@end
