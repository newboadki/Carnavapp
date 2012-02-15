#import "Kiwi.h"
#import "Constants.h"
#import "BaseCoacListViewController.h"
#import "SearchResultsTableViewController.h"
#import "OCMock.h"
#import "GroupNameSearchController.h"
#import "Agrupacion.h"

SPEC_BEGIN(BaseCoacListViewControllerSpec)

/*describe(@"initWithCoder:", ^{
    
    
    it(@"should subscribe as an observer of MODEL_DATA_IS_READY_NOTIFICATION", ^{
        //        id notificationCenterMock = [KWMock mockForClass:[NSNotificationCenter class]];
        //        [NSNotificationCenter stub:@selector(defaultCenter) andReturn:notificationCenterMock];                
        //        
        //        [[notificationCenterMock should] receive:@selector(addObserver:selector:name:object:) withCount:1];
        //
        //        BaseCoacListViewController* controller = [[BaseCoacListViewController alloc] initWithCoder:nil];
        //
        //        [controller release];
    });

    it(@"should subscribe as an observer of NO_NETWORK_NOTIFICATION", ^{
        //        id notificationCenterMock = [KWMock nullMockForClass:[NSNotificationCenter class]];
        //        [NSNotificationCenter stub:@selector(defaultCenter) andReturn:notificationCenterMock];                
        //        
        ////        [[notificationCenterMock should] receive:@selector(addObserver:selector:name:object:) withArguments:controller, theValue(@selector(handleDataIsReady:)), NO_NETWORK_NOTIFICATION, nil];
        //        BaseCoacListViewController* controller = [[BaseCoacListViewController alloc] init];
        //        [[notificationCenterMock should] receive:@selector(addObserver:selector:name:object:) withArguments:controller, @selector(handleDataIsReady:), NO_NETWORK_NOTIFICATION, nil];
        //        
        //        controller = [[BaseCoacListViewController alloc] init];
        //        
        //        [controller release];
    });
    
});

describe(@"dealloc", ^{
    
    it(@"should unsubscribe as an observer of MODEL_DATA_IS_READY_NOTIFICATION", ^{
    });
    
    it(@"should unsubscribe as an observer of NO_NETWORK_NOTIFICATION", ^{
    });
    
});*/

describe(@"handleDataIsReady:", ^{

    __block BaseCoacListViewController* controller;
    __block id userInfoDicMock;
    __block id notifMock;
    
    beforeEach(^{
        controller = [[BaseCoacListViewController alloc] init];
        userInfoDicMock = [KWMock nullMockForClass:[NSDictionary class]];
        notifMock = [KWMock nullMockForClass:[NSNotification class]];
        id searchResultsTableViewControllerMock = [KWMock nullMockForClass:[SearchResultsTableViewController class]];
        
        [notifMock stub:@selector(userInfo) andReturn:userInfoDicMock];
        controller.searchResultsTableViewController = searchResultsTableViewControllerMock;
    });
    
    afterEach(^{
        [controller release];
    });

    it(@"should set the model data Property from the notification's userInfo dictionary", ^{
        [[controller.searchResultsTableViewController should] receive:@selector(setModelData:) withArguments:userInfoDicMock];        
        [controller handleDataIsReady:notifMock];
    });
    
    it(@"should send the updateArrayOfElements message", ^{
        [[controller should] receive:@selector(updateArrayOfElements)];        
        [controller handleDataIsReady:notifMock];
    });
    
    it(@"should set the model data property on the searchResultsTableViewController", ^{        
        [controller handleDataIsReady:notifMock];        
        [[userInfoDicMock should] equal:controller.modelData];
    });
    
});

