//
//  FileSystemHelper.h
//  Coac2012
//
//  Created by Borja Arias on 23/02/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileSystemHelper : NSObject

+ (BOOL) archiveObject:(id)obj fileName:(NSString*)fileName;
+ (id) unarchiveObjectWithFileName:(NSString*)fileName;
+ (BOOL) deleteObjectWithFileName:(NSString*)fileName;

@end
