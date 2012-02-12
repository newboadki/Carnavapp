#import "Kiwi.h"
#import "Constants.h"

SPEC_BEGIN(BaseCoacListViewControllerSpec)

describe(@"initWithCoder:", ^{
    
    it(@"should subscribe as an observer of MODEL_DATA_IS_READY_NOTIFICATION", ^{
    });

    it(@"should subscribe as an observer of NO_NETWORK_NOTIFICATION", ^{
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


SPEC_END