describe(@"viewWillAppear:", ^{
    
    context(@"self doesn't implement search and firstTimeViewWillAppear is true", ^{
 
        __block BaseCoacListViewController* controller;
        
        beforeEach(^{
            controller = [[BaseCoacListViewController alloc] init];
            [controller setValue:[NSNumber numberWithInt:1] forKey:@"firstTimeViewWillAppear"];
            [controller stub:@selector(implementsSearch) andReturn:theValue(NO)];        
        });
        
        afterEach(^{
            [controller release];
        });
        
        
        it(@"should set searchResultsTableViewController to nil", ^{
            [[controller should] receive:@selector(setSearchResultsTableViewController:) withArguments:nil];
            [controller viewWillAppear:YES]; 
        });
        
        it(@"should set the tableView's contentSize to make up space for the search bar", ^{
            // Create the mocks
            id tableViewMock = [KWMock nullMockForClass:[UITableView class]];
            id searchDisplayControllerMock = [KWMock nullMockForClass:[UISearchDisplayController class]];
            id searchBarMock = [KWMock nullMockForClass:[UISearchBar class]];
            
            // Set up the mocks
            CGRect searchBarMockFrame = CGRectMake(0, 0, 320, 33);
            [searchBarMock stub:@selector(frame) andReturn:theValue(searchBarMockFrame)];
            [searchDisplayControllerMock stub:@selector(searchBar) andReturn:searchBarMock];
            
            // Connect the mocks to the controller
            [controller stub:@selector(searchDisplayController) andReturn:searchDisplayControllerMock];
            controller.tableView = tableViewMock;
            CGPoint offset = CGPointMake(0, 33);
            [[tableViewMock should] receive:@selector(setContentOffset:) withArguments:theValue(offset)];
            [controller viewWillAppear:YES]; 
        });

        it(@"should set the tableView's contentInset to make up space for the search bar", ^{
            // Create the mocks
            id tableViewMock = [KWMock nullMockForClass:[UITableView class]];
            id searchDisplayControllerMock = [KWMock nullMockForClass:[UISearchDisplayController class]];
            id searchBarMock = [KWMock nullMockForClass:[UISearchBar class]];
            
            // Set up the mocks
            CGRect searchBarMockFrame = CGRectMake(0, 0, 320, 33);
            [searchBarMock stub:@selector(frame) andReturn:theValue(searchBarMockFrame)];
            [searchDisplayControllerMock stub:@selector(searchBar) andReturn:searchBarMock];
            
            // Connect the mocks to the controller
            [controller stub:@selector(searchDisplayController) andReturn:searchDisplayControllerMock];
            controller.tableView = tableViewMock;
            UIEdgeInsets inset = UIEdgeInsetsMake(-33, 0, 0, 0);
            [[tableViewMock should] receive:@selector(setContentInset:) withArguments:theValue(inset)];
            [controller viewWillAppear:YES]; 
        });
        
        it(@"should set the tableView's contentSize not have space for the search bar", ^{
            // Create the mocks
            id tableViewMock = [KWMock nullMockForClass:[UITableView class]];
            id searchDisplayControllerMock = [KWMock nullMockForClass:[UISearchDisplayController class]];
            id searchBarMock = [KWMock nullMockForClass:[UISearchBar class]];
            
            // Set up the mocks
            CGSize tableViewContentSize = CGSizeMake(320, 480);
            CGRect searchBarMockFrame = CGRectMake(0, 0, 320, 33);
            [searchBarMock stub:@selector(frame) andReturn:theValue(searchBarMockFrame)];
            [tableViewMock stub:@selector(contentSize) andReturn:theValue(tableViewContentSize)];
            [searchDisplayControllerMock stub:@selector(searchBar) andReturn:searchBarMock];
            
            // Connect the mocks to the controller
            [controller stub:@selector(searchDisplayController) andReturn:searchDisplayControllerMock];
            controller.tableView = tableViewMock;
            [[tableViewMock should] receive:@selector(setContentSize:) withArguments:theValue(CGSizeMake(320, 447))];
            [controller viewWillAppear:YES]; 
        });
        
        it(@"should hide the search bar", ^{
            // Create the mocks
            id tableViewMock = [KWMock nullMockForClass:[UITableView class]];
            id searchDisplayControllerMock = [KWMock nullMockForClass:[UISearchDisplayController class]];
            id searchBarMock = [KWMock nullMockForClass:[UISearchBar class]];
            
            // Set up the mocks
            [searchDisplayControllerMock stub:@selector(searchBar) andReturn:searchBarMock];
            
            // Connect the mocks to the controller
            [controller stub:@selector(searchDisplayController) andReturn:searchDisplayControllerMock];
            controller.tableView = tableViewMock;
            [[searchBarMock should] receive:@selector(setHidden:) withArguments:theValue(YES)];
            [controller viewWillAppear:YES]; 
        });
    });

    context(@"self doesn't implement search and firstTimeViewWillAppear is false", ^{
        __block BaseCoacListViewController* controller;
        beforeEach(^{
            controller = [[BaseCoacListViewController alloc] init];
            [controller setValue:[NSNumber numberWithInt:0] forKey:@"firstTimeViewWillAppear"];
            [controller stub:@selector(implementsSearch) andReturn:theValue(NO)];        
        });
        
        afterEach(^{
            [controller release];
        });

        it(@"should not set searchResultsTableViewController to nil", ^{
            [[controller shouldNot] receive:@selector(setSearchResultsTableViewController:) withArguments:nil];
            [controller viewWillAppear:YES];
        });
        
        it(@"should not set the tableView's contentSize to make up space for the search bar", ^{
            // Create the mocks
            id tableViewMock = [KWMock nullMockForClass:[UITableView class]];
            id searchDisplayControllerMock = [KWMock nullMockForClass:[UISearchDisplayController class]];
            id searchBarMock = [KWMock nullMockForClass:[UISearchBar class]];
            
            // Set up the mocks
            CGRect searchBarMockFrame = CGRectMake(0, 0, 320, 33);
            [searchBarMock stub:@selector(frame) andReturn:theValue(searchBarMockFrame)];
            [searchDisplayControllerMock stub:@selector(searchBar) andReturn:searchBarMock];
            
            // Connect the mocks to the controller
            [controller stub:@selector(searchDisplayController) andReturn:searchDisplayControllerMock];
            controller.tableView = tableViewMock;
            CGPoint offset = CGPointMake(0, 33);
            [[tableViewMock shouldNot] receive:@selector(setContentOffset:) withArguments:theValue(offset)];
            [controller viewWillAppear:YES]; 
        });
        
        it(@"should not set the tableView's contentInset to make up space for the search bar", ^{
            // Create the mocks
            id tableViewMock = [KWMock nullMockForClass:[UITableView class]];
            id searchDisplayControllerMock = [KWMock nullMockForClass:[UISearchDisplayController class]];
            id searchBarMock = [KWMock nullMockForClass:[UISearchBar class]];
            
            // Set up the mocks
            CGRect searchBarMockFrame = CGRectMake(0, 0, 320, 33);
            [searchBarMock stub:@selector(frame) andReturn:theValue(searchBarMockFrame)];
            [searchDisplayControllerMock stub:@selector(searchBar) andReturn:searchBarMock];
            
            // Connect the mocks to the controller
            [controller stub:@selector(searchDisplayController) andReturn:searchDisplayControllerMock];
            controller.tableView = tableViewMock;
            UIEdgeInsets inset = UIEdgeInsetsMake(-33, 0, 0, 0);
            [[tableViewMock shouldNot] receive:@selector(setContentInset:) withArguments:theValue(inset)];
            [controller viewWillAppear:YES]; 
        });
        
        it(@"should not set the tableView's contentSize not have space for the search bar", ^{
            // Create the mocks
            id tableViewMock = [KWMock nullMockForClass:[UITableView class]];
            id searchDisplayControllerMock = [KWMock nullMockForClass:[UISearchDisplayController class]];
            id searchBarMock = [KWMock nullMockForClass:[UISearchBar class]];
            
            // Set up the mocks
            CGSize tableViewContentSize = CGSizeMake(320, 480);
            CGRect searchBarMockFrame = CGRectMake(0, 0, 320, 33);
            [searchBarMock stub:@selector(frame) andReturn:theValue(searchBarMockFrame)];
            [tableViewMock stub:@selector(contentSize) andReturn:theValue(tableViewContentSize)];
            [searchDisplayControllerMock stub:@selector(searchBar) andReturn:searchBarMock];
            
            // Connect the mocks to the controller
            [controller stub:@selector(searchDisplayController) andReturn:searchDisplayControllerMock];
            controller.tableView = tableViewMock;
            [[tableViewMock shouldNot] receive:@selector(setContentSize:) withArguments:theValue(CGSizeMake(320, 447))];
            [controller viewWillAppear:YES]; 
        });
        
        it(@"should not hide the search bar", ^{
            // Create the mocks
            id tableViewMock = [KWMock nullMockForClass:[UITableView class]];
            id searchDisplayControllerMock = [KWMock nullMockForClass:[UISearchDisplayController class]];
            id searchBarMock = [KWMock nullMockForClass:[UISearchBar class]];
            
            // Set up the mocks
            [searchDisplayControllerMock stub:@selector(searchBar) andReturn:searchBarMock];
            
            // Connect the mocks to the controller
            [controller stub:@selector(searchDisplayController) andReturn:searchDisplayControllerMock];
            controller.tableView = tableViewMock;
            [[searchBarMock shouldNot] receive:@selector(setHidden:) withArguments:theValue(YES)];
            [controller viewWillAppear:YES]; 
        });

    });

    context(@"self implements search and firstTimeViewWillAppear is true", ^{
        __block BaseCoacListViewController* controller;
        beforeEach(^{
            controller = [[BaseCoacListViewController alloc] init];
            [controller setValue:[NSNumber numberWithInt:1] forKey:@"firstTimeViewWillAppear"];
            [controller stub:@selector(implementsSearch) andReturn:theValue(YES)];        
        });
        
        afterEach(^{
            [controller release];
        });

        it(@"should not set searchResultsTableViewController to nil", ^{
            [[controller shouldNot] receive:@selector(setSearchResultsTableViewController:) withArguments:nil];
            [controller viewWillAppear:YES];
        });

        it(@"should not set the tableView's contentSize to make up space for the search bar", ^{
            // Create the mocks
            id tableViewMock = [KWMock nullMockForClass:[UITableView class]];
            id searchDisplayControllerMock = [KWMock nullMockForClass:[UISearchDisplayController class]];
            id searchBarMock = [KWMock nullMockForClass:[UISearchBar class]];
            
            // Set up the mocks
            CGRect searchBarMockFrame = CGRectMake(0, 0, 320, 33);
            [searchBarMock stub:@selector(frame) andReturn:theValue(searchBarMockFrame)];
            [searchDisplayControllerMock stub:@selector(searchBar) andReturn:searchBarMock];
            
            // Connect the mocks to the controller
            [controller stub:@selector(searchDisplayController) andReturn:searchDisplayControllerMock];
            controller.tableView = tableViewMock;
            CGPoint offset = CGPointMake(0, 33);
            [[tableViewMock shouldNot] receive:@selector(setContentOffset:) withArguments:theValue(offset)];
            [controller viewWillAppear:YES]; 
        });
        
        it(@"should not set the tableView's contentInset to make up space for the search bar", ^{
            // Create the mocks
            id tableViewMock = [KWMock nullMockForClass:[UITableView class]];
            id searchDisplayControllerMock = [KWMock nullMockForClass:[UISearchDisplayController class]];
            id searchBarMock = [KWMock nullMockForClass:[UISearchBar class]];
            
            // Set up the mocks
            CGRect searchBarMockFrame = CGRectMake(0, 0, 320, 33);
            [searchBarMock stub:@selector(frame) andReturn:theValue(searchBarMockFrame)];
            [searchDisplayControllerMock stub:@selector(searchBar) andReturn:searchBarMock];
            
            // Connect the mocks to the controller
            [controller stub:@selector(searchDisplayController) andReturn:searchDisplayControllerMock];
            controller.tableView = tableViewMock;
            UIEdgeInsets inset = UIEdgeInsetsMake(-33, 0, 0, 0);
            [[tableViewMock shouldNot] receive:@selector(setContentInset:) withArguments:theValue(inset)];
            [controller viewWillAppear:YES]; 
        });
        
        it(@"should not set the tableView's contentSize not have space for the search bar", ^{
            // Create the mocks
            id tableViewMock = [KWMock nullMockForClass:[UITableView class]];
            id searchDisplayControllerMock = [KWMock nullMockForClass:[UISearchDisplayController class]];
            id searchBarMock = [KWMock nullMockForClass:[UISearchBar class]];
            
            // Set up the mocks
            CGSize tableViewContentSize = CGSizeMake(320, 480);
            CGRect searchBarMockFrame = CGRectMake(0, 0, 320, 33);
            [searchBarMock stub:@selector(frame) andReturn:theValue(searchBarMockFrame)];
            [tableViewMock stub:@selector(contentSize) andReturn:theValue(tableViewContentSize)];
            [searchDisplayControllerMock stub:@selector(searchBar) andReturn:searchBarMock];
            
            // Connect the mocks to the controller
            [controller stub:@selector(searchDisplayController) andReturn:searchDisplayControllerMock];
            controller.tableView = tableViewMock;
            [[tableViewMock shouldNot] receive:@selector(setContentSize:) withArguments:theValue(CGSizeMake(320, 447))];
            [controller viewWillAppear:YES]; 
        });
        
        it(@"should not hide the search bar", ^{
            // Create the mocks
            id tableViewMock = [KWMock nullMockForClass:[UITableView class]];
            id searchDisplayControllerMock = [KWMock nullMockForClass:[UISearchDisplayController class]];
            id searchBarMock = [KWMock nullMockForClass:[UISearchBar class]];
            
            // Set up the mocks
            [searchDisplayControllerMock stub:@selector(searchBar) andReturn:searchBarMock];
            
            // Connect the mocks to the controller
            [controller stub:@selector(searchDisplayController) andReturn:searchDisplayControllerMock];
            controller.tableView = tableViewMock;
            [[searchBarMock shouldNot] receive:@selector(setHidden:) withArguments:theValue(YES)];
            [controller viewWillAppear:YES]; 
        });
    });


    context(@"self implements search and firstTimeViewWillAppear is false", ^{
        __block BaseCoacListViewController* controller;
        beforeEach(^{
            controller = [[BaseCoacListViewController alloc] init];
            [controller setValue:[NSNumber numberWithInt:0] forKey:@"firstTimeViewWillAppear"];
            [controller stub:@selector(implementsSearch) andReturn:theValue(YES)];        
        });
        
        afterEach(^{
            [controller release];
        });

        it(@"should not set searchResultsTableViewController to nil", ^{
            [[controller shouldNot] receive:@selector(setSearchResultsTableViewController:) withArguments:nil];
            [controller viewWillAppear:YES];
        });
        
        it(@"should not set the tableView's contentSize to make up space for the search bar", ^{
            // Create the mocks
            id tableViewMock = [KWMock nullMockForClass:[UITableView class]];
            id searchDisplayControllerMock = [KWMock nullMockForClass:[UISearchDisplayController class]];
            id searchBarMock = [KWMock nullMockForClass:[UISearchBar class]];
            
            // Set up the mocks
            CGRect searchBarMockFrame = CGRectMake(0, 0, 320, 33);
            [searchBarMock stub:@selector(frame) andReturn:theValue(searchBarMockFrame)];
            [searchDisplayControllerMock stub:@selector(searchBar) andReturn:searchBarMock];
            
            // Connect the mocks to the controller
            [controller stub:@selector(searchDisplayController) andReturn:searchDisplayControllerMock];
            controller.tableView = tableViewMock;
            CGPoint offset = CGPointMake(0, 33);
            [[tableViewMock shouldNot] receive:@selector(setContentOffset:) withArguments:theValue(offset)];
            [controller viewWillAppear:YES]; 
        });
        
        it(@"should not set the tableView's contentInset to make up space for the search bar", ^{
            // Create the mocks
            id tableViewMock = [KWMock nullMockForClass:[UITableView class]];
            id searchDisplayControllerMock = [KWMock nullMockForClass:[UISearchDisplayController class]];
            id searchBarMock = [KWMock nullMockForClass:[UISearchBar class]];
            
            // Set up the mocks
            CGRect searchBarMockFrame = CGRectMake(0, 0, 320, 33);
            [searchBarMock stub:@selector(frame) andReturn:theValue(searchBarMockFrame)];
            [searchDisplayControllerMock stub:@selector(searchBar) andReturn:searchBarMock];
            
            // Connect the mocks to the controller
            [controller stub:@selector(searchDisplayController) andReturn:searchDisplayControllerMock];
            controller.tableView = tableViewMock;
            UIEdgeInsets inset = UIEdgeInsetsMake(-33, 0, 0, 0);
            [[tableViewMock shouldNot] receive:@selector(setContentInset:) withArguments:theValue(inset)];
            [controller viewWillAppear:YES]; 
        });
        
        it(@"should not set the tableView's contentSize not have space for the search bar", ^{
            // Create the mocks
            id tableViewMock = [KWMock nullMockForClass:[UITableView class]];
            id searchDisplayControllerMock = [KWMock nullMockForClass:[UISearchDisplayController class]];
            id searchBarMock = [KWMock nullMockForClass:[UISearchBar class]];
            
            // Set up the mocks
            CGSize tableViewContentSize = CGSizeMake(320, 480);
            CGRect searchBarMockFrame = CGRectMake(0, 0, 320, 33);
            [searchBarMock stub:@selector(frame) andReturn:theValue(searchBarMockFrame)];
            [tableViewMock stub:@selector(contentSize) andReturn:theValue(tableViewContentSize)];
            [searchDisplayControllerMock stub:@selector(searchBar) andReturn:searchBarMock];
            
            // Connect the mocks to the controller
            [controller stub:@selector(searchDisplayController) andReturn:searchDisplayControllerMock];
            controller.tableView = tableViewMock;
            [[tableViewMock shouldNot] receive:@selector(setContentSize:) withArguments:theValue(CGSizeMake(320, 447))];
            [controller viewWillAppear:YES]; 
        });
        
        it(@"should not hide the search bar", ^{
            // Create the mocks
            id tableViewMock = [KWMock nullMockForClass:[UITableView class]];
            id searchDisplayControllerMock = [KWMock nullMockForClass:[UISearchDisplayController class]];
            id searchBarMock = [KWMock nullMockForClass:[UISearchBar class]];
            
            // Set up the mocks
            [searchDisplayControllerMock stub:@selector(searchBar) andReturn:searchBarMock];
            
            // Connect the mocks to the controller
            [controller stub:@selector(searchDisplayController) andReturn:searchDisplayControllerMock];
            controller.tableView = tableViewMock;
            [[searchBarMock shouldNot] receive:@selector(setHidden:) withArguments:theValue(YES)];
            [controller viewWillAppear:YES]; 
        });
    });
});



