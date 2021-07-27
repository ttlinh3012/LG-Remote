//
//  ViewController.m
//  LGUItest
//
//  Created by Soosky on 24/05/2021.
//

#import "ViewController.h"
#import "TabbarSubView.h"
#import "AirPlayService.h"
#import "DIALService.h"
#import "WebOSTVService.h"
#import "numboardsubView.h"
#import "TabbarController.h"
#import "DetectTVViewController.h"
#import "SubAViewController.h"
#import "AppDelegate.h"
@import GoogleMobileAds;

//static NSString * const AppId = @"1552327401";
//static NSString * const InterstitialAdsID = @"ca-app-pub-3940256099942544/4411468910";
int count = 0;
int countAds =0;
@interface ViewController ()<GADFullScreenContentDelegate> {
    numboardsubView *myView;
    NSString *user;
}


@end

@implementation ViewController{
    GADRequest *request;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.View1.hidden = NO;
    self.View2.hidden =YES;
    NSLog(@"ddd %@",user);
    user = [[NSUserDefaults standardUserDefaults]stringForKey:@"user"];
    request = [GADRequest request];
      [GADInterstitialAd loadWithAdUnitID:Constants.FULL_ID
                                  request:request
                        completionHandler:^(GADInterstitialAd *ad, NSError *error) {
        if (error) {
          NSLog(@"Failed to load interstitial ad with error: %@", [error localizedDescription]);
          return;
        }
        self.interstitial = ad;
        self.interstitial.fullScreenContentDelegate = self;
      }];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    user = [[NSUserDefaults standardUserDefaults]stringForKey:@"user"];
    NSLog(@"fffff %@",user);
}
-(void)ShowDetectView{
    TabbarController *tabBar = (TabbarController*)self.tabBarController;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetectTVViewController *detect =[storyboard instantiateViewControllerWithIdentifier:@"DetectTVViewController"];
    self.hidesBottomBarWhenPushed = YES;
    [self presentViewController:detect animated:YES completion:nil];
    detect.sendDelegate = tabBar;
    
}
-(void)showAds{
    if (self.interstitial) {
        [self.interstitial presentFromRootViewController:self];
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
      self.interstitial = ad;
      self.interstitial.fullScreenContentDelegate = self;
    }];
}

-(void)showSubA
{
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

- (void) counter :(int) num1 secondNumber:(int) num2 {
    count++;
    if (count<num1)
    {
        
    }
    else if(count==num1)
    {
        [self RateApp:Constants.APP_ID];
    }
    else
    {
        if(((count-num1)%num2==0))
        {
            [self RateApp:Constants.APP_ID];
        }
    }
}
- (void) counterShowAds :(int) num1 secondNumber:(int) num2 {
    if([user isEqual:@"paid"]||[user isEqual:@"sub_purchased"])
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

-(void)RateApp:(NSString*)AppID
{
    if (@available(iOS 10.3, *)) {
            [SKStoreReviewController requestReview];
        }
    else
    {
        NSString *bodyurl = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@?mt=8&action=write-review",AppID];
        NSLog(@"1234 %@",bodyurl);
    //    NSLog(@"vvvv %@",body);
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *URL = [NSURL URLWithString:bodyurl];
        [application openURL:URL options:@{} completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"Rate App");
            }
        }];
    }
}

- (IBAction)changemuosecontrol:(id)sender {
    NSLog(@"%@",user);
    [sender setSelected: ![sender isSelected]];
    if ([sender isSelected]) {
        [self.changemousecontrolimage setBackgroundImage:[UIImage imageNamed:@"home_btndirect1touchpad0"] forState:UIControlStateHighlighted];
        self.View1.hidden = YES;
        self.View2.hidden =NO;
//        if ([_device hasCapability:kMouseControlConnect])
//            
//        {
            [_device.mouseControl connectMouseWithSuccess:^(id responseObject)
            {
                NSLog(@"mouse connection success");

                self->_touchpad.mouseControl = self->_device.mouseControl;
                self->_touchpad.userInteractionEnabled = YES;
            } failure:^(NSError *error)
            {
                NSLog(@"mouse connection error %@", error.localizedDescription);
            }];
//        }
        NSLog(@"bbbbbb %@",_device.mouseControl);
        NSLog(@"aaaaa %@",_touchpad.mouseControl);
    }
    else{
        [self.changemousecontrolimage setBackgroundImage:[UIImage imageNamed:@"home_btndirect0touchpad1"] forState:UIControlStateHighlighted];
        self.View1.hidden = NO;
        self.View2.hidden =YES;
//        [_device.mouseControl disconnectMouse];
    }
    [self counter:5 secondNumber:30];
    [self counterShowAds:10 secondNumber:20];
}

