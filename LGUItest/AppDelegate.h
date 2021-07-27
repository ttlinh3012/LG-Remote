//
//  AppDelegate.h
//  LGUItest
//
//  Created by Soosky on 24/05/2021.
//

#import <UIKit/UIKit.h>
#import "ConnectableDevice.h"

extern const struct ConstantsStruct{
    NSString *App_Specific_Shared_Secret;
    
    NSString *BANNER_ID ;
    
    NSString *FULL_ID ;
    
    NSString *VIDEO_FULL_ID ;
    
    NSString *VIDEO_ID;
    
    NSString *NATIVE_ID;
    
    NSString *OPEN_ID ;
    
    NSString *APP_ID;
}Constants;
//BOOL CreatedNavigation =false;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *connectAbleDevices;
@property (strong, nonatomic) ConnectableDevice *device;
-(void)showNavigation;
-(void)showSubHu;
-(void)showSubNgoan;
@property  BOOL CreatedNavigation;
//+(UIWindow*)keyWindow;
@end

