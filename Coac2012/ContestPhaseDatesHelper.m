//
//  ContestPhaseDatesHelper.m
//  Coac2012
//
//  Created by Borja Arias on 09/03/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "ContestPhaseDatesHelper.h"

#define PHASES_DICTIONARY_SELECTOR_STRING @"phasesDatesDictionary"
#define YEAR_KEYS_ARRAY @[@"2013", @"2012"]

@implementation ContestPhaseDatesHelper

#pragma mark - Year specific


+ (NSArray*) allPhasesDatesForContestInYear:(NSString*)year
{
    return [self phasesDates][year];
}

+ (NSDictionary*) phasesDates
{
    return @{ @"2012" : [self phasesDatesDictionary2012],
              @"2013" : [self phasesDatesDictionary2013] };
}


+ (NSDictionary*) phasesDatesDictionary2012
{
    NSArray* diasPreliminar = @[@"21/01/2012",
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
                               @"04/02/2012"];
    
    NSArray* diasCuartos = @[@"06/02/2012", 
                            @"07/02/2012", 
                            @"08/02/2012", 
                            @"09/02/2012",
                            @"10/02/2012",
                            @"11/02/2012"];
    
    NSArray* diasSemifinales = @[@"13/02/2012", 
                                @"14/02/2012",
                                @"15/02/2012"];
    
    NSArray* diasFinal = @[@"17/02/2012"];
    
    NSDictionary* daysForPhases = [[[NSDictionary alloc] initWithObjectsAndKeys:diasPreliminar, PRELIMINAR, 
                                    diasCuartos, CUARTOS, 
                                    diasSemifinales, SEMIFINALES, 
                                    diasFinal, FINAL,
                                    nil] autorelease];
    
    return daysForPhases;
}


+ (NSDictionary*) phasesDatesDictionary2013
{
    NSArray* diasPreliminar = @[@"21/01/2013",
    @"22/01/2013",
    @"23/01/2013",
    @"24/01/2013",
    @"25/01/2013",
    @"26/01/2013",
    @"27/01/2013",
    @"28/01/2013",
    @"29/01/2013",
    @"30/01/2013",
    @"31/01/2013",
    @"01/02/2013",
    @"02/02/2013",
    @"03/02/2013",
    @"04/02/2013"];
    
    NSArray* diasCuartos = @[@"06/02/2013",
    @"07/02/2013",
    @"08/02/2013",
    @"09/02/2013",
    @"10/02/2013",
    @"11/02/2013"];
    
    NSArray* diasSemifinales = @[@"13/02/2013",
    @"14/02/2013",
    @"15/02/2013"];
    
    NSArray* diasFinal = @[@"17/02/2013"];
    
    NSDictionary* daysForPhases = [[[NSDictionary alloc] initWithObjectsAndKeys:diasPreliminar, PRELIMINAR,
                                    diasCuartos, CUARTOS,
                                    diasSemifinales, SEMIFINALES,
                                    diasFinal, FINAL,
                                    nil] autorelease];
    
    return daysForPhases;
}


+ (NSArray*) allDaysForContestInYear:(NSString*)year
{
    return [self contestsDays][year];
}

+ (NSDictionary*) contestsDays
{
    return @{@"2012" : [self allDaysForcontest2012],
             @"2013" : [self allDaysForcontest2013]};
}


+ (NSArray*) allDaysForcontest2012
{
    NSArray* days = @[@"21/01/2012",
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
    @"17/02/2012"];
    
    return days;
}


+ (NSArray*) allDaysForcontest2013
{
    NSArray* days = @[@"21/01/2013",
    @"22/01/2013",
    @"23/01/2013",
    @"24/01/2013",
    @"25/01/2013",
    @"26/01/2013",
    @"27/01/2013",
    @"28/01/2013",
    @"29/01/2013",
    @"30/01/2013",
    @"31/01/2013",
    @"01/02/2013",
    @"02/02/2013",
    @"03/02/2013",
    @"04/02/2013",
    @"06/02/2013",
    @"07/02/2013",
    @"08/02/2013",
    @"09/02/2013",
    @"10/02/2013",
    @"11/02/2013",
    @"13/02/2013",
    @"14/02/2013",
    @"15/02/2013",
    @"17/02/2013"];
    
    return days;
}


+ (NSArray*) yearKeys
{
    return YEAR_KEYS_ARRAY;
}


@end
