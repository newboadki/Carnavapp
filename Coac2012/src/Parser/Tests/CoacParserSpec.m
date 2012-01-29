

#import "Kiwi.h"
#import "CoacParser.h"
#import "TouchXML.h"
#import "CoacParserDelegateProtocol.h"

SPEC_BEGIN(CoacParserSpec)


    describe(@"Parsing a group", ^{

        __block CoacParser* parser;
        
        beforeEach(^{
            NSError* err = nil;
            NSString* path = [[NSBundle bundleForClass:[self class]] pathForResource:@"group" ofType:@"xml"];
            NSData* xmlData = [[NSData alloc] initWithContentsOfFile:path options:nil error:&err];
            parser = [[CoacParser alloc] initWithXMLData:xmlData delegate:self];
        });
        
        it(@"", ^{});
        
    });


SPEC_END