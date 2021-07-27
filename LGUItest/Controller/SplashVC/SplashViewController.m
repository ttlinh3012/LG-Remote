//
//  SplashViewController.m
//  LGUItest
//
//  Created by Soosky on 21/07/2021.
//

#import "SplashViewController.h"
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "Navigation.h"
#import "AppDelegate.h"
@import Firebase;
@interface SplashViewController ()


@end

@implementation SplashViewController
{
    Reachability *isConnectNetwork;
    BOOL checkSubStatus;
    NSString *user;
    long setMod;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer * _Nonnull timer)
    {
        
        if (![self connected])
        {
                NSLog(@"not connect interner");
            [self showVC];
        }
        else
            
        {
            [self checkSub];
        }
        
    }];
    
}
-(BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [reachability currentReachabilityStatus];
        return networkStatus != NotReachable;
}

-(void)checkSub{
    self->checkSubStatus = NO;
    self->checkSubStatus = [BaseSubVViewController checkInAppPurchaseStatus];
    NSLog(@"connected interner");
    user = [[NSUserDefaults standardUserDefaults] valueForKey:@"user"];
    if(![user isEqual:@"paid"])
    {

        if (checkSubStatus==NO)
        {
//            setMod = 0 ;
            self.ref = [[FIRDatabase database] reference];
            [[self.ref child:@"SetMod"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                 long dict = [snapshot.value integerValue];
                NSLog(@"cccc %ld",dict);
                self->setMod = dict;
                NSLog(@"cccc %ld",dict);
                [self changeUser];
            } withCancelBlock:^(NSError * _Nonnull error) {
                NSLog(@"cccc %@", error.localizedDescription);
                self->setMod = 0 ;
                [self changeUser];
            }];
            
            
           

        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setValue:@"sub_purchased" forKey:@"user"];
            [self showVC];
        }
    
    }

    
}
-(void)changeUser
{
    if (self->setMod==1)
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"subHu" forKey:@"user"];
    }
    else if (self->setMod==0)
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"subNgoan" forKey:@"user"];
    }
    [self showVC];
    NSLog(@"dddd %@",[[NSUserDefaults standardUserDefaults] valueForKey:@"user"]);
}
-(void)showVC
{
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] isEqual:@"sub_purchased"]||[[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] isEqual:@"paid"])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] showNavigation];
        });
    }
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] isEqual:@"subHu"])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] showSubHu];
        });
    }
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] isEqual:@"subNgoan"])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] showSubNgoan];
        });
//        [[NSUserDefaults standardUserDefaults] setValue:@"subHu" forKey:@"user"];
    }
}


@end
