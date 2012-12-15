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



+ (NSDictionary*) phasesDatesDictionary2013
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


+ (NSArray*) allDaysForcontest2013
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

+ (NSDictionary*) resultsDictionary
{
                       // 3 coros, 3 comparsas, 3 chirigotas 3 cuartetos
    return @{@"2012":@[@79, @61, @9, @48, @101, @83, @103, @32, @92, @38, @109, @73],
             @"2013":@[@79, @61, @9, @48, @101, @83, @103, @32, @92, @38, @109, @73]};
}


+ (NSArray*) yearKeys
{
    return YEAR_KEYS_ARRAY;
}

+ (NSDictionary*) phasesDatesDictionary
{
//    NSDictionary *phasesDataDictionary = @{};
//    for (NSString *yearKey in YEAR_KEYS_ARRAY)
//    {
//        NSString *selectorString = [NSString stringWithFormat:@"%@%@", @"phasesDatesDictionary", yearKey];
//        SEL selector = NSSelectorFromString(selectorString);
//        phasesDataDictionary[yearKey] = [[ContestPhaseDatesHelper class] perform];
//    }
    return @{@"2012":[self phasesDatesDictionary2012],
             @"2013":[self phasesDatesDictionary2013]};
}


+ (NSArray*) daysForPhase:(NSString*)currentPhase forYearDescriptor:(NSString*)yearDescriptor
{    
    return [self phasesDatesDictionary][yearDescriptor];
}

@end
