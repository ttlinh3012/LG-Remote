//
//  SubAViewController.m
//  LGUItest
//
//  Created by Soosky on 16/06/2021.
//

#import "SubAViewController.h"
#import "AppDelegate.h"


static NSString * const policy = @"https://sites.google.com/view/remotecontroltvpolicy/";
static NSString * const term = @"https://sites.google.com/view/remotecontroltermsofuse/";
@interface SubAViewController ()

@end

@implementation SubAViewController{
    UIImage *weeklyImage1;
    UIImage *weeklyImage0;
    UIImage *lifetimeImage0;
    UIImage *lifetimeImage1;
    UIImage *trialImage0;
    UIImage *trialImage1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    weeklyImage0 = [UIImage imageNamed: @"subA_btnweek.png"];
    weeklyImage1 = [UIImage imageNamed: @"subA_weekly1.png"];
    trialImage0 = [UIImage imageNamed: @"subA-trial.png"];
    trialImage1 = [UIImage imageNamed: @"subA_btnyearly.png"];
    lifetimeImage0 = [UIImage imageNamed: @"subA_btnlifetime.png"];
    lifetimeImage1 = [UIImage imageNamed: @"subA_lifetime1.png"];
    [_trialSubAImage setImage:trialImage1];
    [_weelySubAImage setImage:weeklyImage0];
    [_lifetimeSubAImage setImage:lifetimeImage0];
    // Do any additional setup after loading the view.
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self subbutton:yearly];
}



- (IBAction)restore:(id)sender {
    NSLog(@"restore button press");
    [self restorepurchase];
}

- (IBAction)privacyPolicyBtnPress:(id)sender {
    NSLog(@"privacyPolicyBtn press");
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:policy];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"policy");
        }
    }];
}

- (IBAction)termsOffUseBtnPress:(id)sender {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:term];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Term");
        }
    }];
    NSLog(@"termsOffUseBtn press");
    
}

- (IBAction)lifeTimeBtnPress:(id)sender {
    [_trialSubAImage setImage:trialImage0];
    [_weelySubAImage setImage:weeklyImage0];
    [_lifetimeSubAImage setImage:lifetimeImage1];
    
    [self subbutton:removeads];
    [self addPurchase:self.productID];
    NSLog(@"%@",self.productID);
    NSLog(@"lifeTimeBtn press");
}

- (IBAction)weeklyBtnPress:(id)sender {
    [_trialSubAImage setImage:trialImage0];
    [_weelySubAImage setImage:weeklyImage1];
    [_lifetimeSubAImage setImage:lifetimeImage0];
    [self subbutton:weekly];
    [self addPurchase:self.productID];
    NSLog(@"%@",self.productID);
    NSLog(@"weeklyBtn press");
    
}

- (IBAction)trialBtnPress:(id)sender {
    [_trialSubAImage setImage:trialImage1];
    [_weelySubAImage setImage:weeklyImage0];
    [_lifetimeSubAImage setImage:lifetimeImage0];
    [self subbutton:yearly];
    [self addPurchase:self.productID];
    NSLog(@"%@",self.productID);
    NSLog(@"trialBtn press");
}

- (IBAction)cancelBtn:(id)sender {
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if((appDelegate.CreatedNavigation==NO))
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [(AppDelegate *)[[UIApplication sharedApplication] delegate] showNavigation];
            });
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
    }
    NSLog(@"cancel press");
}
@end
