//
//  ModelDataHandler.m
//  Coac2012
//
//  Created by Borja Arias on 22/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "ModelDataHandler.h"
#import "UIApplication+PRPNetworkActivity.h"
#import "FileSystemHelper.h"

@interface ModelDataHandler()
@property (nonatomic, retain) CoacParser_v_1_0_4* parser;
@end

@implementation ModelDataHandler

@synthesize parser;


- (id) init
{
    self = [super init];
    
    if (self)        
    {
        fileDownloader = [[FileDownloader alloc] initWithURL:[NSURL URLWithString:XML_SERVER_URL] 
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
    
    CoacParser_v_1_0_4* p = [[CoacParser_v_1_0_4 alloc] initWithXMLData:data delegate:self];
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
    [FileSystemHelper archiveObject:resultsDictionary fileName:MODEL_DATA_FILE_NAME];
    [[NSNotificationCenter defaultCenter] postNotificationName:MODEL_DATA_IS_READY_NOTIFICATION     // Send notification
                                                        object:self 
                                                      userInfo:resultsDictionary];
    [self setParser:nil];                                                                           // Clean up
}




- (void) dealloc
{
    [fileDownloader release];
    [parser release];
    [super dealloc];
}

@end
