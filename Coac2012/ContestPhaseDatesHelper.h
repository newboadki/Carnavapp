//
//  ContestPhaseDatesHelper.h
//  Coac2012
//
//  Created by Borja Arias on 09/03/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContestPhaseDatesHelper : NSObject

+ (NSDictionary*) phasesDatesDictionary;
+ (NSArray*) daysForPhase:(NSString*) currentPhase;
+ (NSArray*) allDaysForcontest;

@end
