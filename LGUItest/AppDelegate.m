//
//  AppDelegate.m
//  LGUItest
//
//  Created by Soosky on 24/05/2021.
//
@import Firebase;
@import GoogleMobileAds;
#import "AppDelegate.h"
#import "Navigation.h"
#import "IntroViewViewController.h"
#import "SubAViewController.h"

const struct ConstantsStruct Constants = {
    .App_Specific_Shared_Secret = @"ded286d0829243f1b5be9c38c0464e04",
    .BANNER_ID = @"ca-app-pub-3940256099942544/2934735716",
    .FULL_ID = @"ca-app-pub-3940256099942544/4411468910",
    .VIDEO_FULL_ID = @"ca-app-pub-3940256099942544/8691691433",
    .VIDEO_ID = @"ca-app-pub-3940256099942544/5224354917",
    .NATIVE_ID = @"ca-app-pub-3940256099942544/2247696110",
    .OPEN_ID = @"ca-app-pub-3940256099942544/3419835294",
    .APP_ID = @"ca-app-pub-3940256099942544~1458002511"
};
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [FIRApp configure];
    [[GADMobileAds sharedInstance] startWithCompletionHandler:nil];
    _CreatedNavigation =NO;
    _connectAbleDevices = [NSMutableArray new];
    return YES;
}
-(void)showNavigation
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Navigation* controller = [storyboard instantiateViewControllerWithIdentifier:@"CustomNavigation"];
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
}
-(void)showSubHu
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    IntroViewViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"IntroViewController"];
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
}
-(void)showSubNgoan
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SubAViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"SubA"];
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
}
/*
 CustomNavigation
 IntroViewController
 SubA
 SubB
*/

@end
