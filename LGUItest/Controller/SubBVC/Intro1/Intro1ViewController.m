//
//  Intro1ViewController.m
//  LGUItest
//
//  Created by Soosky on 23/06/2021.
//

#import "Intro1ViewController.h"
#import "Intro2ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface Intro1ViewController ()

@end

@implementation Intro1ViewController{
    AVPlayerItem *_playerItem;
    AVQueuePlayer *_player;
    AVPlayerLooper *_playerLooper;
    AVPlayerLayer *_playerLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *videoFile = [[NSBundle mainBundle] pathForResource:@"intro1" ofType:@"mp4"];
    NSURL *videoURL = [NSURL fileURLWithPath:videoFile];
    _playerItem = [AVPlayerItem playerItemWithURL:videoURL];
    _player = [AVQueuePlayer queuePlayerWithItems:@[_playerItem]];
    _playerLooper = [AVPlayerLooper playerLooperWithPlayer:_player templateItem:_playerItem];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill ;
    [self.view_player.layer addSublayer:_playerLayer];
    [_player play];
}



- (IBAction)continueBtn:(id)sender {
    [self.intro1delegate showIntro2Screen];
    NSLog(@"Press Continue");
}
@end
