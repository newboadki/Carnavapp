#import "Kiwi.h"
#import "Constants.h"
#import "ModelDataHandler.h"
#import "FileDownloader.h"
#import "UIApplication+PRPNetworkActivity.h"

SPEC_BEGIN(ModelDataHandlerSpec)


describe(@"init", ^{
        
    it(@"should instanciate the fileDownloader", ^{
        ModelDataHandler* dataHandler = [[ModelDataHandler alloc] init];
        FileDownloader* fd = [dataHandler valueForKey:@"fileDownloader"];

        [fd shouldNotBeNil];
        [[[[fd fromURL] description] should] equal:XML_SERVER_URL];
    });    

    it(@"should set itself as the fileDownloader delegate", ^{
        ModelDataHandler* dataHandler = [[ModelDataHandler alloc] init];
        FileDownloader* fd = [dataHandler valueForKey:@"fileDownloader"];
        
        [[[fd delegate] should] equal:dataHandler];
    });

});


describe(@"cancelOperations", ^{
    
    __block ModelDataHandler* dataHandler;
    __block id sharedApplicationMock;
    
    beforeEach(^{
        dataHandler = [[ModelDataHandler alloc] init];
        id fileDownloaderMock = [KWMock nullMockForClass:[FileDownloader class]];
        [dataHandler setValue:fileDownloaderMock forKey:@"fileDownloader"];
        sharedApplicationMock = [KWMock nullMockForClass:[UIApplication class]];
        [UIApplication stub:@selector(sharedApplication) andReturn:sharedApplicationMock];
    });
    
    afterEach(^{
        [dataHandler release];
    });
    
    it(@"should cancel the download", ^{
        FileDownloader* fd = [dataHandler valueForKey:@"fileDownloader"];
        [[fd should] receive:@selector(cancelAndRemoveFile:) withArguments:theValue(YES)];
        [dataHandler cancelOperations];
    });
    
    
    it(@"should remove the parser", ^{        
        [[dataHandler should] receive:@selector(setParser:) withArguments:nil];
        [dataHandler cancelOperations];
    });
    
    it(@"should deactivate the network activity indicator", ^{
        [[sharedApplicationMock should] receive:@selector(prp_popNetworkActivity)];
        [dataHandler cancelOperations];
    });
});


describe(@"downloadAndParseModelData", ^{
    
    __block ModelDataHandler* dataHandler;
    __block id sharedApplicationMock;

    beforeEach(^{
        dataHandler = [[ModelDataHandler alloc] init];
        id fileDownloaderMock = [KWMock nullMockForClass:[FileDownloader class]];
        [dataHandler setValue:fileDownloaderMock forKey:@"fileDownloader"];
        sharedApplicationMock = [KWMock nullMockForClass:[UIApplication class]];
        [UIApplication stub:@selector(sharedApplication) andReturn:sharedApplicationMock];
    });
    
    afterEach(^{
        [dataHandler release];
    });
    
    it(@"should activate the network activity indicator", ^{
        [[sharedApplicationMock should] receive:@selector(prp_pushNetworkActivity)];
        [dataHandler downloadAndParseModelData];
    });
    
    
    it(@"should start the download", ^{
        FileDownloader* fd = [dataHandler valueForKey:@"fileDownloader"];
        [[fd should] receive:@selector(start)];
        [dataHandler downloadAndParseModelData];
    });
    
});


SPEC_END
