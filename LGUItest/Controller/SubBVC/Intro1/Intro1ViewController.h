//
//  Intro1ViewController.h
//  LGUItest
//
//  Created by Soosky on 23/06/2021.
//
#import <UIKit/UIKit.h>
#import "ViewController.h"

@protocol ShowIntro2Screen <NSObject>

-(void)showIntro2Screen;

@end


@interface Intro1ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *view_player;
- (IBAction)continueBtn:(id)sender;
//@property (weak,nonatomic) identifier;
@property(weak,nonatomic)id<ShowIntro2Screen>intro1delegate;
@end


