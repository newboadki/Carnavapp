//
//  ImageManager.m
//  Coac2012
//
//  Created by Borja Arias Drake on 22/12/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "BackgroundImageManager.h"
#import "Constants.h"
#import "FileSystemHelper.h"
#import "ContestPhaseDatesHelper.h"

@interface BackgroundImageManager ()
    @property (nonatomic, retain) NSMutableDictionary *imageInMemoryCache;
    @property (nonatomic, retain) NSMutableDictionary *imageDiskCache;
@end

static BackgroundImageManager *_sharedInstance;

@implementation BackgroundImageManager


- (id)init
{
    self = [super init];
    if (self)
    {
        _imageInMemoryCache = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}


+ (id) sharedInstance
{
    if (!_sharedInstance)
    {
        _sharedInstance = [[BackgroundImageManager alloc] init];
    }
    
    return _sharedInstance;
}


- (NSString*) backgroundImageNameForYear:(NSString*)year
{
    NSDictionary *namesForYears = @{ @"2012" : @"cartel_2012.png",
                                     @"2013" : @"cartel_2013.png"  };
    
    return namesForYears[year];
}


- (UIImage*) imageForYear:(NSString*)year
{
    return self.imageInMemoryCache[year];
}


- (void) setBackgroundImageInView:(UIImageView*)imageView forYear:(NSString*)year
{
    if (!year) {
        year = [[ContestPhaseDatesHelper yearKeys] lastObject];
    }
    
    // Try getting the images from the memory cache
    UIImage *image = self.imageInMemoryCache[year];
    if (image)
    {
        imageView.image = image;
        imageView.alpha = 0.3;
        return;
    }
    else
    {
        // Try getting the images from the disk cache
        self.imageDiskCache = [FileSystemHelper unarchiveObjectWithFileName:BACKGROUND_IMAGES_DISK_CACHE_FILE_NAME];
        
        if (!self.imageDiskCache)
        {
            self.imageDiskCache = [[[NSMutableDictionary alloc] init] autorelease];            
        }
        else
        {
            NSData  *diskCachedData = self.imageDiskCache[year];
            UIImage *diskCachedImage = [UIImage imageWithData:diskCachedData];
            if (diskCachedImage)
            {
                imageView.image = diskCachedImage;
                imageView.alpha = 0.3;
                self.imageInMemoryCache[year] = diskCachedImage;
                return;
            }
        }
    }
    
    // Apply filter
    dispatch_queue_t generationsProcessQueue =  dispatch_queue_create("generations_process_queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(generationsProcessQueue, ^{
        
        NSString* imageNameForYear = [self backgroundImageNameForYear:year];
        CGImageRef resultCGImage = [self imageWithSepiaFilterFromOriginalImageName:imageNameForYear]; // +1 !

        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *resultUIImage = [UIImage imageWithCGImage:resultCGImage];            
            imageView.image = resultUIImage;
            imageView.alpha = 0.3;
            self.imageInMemoryCache[year] = resultUIImage;
            
            NSData* uiImageData = UIImagePNGRepresentation(resultUIImage);
            self.imageDiskCache[year] = uiImageData;
            [FileSystemHelper archiveObject:self.imageDiskCache fileName:BACKGROUND_IMAGES_DISK_CACHE_FILE_NAME];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:BACKGROUND_IMAGE_FINISHED_PROCESSING object:nil];
            
            CGImageRelease(resultCGImage); // Balancing the retain count
        });
    });
}


/**
 This method applies a filter synchronously. Users of this method should be aware of this back and run it on 
 a background thread if pertinent.
 */
- (CGImageRef) imageWithSepiaFilterFromOriginalImageName:(NSString*)originalImageName
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [UIImage imageNamed:originalImageName].CGImage;
    CIImage *coreImageInput = [CIImage imageWithCGImage:imageRef];
    
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"];
    [filter setValue:coreImageInput forKey:kCIInputImageKey];
    [filter setValue:@0.8 forKey:@"inputIntensity"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    return [context createCGImage:result fromRect:[result extent]];
}

- (void) dealloc
{
    [_imageInMemoryCache release];
    [_imageDiskCache release];
    [super dealloc];
}

@end
