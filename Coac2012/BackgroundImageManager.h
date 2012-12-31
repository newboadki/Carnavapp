//
//  ImageManager.h
//  Coac2012
//
//  Created by Borja Arias Drake on 22/12/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 *PURPOSE
 This class is responsible of retrieving, processing and storing images. For instance,
 the background images for each year are retrieved and processed by this class.
 
 *USE CASES
 The processing of an image, i.e. applying a filter, takes time. There are two ways of 
 dealing with this issue, using the same API:
 
 - If the user of this class doesn't mind when the image will be ready, setBackgroundImageInView:forYear:
 can be used. The user can specify imageView where the ImageManager will set the image when ready.
 
 - If knowing the exact moment at which the image is ready is important, the user can subscribe to the
 BACKGROUND_IMAGE_FINISHED_PROCESSING. To trigger the task, setBackgroundImageInView:forYear: can 
 be called exactcly the same as in case 1. the image view parameter can be nil. 

 *CACHE
 TODO: Make this have only a diskCache, that gets loaded into an inmemory dictionary (which is already happening).
 Therefore just remove the inmemoryCache dictionary as it's redundant.
 */
@interface BackgroundImageManager : NSObject

/**
 Sets a year-specific image in the imageView parameter if not nil.
 When the image has been processed and it's ready, a BACKGROUND_IMAGE_FINISHED_PROCESSING notification gets posted.
 */
- (void) setBackgroundImageInView:(UIImageView*)imageView forYear:(NSString*)year;

/** 
 Singleton
 */
+ (id) sharedInstance;

/**
 TODO: this method is just a work-around. Find a better way to access the images.
 @return The background image for a year. It only looks into the inMemory cache. Returns nil if not found there.
 */
- (UIImage*) imageForYear:(NSString*)year;
@end