describe(@"numberOfSectionsInTableView:", ^{
    
    it(@"should return 1", ^{
        BaseCoacListViewController* controller = [[BaseCoacListViewController alloc] init];        
        STAssertTrue([controller numberOfSectionsInTableView:nil] == 1, @"");        
        [controller release];        
    });

});

describe(@"numberOfRowsInSection:", ^{
    
    __block BaseCoacListViewController* controller;
    
    beforeEach(^{
        controller = [[BaseCoacListViewController alloc] init];
        [controller setValue:[NSNumber numberWithInt:1] forKey:@"firstTimeViewWillAppear"];
        [controller stub:@selector(implementsSearch) andReturn:theValue(NO)];        
    });
    
    afterEach(^{
        [controller release];
    });

    //tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
    it(@"should return 0 if there's no elementsArray", ^{
        controller.elementsArray = nil;
        STAssertTrue([controller tableView:nil numberOfRowsInSection:0] == 0, @"");                
    });
    
    it(@"should return the elementsArray's count if it's not nil", ^{
        id elementsArrayMock = [KWMock nullMockForClass:[NSArray class]];
        [elementsArrayMock stub:@selector(count) andReturn:theValue(5)];
        
        controller.elementsArray = elementsArrayMock;
        STAssertTrue([controller tableView:nil numberOfRowsInSection:0] == 5, @"");                

    });
    
});


