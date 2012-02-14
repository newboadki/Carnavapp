#import "Kiwi.h"
#import "Constants.h"
#import "BaseCoacListViewController.h"

SPEC_BEGIN(BaseCoacListViewControllerSpec)

describe(@"initWithCoder:", ^{
    
    
    it(@"should subscribe as an observer of MODEL_DATA_IS_READY_NOTIFICATION", ^{
        id notificationCenterMock = [KWMock nullMockForClass:[NSNotificationCenter class]];
        [NSNotificationCenter stub:@selector(defaultCenter) andReturn:notificationCenterMock];                

        //[[notificationCenterMock should] receive:@selector(addObserver:selector:name:object:)];

        BaseCoacListViewController* controller = [[BaseCoacListViewController alloc] initWithCoder:nil];

        [controller release];
    });

    it(@"should subscribe as an observer of NO_NETWORK_NOTIFICATION", ^{
       /* id notificationCenterMock = [KWMock nullMockForClass:[NSNotificationCenter class]];
        [NSNotificationCenter stub:@selector(defaultCenter) andReturn:notificationCenterMock];                
        
        //        [[notificationCenterMock should] receive:@selector(addObserver:selector:name:object:) withArguments:controller, theValue(@selector(handleDataIsReady:)), NO_NETWORK_NOTIFICATION, [NSNull null]];
        
        controller = [[BaseCoacListViewController alloc] init];
        
        [controller release];*/
    });
    
});

describe(@"dealloc", ^{
    
    it(@"should unsubscribe as an observer of MODEL_DATA_IS_READY_NOTIFICATION", ^{
    });
    
    it(@"should unsubscribe as an observer of NO_NETWORK_NOTIFICATION", ^{
    });
    
});

describe(@"handleDataIsReady:", ^{
    
    it(@"should set the model data Property from the notification's userInfo dictionary", ^{
    });
    
    it(@"should send the updateArrayOfElements message", ^{
    });
    
    it(@"should set the model data property on the searchResultsTableViewController", ^{
    });
    
});

describe(@"viewWillAppear:", ^{
    /*
     - (void)viewWillAppear:(BOOL)animated
     {
         [super viewWillAppear:animated];
         
         // Do geometry related customization here, rather than in view did load. Navigation bars and other elements resizing have already happened by now, but not before
         if (![self implementsSearch])
         {            
         [self setSearchResultsTableViewController:nil];
         [[self tableView] setContentOffset:CGPointMake(0, self.searchDisplayController.searchBar.frame.size.height)];
         [[self tableView] setContentInset:UIEdgeInsetsMake(-self.searchDisplayController.searchBar.frame.size.height, 0, 0, 0)];
         float newHeight = self.tableView.contentSize.height - self.searchDisplayController.searchBar.frame.size.height;
         [[self tableView] setContentSize:CGSizeMake(self.tableView.contentSize.width, newHeight)];
         self.searchDisplayController.searchBar.hidden = YES;
     }
     
     }
*/
    it(@"should set the searchResultsTableViewController to nil if self doesn't implement search", ^{
        BaseCoacListViewController* controller = [[BaseCoacListViewController alloc] init];
        [controller stub:@selector(implementsSearch) andReturn:theValue(NO)];
        
        [[controller should] receive:@selector(setSearchResultsTableViewController:) withArguments:nil];
        [controller viewWillAppear:YES];
        [controller release];
    });

    it(@"should not set the searchResultsTableViewController to nil if self implements search", ^{
        BaseCoacListViewController* controller = [[BaseCoacListViewController alloc] init];
        [controller stub:@selector(implementsSearch) andReturn:theValue(YES)];
        
        [[controller shouldNot] receive:@selector(setSearchResultsTableViewController:) withArguments:nil];
        [controller viewWillAppear:YES];
        [controller release];
    });

    
    it(@"should set the tableView's contentOffset to hide the seach bar if self doesn't implement search", ^{
    });

    it(@"should not set the tableView's contentOffset to hide the seach bar if self implements search", ^{
    });

    
    it(@"should hide the searchBar if self doesn't implement search", ^{
    });
    
    it(@"should not hide the searchBar if self implements search", ^{
    });

});


describe(@"numberOfSectionsInTableView:", ^{
    
    it(@"should return 1", ^{
    });

});

describe(@"numberOfRowsInSection:", ^{
    
    it(@"should return 0 if there's no elementsArray", ^{
    });
    
    it(@"should return the elementsArray's count if it's not nil", ^{
    });
    
});


describe(@"heightForRowAtIndexPath:", ^{
    
    it(@"should return 60.0", ^{
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
    });
    
});


// Search
describe(@"groupNameSearchController:", ^{
    
    it(@"should set the navigationItem's titleView", ^{
    });
    
});

describe(@"textDidChange:", ^{
    
    it(@"should set the navigationItem's titleView", ^{
    });
    
});

describe(@"resultsAreReadyInDictionary:", ^{
    
    it(@"should set the navigationItem's titleView", ^{
    });
    
});

describe(@"selectedElement:", ^{
    
    it(@"should call didSelectRowAtIndex path if index >=0", ^{
    });

    it(@"should not call didSelectRowAtIndex path if index <0", ^{
    });

});



SPEC_END