- (IBAction)PauseButton:(id)sender {
    if(_device){
//    [_device.mouseControl clickWithSuccess:nil failure:nil];
        [_device.mediaControl pauseWithSuccess:^(id responseObject)
            {
                NSLog(@"xxx pause success");
            } failure:^(NSError *error)
                {
                    NSLog(@"xxx pause failure: %@", error.localizedDescription);
                }];
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
    }
    else{
        [self ShowDetectView];
    }
    
}

- (IBAction)FastforwardButton:(id)sender {
    if(_device){
        [_device.mediaControl fastForwardWithSuccess:^(id responseObject)
        {
            NSLog(@"xxx fast forward success");
        } failure:^(NSError *error)
        {
            NSLog(@"xxx fast forward failure: %@", error.localizedDescription);
        }];
        [_device.keyControl rightWithSuccess:nil failure:nil];
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
    }
    else{
        [self ShowDetectView];
    }

}

- (IBAction)PlayStopButton:(id)sender {
    if(_device){
        [_device.mouseControl clickWithSuccess:nil failure:nil];
        [_device.mediaControl playWithSuccess:nil failure:nil];
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
    }
    else{
        [self ShowDetectView];
    }
}

- (IBAction)RewindButton:(id)sender {
    if(_device)
    {
        [_device.mediaControl rewindWithSuccess:^(id responseObject)
            {
                NSLog(@"rewind success");
            } failure:^(NSError *error)
            {
                NSLog(@"rewind failure: %@", error.localizedDescription);
            }];
        [_device.keyControl leftWithSuccess:nil failure:nil];
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
    }
    else{
        [self ShowDetectView];
    }
}

- (IBAction)InforButton:(id)sender {
    if(_device){
        [_device.keyControl infoWithSuccess:nil failure:nil];
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
    }
    else{
        [self ShowDetectView];
    }
}

- (IBAction)VolumeDownButton:(id)sender {
    if(_device){
        if([user isEqual:@"paid"]||[user isEqual:@"sub_purchased"])
        {
            [_device.volumeControl volumeDownWithSuccess:^(id responseObject)
             {
                 NSLog(@"Vol Down Success");
             } failure:^(NSError *err)
             {
                 NSLog(@"Vol Up Error %@", err.description);
             }];
        }
        else
        {
            [self showSubA];
        }
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
    }
    else{
        [self ShowDetectView];
    }
}

- (IBAction)VolumeUpButton:(id)sender {
    if(_device){
        if([user isEqual:@"paid"]||[user isEqual:@"sub_purchased"])
        {
            [_device.volumeControl volumeUpWithSuccess:^(id responseObject)
             {
                 NSLog(@"Vol Down Success");
             } failure:^(NSError *err)
             {
                 NSLog(@"Vol Up Error %@", err.description);
             }];
        }
        else
        {
            [self showSubA];
        }
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
    }
    else{
        [self ShowDetectView];
    }
}

- (IBAction)BackButton:(id)sender {
    if(_device){
        [_device.keyControl backWithSuccess:nil failure:nil];
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
    }
    else{
        [self ShowDetectView];
    }
}

- (IBAction)ExitButton:(id)sender {
    if(_device)
    {
        [_device.keyControl exitWithSuccess:nil failure:nil];
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
    }
    else{
        [self ShowDetectView];
    }
}

