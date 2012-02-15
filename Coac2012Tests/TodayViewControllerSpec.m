
#import "Kiwi.h"
#import "Constants.h"

SPEC_BEGIN(TodayViewControllerViewControllerSpec)

describe(@"updateArrayOfElements:", ^{
        
    it(@"should set the elementsArray with the groups for the current date", ^{
    });
    
    it(@"should realod the tableView's data", ^{
    });

    it(@"should send the showAlertIfNoConstestToday message", ^{
    });

});

describe(@"configureCell", ^{
    
    it(@"should set the groupNameLabel's text with the group's name if id != -1", ^{
    });
    
    it(@"should set the categoryNameLabel's text with the group's name if id != -1", ^{
    });

    it(@"should set the groupNameLabel's text with '-- DESCANSO --' if id == -1", ^{
    });
    
    it(@"should set the categoryNameLabel's text with '' if id == -1", ^{
    });

});


describe(@"todaysDateString:", ^{
    
    it(@"should return today's date in a string with the format 'dd/MM/yyyy'", ^{
    });
    
});


describe(@"viewDidLoad:", ^{
    
    it(@"should send the message showAlertIfNoConstestToday to self", ^{
    });

    it(@"should send the message setMaskAsTitleView to self", ^{
    });

});

describe(@"titleForHeaderInSection:", ^{
    
    it(@"should send the message todaysDateString to self", ^{
    });
    
    
});


describe(@"didSelectRowAtIndexPath:", ^{
    
    it(@"should push a controller in the navigation stack", ^{
    });
    
});


SPEC_END
