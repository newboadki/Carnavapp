//
//  Theme.h
//  Coac2012
//
//  Created by Borja Arias Drake on 20/01/2013.
//  Copyright (c) 2013 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Theme <NSObject>

@required
+ (id) sharedInstance;
- (UIImage*) navigationBarBackgroundImage;
- (UIImage*) navigationBarBackButtonImage;
- (UIImage*) tabBarBackgroundImage;

@end