describe(@"heightForRowAtIndexPath:", ^{
    
    it(@"should return 60.0", ^{
        BaseCoacListViewController* controller = [[BaseCoacListViewController alloc] init];
        STAssertTrue([controller tableView:nil heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] == 60.0, @"");                        
        [controller release];
    });
    
});



describe(@"didSelectRowAtIndexPath:", ^{
    
    it(@"should set the cell's backgroundView at the given indexPath", ^{
    });

    it(@"should configure the cell", ^{
    });

});

describe(@"setMaskAsTitleView:", ^{
    
    it(@"should set the navigationItem's titleView", ^{
        BaseCoacListViewController* controller = [[BaseCoacListViewController alloc] init];
        UINavigationItem* navItemMock = [KWMock nullMockForClass:[UINavigationItem class]];
        [controller stub:@selector(navigationItem) andReturn:navItemMock];
        
        [[navItemMock shouldNot] receive:@selector(setTitleView:) withArguments:[KWNull null]];
        [[navItemMock should] receive:@selector(setTitleView:)];
        
        [controller setMaskAsTitleView];
        [controller release];
    });    
});




// Search
describe(@"groupNameSearchController", ^{
    
    context(@"the controller implements search", ^{
        __block BaseCoacListViewController* controller;
        
        beforeEach(^{
            controller = [[BaseCoacListViewController alloc] init];
            [controller stub:@selector(implementsSearch) andReturn:theValue(YES)];
        });
        
        afterEach(^{
            [controller release];
        });
        
        it(@"should the content of the ivar groupNameSearchController if it's not nil", ^{
            id searchControllerMock = [KWMock nullMockForClass:[GroupNameSearchController class]];
            [controller setValue:searchControllerMock forKey:@"groupNameSearchController"];
            [[[controller groupNameSearchController] should] equal:searchControllerMock];
        });

        it(@"should return a new instance for the ivar groupNameSearchController if it was nil", ^{
            [controller setValue:[NSNull null] forKey:@"groupNameSearchController"];
            [[controller groupNameSearchController] shouldNotBeNil];
        });

    });
    
    context(@"the controller does not implement search", ^{
        it(@"should return nil", ^{
            BaseCoacListViewController* controller = [[BaseCoacListViewController alloc] init];
            [controller stub:@selector(implementsSearch) andReturn:theValue(NO)];
            [[controller groupNameSearchController] shouldBeNil];
            [controller release];
        });
    });
});




