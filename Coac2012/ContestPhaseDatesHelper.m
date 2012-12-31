//
//  ContestPhaseDatesHelper.m
//  Coac2012
//
//  Created by Borja Arias on 09/03/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "ContestPhaseDatesHelper.h"

#define PHASES_DICTIONARY_SELECTOR_STRING @"phasesDatesDictionary"
#define YEAR_KEYS_ARRAY @[@"2012", @"2013"]

@implementation ContestPhaseDatesHelper

#pragma mark - Year specific

+ (NSArray*) yearKeys
{
    return YEAR_KEYS_ARRAY;
}

@end
