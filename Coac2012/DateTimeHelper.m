//
//  DateTimeHelper.m
//  Coac2012
//
//  Created by Borja Arias Drake on 15/01/2013.
//  Copyright (c) 2013 Borja Arias Drake. All rights reserved.
//

#import "DateTimeHelper.h"

@implementation DateTimeHelper

+ (NSString*) todaysDateString
{
    NSDate* today = [NSDate date];
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:COAC_DATE_FORMAT];
    NSString* todaysDateString = [df stringFromDate:today];
    [df release];
    
    return todaysDateString;
}

@end