describe(@"textDidChange:", ^{
    
    __block BaseCoacListViewController* controller;
    __block id searchControllerMock;
    beforeEach(^{
        controller = [[BaseCoacListViewController alloc] init];
        searchControllerMock = [KWMock nullMockForClass:[GroupNameSearchController class]];
        [controller stub:@selector(groupNameSearchController) andReturn:searchControllerMock];
        id elementsArrayMock = [KWMock nullMockForClass:[NSArray class]];
        controller.elementsArray = elementsArrayMock;
    });
    
    afterEach(^{
        [controller release];
    });

    it(@"should send the message groupNameSearchController to self", ^{
        [[controller should] receive:@selector(groupNameSearchController)];
        [controller searchBar:nil textDidChange:@"search for this"];
    });
    
    it(@"should send the message setSampleArray with the elements array to the search controller", ^{        
        [[searchControllerMock should] receive:@selector(setSampleArray:) withArguments:controller.elementsArray];
        [controller searchBar:nil textDidChange:@"search for this"];
    });
    
    it(@"should send the message searchResultsForString to the search controller", ^{
        NSString* searchText= @"fetch!, fetch!";
        [[searchControllerMock should] receive:@selector(searchResultsForString:) withArguments:searchText];
        [controller searchBar:nil textDidChange:searchText];
    });
    
});


