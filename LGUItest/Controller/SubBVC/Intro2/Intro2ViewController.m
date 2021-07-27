//
//  Intro2ViewController.m
//  LGUItest
//
//  Created by Soosky on 23/06/2021.
//

#import "Intro2ViewController.h"
#import "SubBViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface Intro2ViewController ()

@end

@implementation Intro2ViewController{
    AVPlayerItem *_playerItem;
    AVQueuePlayer *_player;
    AVPlayerLooper *_playerLooper;
    AVPlayerLayer *_playerLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *videoFile = [[NSBundle mainBundle] pathForResource:@"intro2" ofType:@"mp4"];
    NSURL *videoURL = [NSURL fileURLWithPath:videoFile];
    _playerItem = [AVPlayerItem playerItemWithURL:videoURL];
    _player = [AVQueuePlayer queuePlayerWithItems:@[_playerItem]];
    _playerLooper = [AVPlayerLooper playerLooperWithPlayer:_player templateItem:_playerItem];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill ;
    [self.viewIntro2Player.layer addSublayer:_playerLayer];
    [_player play];
//    NSLog(@"xxxx %f",_playerLayer.frame.size);
    
}




- (IBAction)continueIntro2Btn:(id)sender {
    NSLog(@"Press continue");
    [self.Intro2Delegate showSubBScreen];
}
@end
