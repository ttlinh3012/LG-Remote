//
//  TabbarController.m
//  LGUItest
//
//  Created by Soosky on 24/05/2021.
//

#import "TabbarController.h"
#import "ChanelsVCViewController.h"
#import "TabbarSubView.h"
#import "ViewController.h"
#import "AirPlayService.h"
#import "DIALService.h"
#import "WebOSTVService.h"
#import "DetectTVViewController.h"
#import "SubAViewController.h"
#import "BaseSubVViewController.h"
#import "AppDelegate.h"
@import GoogleMobileAds;

static int countAds = 0;
//static NSString * const InterstitialAdsID = @"ca-app-pub-3940256099942544/4411468910";
@interface TabbarController ()<GADFullScreenContentDelegate>

@end

@implementation TabbarController  {
    GADRequest *request;
    
//    DevicePicker *_devicePicker;
    ConnectableDevice *_device;
    DetectTVViewController *detectTv;
    UIBarButtonItem *_connectToggleItem;
    UILabel *_disabledMessage;
    UIAlertView *_connectAlert;
    NSUserDefaults *defaults;
    NSString *user;
    BOOL checkExpired;
    BOOL a;
}
//@synthesize _discoveryManager;

//+ (TabbarController *)sharedInstance
//{
//    static TabbarController *sharedInstance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sharedInstance = [[TabbarController alloc] init];
//
//    });
//    return sharedInstance;
//}
//- (id)init {
//  if (self = [super init]) {
//      _discoveryManager = [DiscoveryManager sharedManager];
//      _discoveryManager.pairingLevel = DeviceServicePairingLevelOn;
//  }
//  return self;
//}
- (void)dealloc {
  // Should never be called, but just here for clarity really.
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Disconnect";
    _discoveryManager = [DiscoveryManager sharedManager];
    _discoveryManager.pairingLevel = DeviceServicePairingLevelOn;
 //    self.title = self->_device.friendlyName ? self->_device.friendlyName : @"Disconnect";
    request = [GADRequest request];
      [GADInterstitialAd loadWithAdUnitID:Constants.FULL_ID
                                  request:request
                        completionHandler:^(GADInterstitialAd *ad, NSError *error) {
        if (error) {
          NSLog(@"Failed to load interstitial ad with error: %@", [error localizedDescription]);
          return;
        }
        self.interstitialtabbar = ad;
        self.interstitialtabbar.fullScreenContentDelegate = self;
      }];
    
    
    defaults = [NSUserDefaults standardUserDefaults];
    user = [defaults valueForKey:@"user"];
//    [self checkSub];
    a = NO;
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//   [TabbarController sharedInstance];
//    user = [defaults valueForKey:@"user"];
}
//-(void)checkSub{
//    user = [[NSUserDefaults standardUserDefaults] valueForKey:@"user"];
//    if(![user isEqual:@"paid"])
//    {
//        if([user isEqual:@"subNgoan"])
//        {
//            [self showSubA];
//            [defaults setValue:@"subHu" forKey:@"user"];
//        }
//        else
//        {
//
//            if ([user isEqual:@"subHu"])
//            {
//
//                [self showSubB];
//            }
//            else
//            {
//
//            }
//        }
//    }
//
//}
-(void)showSubA{
//    dispatch_async(dispatch_get_main_queue(), ^{
//    [(AppDelegate *)[[UIApplication sharedApplication] delegate] showSubNgoan];
//    });
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.CreatedNavigation =YES;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SubAViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"SubA"];
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [self.navigationController pushViewController:controller animated:YES];
    
}
//-(void)showSubB{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    SubAViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"IntroViewController"];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    [self.navigationController pushViewController:controller animated:YES];
//}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (a == NO) {
        [self setupView];
    }
}