describe(@"resultsAreReadyInDictionary:", ^{
    
    __block BaseCoacListViewController* controller;
    __block NSDictionary* resultsDictionary;
    __block id groupsArrayMock;
    
    beforeEach(^{
        controller = [[BaseCoacListViewController alloc] init];
        groupsArrayMock = [KWMock nullMockForClass:[NSArray class]];
        resultsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:groupsArrayMock, SEARCH_RESULTS_KEY, nil];
    });
    
    afterEach(^{
        [controller release];
    });

    
    it(@"should send the setResults: message on the searchResultsTableViewController with the results from the passed dictionary", ^{
        
        id searchResultsTableViewControllerMock = [KWMock nullMockForClass:[SearchResultsTableViewController class]];        
        controller.searchResultsTableViewController = searchResultsTableViewControllerMock;

        [[searchResultsTableViewControllerMock should] receive:@selector(setResults:) withArguments:groupsArrayMock];
        [controller resultsAreReadyInDictionary:resultsDictionary];
    });

    
    it(@"should send the reloadData message on the searchDisplayController's results tableView", ^{
        id searchDisplayControllerMock = [KWMock nullMockForClass:[UISearchDisplayController class]];
        id resultsTableViewMock = [KWMock nullMockForClass:[UITableView class]];
        [searchDisplayControllerMock stub:@selector(searchResultsTableView) andReturn:resultsTableViewMock];
        [controller stub:@selector(searchDisplayController) andReturn:searchDisplayControllerMock];
        
        [[resultsTableViewMock should] receive:@selector(reloadData)];
        [controller resultsAreReadyInDictionary:resultsDictionary];
    });

});

