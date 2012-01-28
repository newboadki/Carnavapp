//
//  ModelDataHandler.h
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileDownloader.h"
#import "FileDownloaderDelegateProtocol.h"
#import "CoacParser.h"
#import "CoacParserDelegateProtocol.h"
#import "Constants.h"

@interface ModelDataHandler : NSObject <FileDownloaderDelegateProtocol, CoacParserDelegateProtocol>
{
    FileDownloader* fileDownloader;
}

- (void) downloadAndParseModelData;
- (void) cancelOperations;
@end
