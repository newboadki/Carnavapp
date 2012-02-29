#import <UIKit/UIKit.h>


@interface UIApplication(PRPNetworkActivity)

@property (nonatomic, assign, readonly) NSUInteger prp_networkActivityCount;

- (void)prp_pushNetworkActivity;
- (void)prp_popNetworkActivity;
- (void)prp_resetNetworkActivity;

@end