#pragma mark Ads-----------------------------------
- (void) counterShowAds :(int) num1 secondNumber:(int) num2 {
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] isEqual:@"paid"]||[[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] isEqual:@"sub_purchased"])
    {
        
    }
    else
    {
        countAds++;
        if (countAds<num1)
        {
            
        }
        else if(countAds==num1)
        {
            [self showAds];
        }
        else
        {
            if(((countAds-num1)%num2==0))
            {
                [self showAds];
            }
        }
    }
}
-(void)showAds{
    
    if (self.interstitialtabbar) {
        [self.interstitialtabbar presentFromRootViewController:self];
      } else {
        NSLog(@"Ad wasn't ready");
      }
    [self creatAds];
}
-(void)creatAds
{
    [GADInterstitialAd loadWithAdUnitID:Constants.FULL_ID
                                request:request
                      completionHandler:^(GADInterstitialAd *ad, NSError *error) {
      if (error) {
        NSLog(@"Failed to load interstitial ad with error: %@", [error localizedDescription]);
        return;
      }
      self.interstitialtabbar = ad;
      self.interstitialtabbar.fullScreenContentDelegate = self;
    }];
}


- (void)setupView {
    a= YES;
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"tabbarsubview" owner:self options:nil];
    TabbarSubView *tabbarView = [subviewArray objectAtIndex:0];

    CGFloat heightImage = 111.00;
    CGFloat heihtscreen = 812;
//
    CGFloat height = self.view.frame.size.height *  heightImage / heihtscreen;
    tabbarView.frame = CGRectMake(0,self.tabBar.frame.size.height-height, self.tabBar.frame.size.width, height);
    [self.tabBar addSubview:tabbarView];
    tabbarView.screenDelegate = self ;
}


-(void) setScreen1 {
    [self setSelectedIndex:0];
    [self counterShowAds:5 secondNumber:5];
}
-(void) setScreen2 {
    [self setSelectedIndex:1];
    [self counterShowAds:5 secondNumber:5];
}

-(void) setScreen3 {
    [self setSelectedIndex:2];
    [self counterShowAds:5 secondNumber:5];
}

#pragma mark - Actions======================================================

- (IBAction)castTv:(id)sender {
    [self hConnect];
}

- (void) hConnect
{
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.hidesBottomBarWhenPushed = YES;
        detectTv=[storyboard instantiateViewControllerWithIdentifier:@"DetectTVViewController"];
        [self presentViewController:detectTv animated:YES completion:nil];
        detectTv.sendDelegate = self;
   
}

-(void)Currentdevice:(ConnectableDevice *)device{
    
    _device = device;
    _device.delegate =self;
    [_device setPairingType:DeviceServicePairingTypePinCode];
    [_device connect];
}


#pragma mark - ConnectableDeviceDelegate =============================================

- (void) connectableDeviceReady:(ConnectableDevice *)device
{
    // TODO: this should be unnecessary
    dispatch_async(dispatch_get_main_queue(), ^
    {
        NSLog(@"device ready");
        self.title = self->_device.friendlyName ? self->_device.friendlyName : @"Disconnect";
        ViewController *remoteViewController = (ViewController*)  [self.viewControllers objectAtIndex:0];
        remoteViewController.device = self->_device;


        ChanelsVCViewController *chanelsViewController = (ChanelsVCViewController*) [self.viewControllers objectAtIndex:1];
        chanelsViewController.device = self->_device;

        NSLog(@"xxxxx %@",self->_device);
        NSLog(@"xxxx %@",remoteViewController);
        NSLog(@"sssss %@",remoteViewController.device);
        if ([self->_device hasCapability:kMouseControlConnect])
        {
            [self->_device.mouseControl connectMouseWithSuccess:^(id responseObject)
            {
                NSLog(@"mouse connection success");

                remoteViewController.touchpad.mouseControl = self->_device.mouseControl;
                remoteViewController.touchpad.userInteractionEnabled = YES;
            } failure:^(NSError *error)
            {
                NSLog(@"mouse connection error %@", error.localizedDescription);
            }];
        }
        NSLog(@"bbbbbb %@",self->_device.mouseControl);
        NSLog(@"aaaaa %@",remoteViewController.touchpad.mouseControl);
        NSString *nameDeviceReady = [NSString stringWithFormat:@"Connect to %@",self->_device.friendlyName];
        [self ShowAlertConnected:nameDeviceReady];
    });
//    dispatch_async(dispatch_get_main_queue(), ^(void){
//        //Run UI Updates
//
//            [self.navigationController dismissViewControllerAnimated:NO completion:nil];
//        });
//    [self cancelDetectTVScreen];

//
//
////    [self showSubA];
}

