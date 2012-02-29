#import "UIApplication+PRPNetworkActivity.h"

static NSUInteger prp_networkActivityCount = 0;

@implementation UIApplication (PRPNetworkActivity)


- (NSUInteger)prp_networkActivityCount
{
    return prp_networkActivityCount;
}


- (void)prp_refreshNetworkActivityIndicator
{
    BOOL active = (prp_networkActivityCount > 0);
    self.networkActivityIndicatorVisible = active;
}


- (void)prp_pushNetworkActivity
{
    prp_networkActivityCount++;
    [self prp_refreshNetworkActivityIndicator];
}


- (void)prp_popNetworkActivity
{
    if (prp_networkActivityCount > 0)
    {
        prp_networkActivityCount--;
        [self prp_refreshNetworkActivityIndicator];
    }
    else
    {
        DebugLog(@"-[%@ %@] Unbalanced network activity: activity count already 0.", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    }
}


- (void)prp_resetNetworkActivity 
{
    prp_networkActivityCount = 0;
    [self prp_refreshNetworkActivityIndicator];
}

@end