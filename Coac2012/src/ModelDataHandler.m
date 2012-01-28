//
//  ModelDataHandler.m
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "ModelDataHandler.h"
#import "UIApplication+PRPNetworkActivity.h"

    
@interface ModelDataHandler()
@property (nonatomic, retain) CoacParser* parser;
@end

@implementation ModelDataHandler

@synthesize parser;


- (id) init
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



#pragma mark - Public Interface

- (void) downloadAndParseModelData
{
    [[UIApplication sharedApplication] prp_pushNetworkActivity];
    [fileDownloader start];
}


- (void) cancelOperations
{
    [fileDownloader cancelAndRemoveFile:YES];                   // Stop the download
    [self setParser:nil];                                       // Stop the parser
    [[UIApplication sharedApplication] prp_popNetworkActivity]; // Show Network indicator
}



#pragma mark - FileDownloaderDelegate protocol

- (void) handleSuccessfullDownloadWithData:(NSData*)data
{
    [[UIApplication sharedApplication] prp_popNetworkActivity];      // Hide Network indicator
    
    CoacParser* p = [[CoacParser alloc] initWithXMLData:data delegate:self];
    [self setParser:p];
    [p release];
    [self.parser start];
}

- (void) handleFailedDownloadWithError:(NSError *)error
{
    [[UIApplication sharedApplication] prp_popNetworkActivity];      // Hide Network indicator
    [[NSNotificationCenter defaultCenter] postNotificationName:NO_NETWORK_NOTIFICATION object:self userInfo:nil];

}

- (void) handleAuthenticationFailed
{
    [[UIApplication sharedApplication] prp_popNetworkActivity];      // Hide Network indicator
    [[NSNotificationCenter defaultCenter] postNotificationName:NO_NETWORK_NOTIFICATION object:self userInfo:nil];
}

- (void) connectionReceivedResponseWithErrorCode:(NSInteger) statusCode
{
    [[UIApplication sharedApplication] prp_popNetworkActivity];      // Hide Network indicator
    [[NSNotificationCenter defaultCenter] postNotificationName:NO_NETWORK_NOTIFICATION object:self userInfo:nil];
}


- (void) connectionCouldNotBeCreated
{
    [[UIApplication sharedApplication] prp_popNetworkActivity];      // Hide Network indicator
    [[NSNotificationCenter defaultCenter] postNotificationName:NO_NETWORK_NOTIFICATION object:self userInfo:nil];
}



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