- (IBAction)MuteButton:(id)sender {
    if(_device)
    {
        if([user isEqual:@"paid"]||[user isEqual:@"sub_purchased"])
        {
            [sender setSelected: ![sender isSelected]];
            if ([sender isSelected])
            {
                [_device.volumeControl setMute:YES success:^(id responseObject)
                 {
                     NSLog(@"Mute Success");
                     
                 } failure:^(NSError *err)
                 {
                     NSLog(@"Mute Error %@", err.description);
                 }];
                
            }
            else
            {
                [_device.volumeControl setMute:NO success:^(id responseObject)
                 {
                     NSLog(@"UnMute Success");
                     
                 } failure:^(NSError *err)
                 {
                     NSLog(@"Mute Error %@", err.description);
                 }];
                
            }
            [self counter:5 secondNumber:30];
            [self counterShowAds:10 secondNumber:20];
        }
        else
        {
            [self showSubA];
        }
        
    }
    else
    {
        [self ShowDetectView];
    }
        
}

- (IBAction)ChanelDown:(id)sender {
    if(_device)
    {
        [_device.tvControl channelDownWithSuccess:^(id responseObject)
            {
                NSLog(@"Ch Down Success");
            } failure:^(NSError *error)
            {
                NSLog(@"Ch Down Error %@", error.description);
            }];
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
    }
    else{
        [self ShowDetectView];
    }
}


- (IBAction)ChanelUp:(id)sender {
    if(_device)
    {
        [_device.tvControl channelUpWithSuccess:^(id responseObject)
            {
                NSLog(@"Ch Up Success");
            } failure:^(NSError *error)
            {
                NSLog(@"Ch Up Error %@", error.description);
            }];
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
    }
    else
    {
        [self ShowDetectView];
    }
}

- (IBAction)numboardButton:(id)sender {
    if(_device)
    {
        if([user isEqual:@"paid"]||[user isEqual:@"sub_purchased"])
        {
            if (myView == NULL) {
                myView = [[[NSBundle mainBundle] loadNibNamed:@"numboardsubView" owner:nil options:nil] firstObject]/* <- Your custom view */;
                UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
                [currentWindow addSubview:myView];
                [myView setHidden: YES];
                myView.frame = CGRectMake(0,self.View3.frame.origin.y ,self.view.frame.size.width,self.view.frame.size.height-self.View3.frame.origin.y);
                myView.delegate = self;
            }
            [sender setSelected: ![sender isSelected]];
            if([sender isSelected]){
                [myView setHidden:NO];
            }
            else
            {
                [myView setHidden:YES];
            }
        }
        else
        {
            [self showSubA];
        }
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
    }
    else{
        [self ShowDetectView];
    }

}

- (IBAction)KeyboardButton:(id)sender {
    if(_device)
    {
        if([user isEqual:@"paid"]||[user isEqual:@"sub_purchased"])
        {
            [sender setSelected: ![sender isSelected]];
            if([sender isSelected]){
                [self getKeyboardFocusWithType:UIKeyboardTypeDefault];
                self.textfield.delegate = self;
              
            }
            else{
                [self resignKeyboardFocus];
                
            }
        }
        else
        {
            [self showSubA];
        }
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
        
    }
    else
    {
        [self ShowDetectView];
    }
}

- (IBAction)RightButton:(id)sender {
    if(_device)
    {
        [_device.keyControl rightWithSuccess:nil failure:nil];
        NSLog(@"Right");
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
    }
    else
    {
        [self ShowDetectView];
    }
    
}

- (IBAction)DownButton:(id)sender {
    if(_device)
    {
        [_device.keyControl downWithSuccess:nil failure:nil];
        NSLog(@"Down");
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
    }
    else
    {
        [self ShowDetectView];
    }
}

- (IBAction)LeftButton:(id)sender {
    if(_device)
    {
        [_device.keyControl leftWithSuccess:nil failure:nil];
        NSLog(@"Left");
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
    }
    else
    {
        [self ShowDetectView];
    }
}

- (IBAction)UpButton:(id)sender {
    if(_device)
    {
        [_device.keyControl upWithSuccess:nil failure:nil];
        NSLog(@"UP");
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
    }
    else
    {
        [self ShowDetectView];
    }
}

- (IBAction)OkButton:(id)sender {
    if(_device)
    {
        [_device.keyControl okWithSuccess:nil failure:nil];
        NSLog(@"OK");
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
    }
    else
    {
        [self ShowDetectView];
    }
}

