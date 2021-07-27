//
//  ViewController.h
//  LGUItest
//
//  Created by Soosky on 24/05/2021.
//

#import <UIKit/UIKit.h>
#import "ConnectSDK.h"
@import GoogleMobileAds;
#import "ControlTouchpadView.h"
#import "numboardsubView.h"
#import "DetectTVViewController.h"

@interface ViewController : UIViewController<CallChanelDelegate,UITextFieldDelegate,UITabBarControllerDelegate>

@property(nonatomic, strong) GADInterstitialAd *interstitial;


@property (nonatomic, assign) ConnectableDevice *device;
@property (nonatomic, assign) NSUserDefaults *defaluts;
@property (weak, nonatomic) IBOutlet UIView *View2;
@property (weak, nonatomic) IBOutlet UIView *View1;
@property (weak, nonatomic) IBOutlet UIButton *changemousecontrolimage;
@property (weak, nonatomic) IBOutlet UIView *View3;

//@property (weak, nonatomic) IBOutlet UIButton *keyboardButton;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
//@property (weak, nonatomic) IBOutlet UITextField *numboardfield;
@property (weak, nonatomic) IBOutlet ControlTouchpadView *touchpad;
//-(IBAction)toggleKeyboard:(id)sender;
-(IBAction)keyboardEnterText:(id)sender;
//-(IBAction)numberboardEnterText:(id)sender;

- (IBAction)InputButton:(id)sender;
- (IBAction)HomeButton:(id)sender;
- (IBAction)MenuButton:(id)sender;
- (IBAction)PoweroffButton:(id)sender;
- (IBAction)OkButton:(id)sender;
- (IBAction)UpButton:(id)sender;
- (IBAction)LeftButton:(id)sender;
- (IBAction)DownButton:(id)sender;
- (IBAction)RightButton:(id)sender;
- (IBAction)KeyboardButton:(id)sender;
- (IBAction)numboardButton:(id)sender;
- (IBAction)ChanelUp:(id)sender;
- (IBAction)ChanelDown:(id)sender;
- (IBAction)MuteButton:(id)sender;
- (IBAction)ExitButton:(id)sender;
- (IBAction)BackButton:(id)sender;
- (IBAction)VolumeUpButton:(id)sender;
- (IBAction)VolumeDownButton:(id)sender;
- (IBAction)InforButton:(id)sender;
- (IBAction)RewindButton:(id)sender;
- (IBAction)PlayStopButton:(id)sender;
- (IBAction)FastforwardButton:(id)sender;
- (IBAction)PauseButton:(id)sender;

@end

