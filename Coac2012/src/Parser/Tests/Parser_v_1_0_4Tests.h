//
//  Parser_v_1_0_4Tests.h
//  Farmacy
//
//  Created by Borja Arias Drake on 23/10/2010.
//  Copyright 2010 Borja Arias Drake. All rights reserved.
//
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

//  Application unit tests contain unit test code that must be injected into an application to run correctly.
//  Define USE_APPLICATION_UNIT_TEST to 0 if the unit test code is designed to be linked into an independent test executable.

#import <SenTestingKit/SenTestingKit.h>
#import "TouchXML.h"
#import "Kiwi.h"
#import "Constants.h"
#import "CoacParserDelegateProtocol.h"
#import "CoacParser_v_1_0_4.h"

@interface Parser_v_1_0_4Tests : SenTestCase <CoacParserDelegateProtocol>
{
    CoacParser_v_1_0_4* parser;
}

@end
