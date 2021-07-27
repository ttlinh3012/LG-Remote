//
//  IntroViewViewController.h
//  LGUItest
//
//  Created by Soosky on 25/06/2021.
//

#import <UIKit/UIKit.h>
#import "Intro1ViewController.h"
#import "Intro2ViewController.h"

@interface IntroViewViewController : UIPageViewController<ShowIntro2Screen,ShowSubBScreen,UIPageViewControllerDataSource>
@end