- (IBAction)PoweroffButton:(id)sender {
    if(_device)
    {
        if([user isEqual:@"paid"]||[user isEqual:@"sub_purchased"])
        {
            [_device.powerControl powerOffWithSuccess:^(id responseObject) {
                NSLog(@"power off success");
            } failure:^(NSError *error) {
                NSLog(@"power off failure: %@", error.localizedDescription);
            }];
        }
        else
        {
            [self showSubA];
        }
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
    }
    else
    {
        [self ShowDetectView];
    }
}

- (IBAction)MenuButton:(id)sender {
    if(_device)
    {
        [_device.keyControl menuWithSuccess:nil failure:nil];
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
    }
    else
    {
        [self ShowDetectView];
    }
}

- (IBAction)HomeButton:(id)sender {
    if(_device)
    {
        [_device.keyControl homeWithSuccess:nil failure:nil];
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
    }
    else{
        [self ShowDetectView];
    }

}

- (IBAction)InputButton:(id)sender {
    if(_device)
    {
        [_device.launcher launchApp:@"com.webos.app.connectionwizard" success:nil failure:nil];
        [self counter:5 secondNumber:30];
        [self counterShowAds:10 secondNumber:20];
    }
    else
    {
        [self ShowDetectView];
    }
}


#pragma mark - Keyboard & UITextField methods

-(void) getKeyboardFocusWithType:(UIKeyboardType)type
{
    [_textfield setKeyboardType:UIKeyboardTypeDefault];
    [_textfield becomeFirstResponder];
}

-(void) resignKeyboardFocus
{
    
    [_textfield resignFirstResponder];
    [_textfield setText:@""];
}


//-(void) textFieldDidBeginEditing:(UITextField *)textField
//{
//    [textField setText:@"*"];
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    if ([_device hasCapability:kTextInputControlSendEnter]){
        [_device.textInputControl sendEnterWithSuccess:nil failure:nil];
        [_textfield setText:@""];
    }
        
    if (![_device hasCapability:kTextInputControlSubscribe]){
        [self resignKeyboardFocus];
    }
       
    NSLog(@"abc.  da an nut return");
    return YES;
}


-(void) keyboardEnterText:(id)sender
{
    NSString *newString = [_textfield text];

    if ([newString length] == 0)
    {
        NSLog(@"Received delete key code");

        if ([self.device hasCapability:kTextInputControlSendDelete])
            [self.device.textInputControl sendDeleteWithSuccess:nil failure:nil];
    } else
    {
        NSString *stringToSend = [newString substringFromIndex:1];

        NSLog(@"Received string to send: %@", stringToSend);

        if ([self.device hasCapability:kTextInputControlSendText])
            [self.device.textInputControl sendText:stringToSend success:nil failure:nil];
    }

    [_textfield setText:@"*"];
}


#pragma mark - numboard Delegate

-(void)num0
{
    [_device.keyControl p0WithSuccess:nil failure:nil];
    NSLog(@"press num0");
}
-(void)num1
{
    [_device.keyControl p1WithSuccess:nil failure:nil];
    NSLog(@"press num1");
}
-(void)num2
{
    [_device.keyControl p2WithSuccess:nil failure:nil];
    NSLog(@"press num2");
}
-(void)num3
{
    [_device.keyControl p3WithSuccess:nil failure:nil];
    NSLog(@"press num3");
}
-(void)num4
{
    [_device.keyControl p4WithSuccess:nil failure:nil];
    NSLog(@"press num4");
}
-(void)num5
{
    [_device.keyControl p5WithSuccess:nil failure:nil];
    NSLog(@"press num5");
}
-(void)num6
{
    [_device.keyControl p6WithSuccess:nil failure:nil];
    NSLog(@"press num6");
}
-(void)num7
{
    [_device.keyControl p7WithSuccess:nil failure:nil];
    NSLog(@"press num7");
}
-(void)num8
{
    [_device.keyControl p8WithSuccess:nil failure:nil];
    NSLog(@"press num8");
}
-(void)num9
{
    [_device.keyControl p9WithSuccess:nil failure:nil];
    NSLog(@"press num9");
}

@end
