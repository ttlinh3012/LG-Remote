//
//  Intro2ViewController.h
//  LGUItest
//
//  Created by Soosky on 23/06/2021.
//
#import <UIKit/UIKit.h>
#import "ViewController.h"

@protocol ShowSubBScreen <NSObject>

-(void)showSubBScreen;

@end

@interface Intro2ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewIntro2Player;

- (IBAction)continueIntro2Btn:(id)sender;
@property(weak,nonatomic)id<ShowSubBScreen>Intro2Delegate;

@end


