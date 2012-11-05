//
//  FileSystemHelper.m
//  Coac2012
//
//  Created by Borja Arias on 23/02/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "FileSystemHelper.h"

@implementation FileSystemHelper


+ (BOOL) archiveObject:(id)obj
{
    BOOL success = NO;   
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectoryPath = nil;
    
    if ([paths count] > 0)
    {        
        documentsDirectoryPath = paths[0];
        NSString* dictionaryFilePath =  [documentsDirectoryPath stringByAppendingFormat:@"/%@", MODEL_DATA_FILE_NAME];
        success = [NSKeyedArchiver archiveRootObject:obj toFile:dictionaryFilePath];
    }
    
    return success;
}


+ (id) unarchiveDataModel
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectoryPath = nil;
    id record = nil;
    
    if ([paths count] > 0)
    {        
        documentsDirectoryPath = paths[0];
        NSString* dictionaryFilePath =  [documentsDirectoryPath stringByAppendingFormat:@"/%@", MODEL_DATA_FILE_NAME];
        record = [NSKeyedUnarchiver unarchiveObjectWithFile:dictionaryFilePath];
    }
    
    return record;
}

@end
