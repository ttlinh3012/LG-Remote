//
//  IntroViewViewController.m
//  LGUItest
//
//  Created by Soosky on 25/06/2021.
//
#import <UIKit/UIKit.h>
#import "IntroViewViewController.h"
#import "Intro1ViewController.h"
#import "Intro2ViewController.h"
#import "SubBViewController.h"

@interface IntroViewViewController ()

@end

@implementation IntroViewViewController{
    NSArray *page;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource =self;

    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    Intro1ViewController *introView1 = [storyboard instantiateViewControllerWithIdentifier:@"Intro1View"];
    introView1.intro1delegate =self;
    Intro2ViewController *introView2 = [storyboard instantiateViewControllerWithIdentifier:@"Intro2View"];
    introView2.Intro2Delegate =self;
    SubBViewController *subB = [storyboard instantiateViewControllerWithIdentifier:@"SubB"];
    page = @[introView1,introView2,subB];
    NSArray *selectPage =[NSArray arrayWithObject:page[0]];
   
    
    
    [self setViewControllers:selectPage direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
}
-(void)showIntro2Screen{
    NSArray *selectPage =[NSArray arrayWithObject:page[1]];
    [self setViewControllers:selectPage direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}
-(void)showSubBScreen{
    NSArray *selectPage =[NSArray arrayWithObject:page[2]];
    [self setViewControllers:selectPage direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    return nil;
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    return nil;
}




@end