- (void) connectableDevice:(ConnectableDevice *)device service:(DeviceService *)service pairingRequiredOfType:(int)pairingType withData:(id)pairingData
{
    NSLog(@"device pairing");
 
//    self.title = self->_device.friendlyName ? self->_device.friendlyName : @"Disconnect";
//    dispatch_async(dispatch_get_main_queue(), ^
//    {
////        NSLog(@"device ready");
////        self.title = self->_device.friendlyName ? self->_device.friendlyName : @"Disconnect";
//        ViewController *remoteViewController = (ViewController*)  [self.viewControllers objectAtIndex:0];
//        remoteViewController.device = self->_device;
//
//
//        ChanelsVCViewController *chanelsViewController = (ChanelsVCViewController*) [self.viewControllers objectAtIndex:1];
//        chanelsViewController.device = self->_device;
//
//        NSLog(@"xxxxx %@",self->_device);
//        NSLog(@"xxxx %@",remoteViewController);
//        NSLog(@"sssss %@",remoteViewController.device);
//        if ([self->_device hasCapability:kMouseControlConnect])
//        {
//            [self->_device.mouseControl connectMouseWithSuccess:^(id responseObject)
//            {
//                NSLog(@"mouse connection success");
//
//                remoteViewController.touchpad.mouseControl = self->_device.mouseControl;
//                remoteViewController.touchpad.userInteractionEnabled = YES;
//            } failure:^(NSError *error)
//            {
//                NSLog(@"mouse connection error %@", error.localizedDescription);
//            }];
//        }
//    });
//    _device.delegate = nil;
//    _device = nil;
    self.title = @"Pairing";

}

-(void)connectableDevicePairingSuccess:(ConnectableDevice *)device service:(DeviceService *)service{
    dispatch_async(dispatch_get_main_queue(), ^{
    self.title = self->_device.friendlyName ? self->_device.friendlyName : @"Disconnect";
    ViewController *remoteViewController = (ViewController*)  [self.viewControllers objectAtIndex:0];
    remoteViewController.device = self->_device;


    ChanelsVCViewController *chanelsViewController = (ChanelsVCViewController*) [self.viewControllers objectAtIndex:1];
    chanelsViewController.device = self->_device;
        NSString *nameDeviceReady = [NSString stringWithFormat:@"Connect to %@",self->_device.friendlyName];
        [self ShowAlertConnected:nameDeviceReady];
    });
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] isEqual:@"subHu"]||[[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] isEqual:@"subNgoan"])
    {
        [self showSubA];
    }

}


- (void) connectableDeviceDisconnected:(ConnectableDevice *)device withError:(NSError *)error
{
    _device.delegate = nil;
    _device = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
    ViewController *remoteViewController = (ViewController*)  [self.viewControllers objectAtIndex:0];
    remoteViewController.device = self->_device;
    
    
    ChanelsVCViewController *chanelsViewController = (ChanelsVCViewController*) [self.viewControllers objectAtIndex:1];
    chanelsViewController.device = self->_device;
    });
    [self ShowAlertDisconnected];
    self.title = @"Disconnect";

}

- (void) connectableDevice:(ConnectableDevice *)device connectionFailedWithError:(NSError *)error{
    [_device disconnect];
}
#pragma mark UIAlert method =============================================

-(void)ShowAlertConnected:(NSString*)string{
    _connectAlert = [[UIAlertView alloc] initWithTitle:@"Connected"
                                                    message:string
                                                   delegate:self
                                          cancelButtonTitle:@"Continue"
                                          otherButtonTitles:nil];
   
    dispatch_on_main(^{ [self->_connectAlert show]; });
//    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)ShowAlertDisconnected{
    _connectAlert = [[UIAlertView alloc] initWithTitle:@"Failed"
                                                    message:@"Disconnect to TV"
                                                   delegate:self
                                          cancelButtonTitle:@"Continue"
                                          otherButtonTitles:nil];
   
    dispatch_on_main(^{ [self->_connectAlert show]; });
}

-(void)cancelDetectTVScreen
{
//    DetectTVViewController *detect = [[DetectTVViewController alloc]init];
//    [[NSNotificationCenter defaultCenter]
//         addObserver:self
//         selector:@selector(didDismissSecondViewController)
//         name:@"SecondViewControllerDismissed"
//         object:nil];
}
@end
