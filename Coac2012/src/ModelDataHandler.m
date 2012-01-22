//
//  ModelDataHandler.m
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "ModelDataHandler.h"


@interface ModelDataHandler()
@property (nonatomic, retain) CoacParser* parser;
@end

@implementation ModelDataHandler

@synthesize parser;

- (id) initWithDelegate:(id <ModelDataHandlerDelegateProtocol>)theDelegate
{
    self = [super init];
    if (self)        
    {
        fileDownloader = [[FileDownloader alloc] initWithURL:[NSURL URLWithString:@"http://jcorralejo.googlecode.com/svn/trunk/coac2012/coac2012.xml"] 
                                                 andFilePath: nil // it won't write it to a file 
                                               andCredential: nil 
                                                 andDelegate: self];
    }
    return self;
}


- (void) downloadAndParseModelData
{
    [fileDownloader start];
}



#pragma mark - FileDownloaderDelegate protocol

- (void) handleSuccessfullDownloadWithData:(NSData*)data
{
    CoacParser* p = [[CoacParser alloc] initWithXMLData:data delegate:self];
    [self setParser:p];
    [p release];
    [self.parser start];
}

- (void) handleFailedDownloadWithError:(NSError *)error{}
- (void) handleAuthenticationFailed{}
- (void) connectionReceivedResponseWithErrorCode:(NSInteger) statusCode{}
- (void) connectionCouldNotBeCreated{}



#pragma mark - CoacParserDelegate protocol

- (void) parsingDidFinishWithResultsDictionary:(NSDictionary*)resultsDictionary
{
    [[NSNotificationCenter defaultCenter] postNotificationName:MODEL_DATA_IS_READY_NOTIFICATION object:self userInfo:resultsDictionary];
    [self setParser:nil];
}


- (void) dealloc
{
    [fileDownloader release];
    [parser release];
    [super dealloc];
}

@end
