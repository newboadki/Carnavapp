//
//  Result.m
//  Coac2012
//
//  Created by Borja Arias Drake on 24/12/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "Result.h"
#import "Constants.h"

#define RESULT_GROUP_ID_KEY @"resultGroupIdKey"
#define RESULT_PHASE_KEY @"resultPhaseKey"
#define RESULT_POINTS_KEY @"resultPointsKey"
#define RESULT_MODALITY_KEY @"resultModalityKey"

@implementation Result

@synthesize groupId = _groupId;
@synthesize phase = _phase;
@synthesize points = _points;
@synthesize modality = _modality;



#pragma mark - Initializers

- (id) initWithGroupId:(NSString*)theGroupId
                 phase:(NSString*)thePhase
                points:(NSNumber*)thePoints
                 modality:(NSString*)theModality
{
    self = [super init];
    
    if(self)
    {
        _groupId = [theGroupId copy];
        _phase = [thePhase copy];
        _points = [thePoints retain];
        _modality = [theModality copy];
    }
    
    return self;
}



#pragma mark - NSEncoding

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        _groupId = [[decoder decodeObjectForKey:RESULT_GROUP_ID_KEY] copy];
        _phase = [[decoder decodeObjectForKey:RESULT_PHASE_KEY] copy];
        _points = [[decoder decodeObjectForKey:RESULT_POINTS_KEY] retain];
        _modality = [[decoder decodeObjectForKey:RESULT_MODALITY_KEY] copy];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.groupId forKey:RESULT_GROUP_ID_KEY];
    [encoder encodeObject:self.phase forKey:RESULT_PHASE_KEY];
    [encoder encodeObject:self.points forKey:RESULT_POINTS_KEY];
    [encoder encodeObject:self.modality forKey:RESULT_MODALITY_KEY];
}



#pragma mark - Memory management

- (void) dealloc
{
    [_groupId release];
    [_phase release];
    [_points release];
    [_modality release];
    [super dealloc];
}
@end
