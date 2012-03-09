//
//  ContestPhaseDatesHelper.m
//  Coac2012
//
//  Created by Borja Arias on 09/03/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "ContestPhaseDatesHelper.h"

@implementation ContestPhaseDatesHelper

+ (NSDictionary*) phasesDatesDictionary
{
    NSArray* diasPreliminar = [NSArray arrayWithObjects:@"21/01/2012",
                               @"22/01/2012",
                               @"23/01/2012",
                               @"24/01/2012",
                               @"25/01/2012",
                               @"26/01/2012",
                               @"27/01/2012",
                               @"28/01/2012",
                               @"29/01/2012",
                               @"30/01/2012",
                               @"31/01/2012",
                               @"01/02/2012",
                               @"02/02/2012",
                               @"03/02/2012",
                               @"04/02/2012",
                               nil];
    
    NSArray* diasCuartos = [NSArray arrayWithObjects:@"06/02/2012", 
                            @"07/02/2012", 
                            @"08/02/2012", 
                            @"09/02/2012",
                            @"10/02/2012",
                            @"11/02/2012", 
                            nil];
    
    NSArray* diasSemifinales = [NSArray arrayWithObjects:@"13/02/2012", 
                                @"14/02/2012",
                                @"15/02/2012",
                                nil];
    
    NSArray* diasFinal = [NSArray arrayWithObjects:@"17/02/2012", nil];
    
    NSDictionary* daysForPhases = [[[NSDictionary alloc] initWithObjectsAndKeys:diasPreliminar, PRELIMINAR, 
                                    diasCuartos, CUARTOS, 
                                    diasSemifinales, SEMIFINALES, 
                                    diasFinal, FINAL,
                                    nil] autorelease];
    
    return daysForPhases;
}

+ (NSArray*) daysForPhase:(NSString*) currentPhase
{
    return [[self phasesDatesDictionary] objectForKey:currentPhase];
}


+ (NSArray*) allDaysForcontest
{
    NSArray* days = [NSArray arrayWithObjects:@"21/01/2012",
                     @"22/01/2012",
                     @"23/01/2012",
                     @"24/01/2012",
                     @"25/01/2012",
                     @"26/01/2012",
                     @"27/01/2012",
                     @"28/01/2012",
                     @"29/01/2012",
                     @"30/01/2012",
                     @"31/01/2012",
                     @"01/02/2012",
                     @"02/02/2012",
                     @"03/02/2012",
                     @"04/02/2012",
                     @"06/02/2012", 
                     @"07/02/2012", 
                     @"08/02/2012", 
                     @"09/02/2012",
                     @"10/02/2012",
                     @"11/02/2012",
                     @"13/02/2012", 
                     @"14/02/2012",
                     @"15/02/2012",
                     @"17/02/2012",
                     nil];
    
    return days;
}

@end
