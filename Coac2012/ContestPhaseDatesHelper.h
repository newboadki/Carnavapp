//
//  ContestPhaseDatesHelper.h
//  Coac2012
//
//  Created by Borja Arias on 09/03/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContestPhaseDatesHelper : NSObject



#pragma mark - Generic

/**
 @param forYearDescriptor It's a string representing a year with the following format 'YYYY'
 */
+ (NSArray*) daysForPhase:(NSString*)currentPhase forYearDescriptor:(NSString*)yearDescriptor;

+ (NSDictionary*) phasesDatesDictionary;



#pragma mark - Year specific

+ (NSArray*) allDaysForcontest2012;
+ (NSDictionary*) phasesDatesDictionary2012;

+ (NSArray*) allDaysForcontest2013;
+ (NSDictionary*) phasesDatesDictionary2013;

+ (NSDictionary*) resultsDictionary;

+ (NSArray*) yearKeys;
@end
