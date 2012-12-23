//
//  ImageManager.h
//  Coac2012
//
//  Created by Borja Arias Drake on 22/12/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageManager : NSObject

- (void) setBackgroundImageInView:(UIImageView*)imageView forYear:(NSString*)year;
+ (id) sharedInstance;
- (UIImage*) imageForYear:(NSString*)year;
@end
