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
#import "ModelDataHandlerDelegateProtocol.h"
#import "CoacParser.h"
#import "CoacParserDelegateProtocol.h"

#define MODEL_DATA_IS_READY_NOTIFICATION @"ModelDataIsReadyNotification"

@interface ModelDataHandler : NSObject <FileDownloaderDelegateProtocol, CoacParserDelegateProtocol>
{
    FileDownloader* fileDownloader;
}

- (id) initWithDelegate:(id <ModelDataHandlerDelegateProtocol>)theDelegate;
- (void) downloadAndParseModelData;
@end
