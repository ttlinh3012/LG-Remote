//
//  TabbarController.h
//  LGUItest
//
//  Created by Soosky on 24/05/2021.
//

#import <UIKit/UIKit.h>
#import "TabbarSubView.h"
#import "ConnectSDK.h"
#import "ControlTouchpadView.h"
#import "DetectTVViewController.h"
@import GoogleMobileAds;

@interface TabbarController : UITabBarController<SetScreenDelegate, UITabBarControllerDelegate, UINavigationControllerDelegate, Sendcurrentdevice,DiscoveryManagerDelegate,ConnectableDeviceDelegate>{
    DiscoveryManager *_discoveryManager;
    
}
//@property NSString* abc;
@property (nonatomic, retain) DiscoveryManager *_discoveryManager;
@property(nonatomic, strong) GADInterstitialAd *interstitialtabbar;

//+ (TabbarController *)sharedInstance;
@end