describe(@"selectedElement:", ^{
    
    
    __block BaseCoacListViewController* controller;
    
    beforeEach(^{        
        controller = [[BaseCoacListViewController alloc] init];
        [controller stub:@selector(tableView:didSelectRowAtIndexPath:)];
        id tableViewMock = [KWMock nullMockForClass:[UITableView class]];            
        
        controller.tableView = tableViewMock;        
        
    });
    
    afterEach(^{
        [controller release];
    });
    it(@"should call didSelectRowAtIndex path if index == 0", ^{
        id groupMock = [KWMock nullMockForClass:[Agrupacion class]];
        id elementsArrayMock = [KWMock nullMockForClass:[NSArray class]];
        controller.elementsArray = elementsArrayMock;
        
        [elementsArrayMock stub:@selector(indexOfObject:) andReturn:theValue(0)]; // I would like to specify the groupMock as the parameter, but that makes the stub return always 0
        [[controller should] receive:@selector(tableView:didSelectRowAtIndexPath:)];
        [controller selectedElement:groupMock];
    });

    it(@"should call didSelectRowAtIndex path if index > 0", ^{
        id groupMock = [KWMock nullMockForClass:[Agrupacion class]];
        id elementsArrayMock = [KWMock nullMockForClass:[NSArray class]];
        controller.elementsArray = elementsArrayMock;

        [elementsArrayMock stub:@selector(indexOfObject:) andReturn:theValue(1)];// I would like to specify the groupMock as the parameter, but that makes the stub return always 0
        [[controller should] receive:@selector(tableView:didSelectRowAtIndexPath:)];
        [controller selectedElement:groupMock];
        
    });

    it(@"should not call didSelectRowAtIndex path if index <0", ^{
        id groupMock = [KWMock nullMockForClass:[Agrupacion class]];
        id elementsArrayMock = [KWMock nullMockForClass:[NSArray class]];
        controller.elementsArray = elementsArrayMock;

        [elementsArrayMock stub:@selector(indexOfObject:) andReturn:theValue(-1)];// I would like to specify the groupMock as the parameter, but that makes the stub return always 0
        [[controller shouldNot] receive:@selector(tableView:didSelectRowAtIndexPath:)];
        [controller selectedElement:groupMock];
    });

});



SPEC_END
