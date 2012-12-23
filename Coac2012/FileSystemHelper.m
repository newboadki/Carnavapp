//
//  FileSystemHelper.m
//  Coac2012
//
//  Created by Borja Arias on 23/02/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "FileSystemHelper.h"

@implementation FileSystemHelper


+ (BOOL) archiveObject:(id)obj fileName:(NSString*)fileName
{
    BOOL success = NO;   
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectoryPath = nil;
    
    if ([paths count] > 0)
    {        
        documentsDirectoryPath = paths[0];
        NSString* dictionaryFilePath =  [documentsDirectoryPath stringByAppendingFormat:@"/%@", fileName];
        success = [NSKeyedArchiver archiveRootObject:obj toFile:dictionaryFilePath];
    }
    
    return success;
}


+ (id) unarchiveObjectWithFileName:(NSString*)fileName
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectoryPath = nil;
    id record = nil;
    
    if ([paths count] > 0)
    {        
        documentsDirectoryPath = paths[0];
        NSString* dictionaryFilePath =  [documentsDirectoryPath stringByAppendingFormat:@"/%@", fileName];
        record = [NSKeyedUnarchiver unarchiveObjectWithFile:dictionaryFilePath];
    }
    
    return record;
}

+ (BOOL) deleteObjectWithFileName:(NSString*)fileName
{
    BOOL removed = NO;
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectoryPath = nil;
    
    if ([paths count] > 0)
    {
        documentsDirectoryPath = paths[0];
        NSString* filePath =  [documentsDirectoryPath stringByAppendingFormat:@"/%@", fileName];
        removed = [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    
    return removed;
}

@end
