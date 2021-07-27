//
//  SplashViewController.h
//  LGUItest
//
//  Created by Soosky on 21/07/2021.
//

#import "ViewController.h"
#import "BaseSubVViewController.h"
@import Firebase;

@interface SplashViewController : BaseSubVViewController
-(BOOL)connected;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end


