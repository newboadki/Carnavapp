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
 @param year It's a string representing a year with the following format 'YYYY'
 */
+ (NSArray*) allDaysForContestInYear:(NSString*)year;

/**
 @param year It's a string representing a year with the following format 'YYYY'
 */
+ (NSArray*) allPhasesDatesForContestInYear:(NSString*)year;

/**
 @return Dictionary containing the days of the contests per year.
 */
+ (NSDictionary*) contestsDays;

/**
 @return Dictionary containing the phases of the contests per year.
 */
+ (NSDictionary*) phasesDates;


/**
 @return array of years the app supports.
 */
+ (NSArray*) yearKeys;


@end
