//
//  SubBViewController.m
//  LGUItest
//
//  Created by Soosky on 16/06/2021.
//

#import "SubBViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "AppDelegate.h"

static NSString * const policy = @"https://sites.google.com/view/remotecontroltvpolicy/";
static NSString * const term = @"https://sites.google.com/view/remotecontroltermsofuse/";

@interface SubBViewController ()

@end

@implementation SubBViewController{
    AVPlayerItem *_playerItem;
    AVQueuePlayer *_player;
    AVPlayerLooper *_playerLooper;
    AVPlayerLayer *_playerLayer;
    UIImage *lifetimeImage0;
    UIImage *lifetimeImage1;
    UIImage *weeklyImage0;
    UIImage *weeklyImage1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *videoFile = [[NSBundle mainBundle] pathForResource:@"sub" ofType:@"mp4"];
    NSURL *videoURL = [NSURL fileURLWithPath:videoFile];
    _playerItem = [AVPlayerItem playerItemWithURL:videoURL];
    _player = [AVQueuePlayer queuePlayerWithItems:@[_playerItem]];
    _playerLooper = [AVPlayerLooper playerLooperWithPlayer:_player templateItem:_playerItem];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill ;
    [self.View_Player.layer addSublayer:_playerLayer];
    [_player play];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    lifetimeImage0 = [UIImage imageNamed: @"subB_btnlifetime0.png"];
    lifetimeImage1 = [UIImage imageNamed: @"subB_btnlifetime1.png"];
    weeklyImage0 = [UIImage imageNamed: @"subB_btnweek0.png"];
    weeklyImage1 = [UIImage imageNamed: @"subB_btnweek1.png"];
    [_lifetimeImage setImage:lifetimeImage1];
    [_weeklyImage setImage:weeklyImage0];
    [self subbutton:removeads];
}



- (IBAction)termsOfUseBtn:(id)sender {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:term];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Term");
        }
    }];
    NSLog(@"terms of Uses press");
}

- (IBAction)privacyPolicyBtn:(id)sender {
    NSLog(@"privacyPolicyBtn press");
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:policy];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"policy");
        }
    }];
    NSLog(@"privacy policy press");
}

- (IBAction)cancelBtn:(id)sender {
//    NSLog(@"%@", self.window.rootViewController);
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] showNavigation];
        });
    }
}

- (IBAction)continueBtn:(id)sender {
    NSLog(@"%@",self.productID);
    [self addPurchase:self.productID];
}

- (IBAction)weekyBtn:(id)sender {
    [_lifetimeImage setImage:lifetimeImage0];
    [_weeklyImage setImage:weeklyImage1];
    NSLog(@"week press");
    [self subbutton:weekly];
//    [self addPurchase:self.productID];
    
}

- (IBAction)lifetimeBtn:(id)sender {
    [_lifetimeImage setImage:lifetimeImage1];
    [_weeklyImage setImage:weeklyImage0];
    NSLog(@"lifetime press");
    [self subbutton:removeads];
//    [self addPurchase:self.productID];
}

- (IBAction)restore:(id)sender {
    NSLog(@"restore button press");
    [self restorepurchase];
}
@end
