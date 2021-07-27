//
//  numboardsubView.h
//  LGUItest
//
//  Created by Soosky on 07/06/2021.
//

#import <UIKit/UIKit.h>
//#import "ViewController.h"

@protocol CallChanelDelegate
//@optional
- (void)num0;
- (void)num1;
- (void)num2;
- (void)num3;
- (void)num4;
- (void)num5;
- (void)num6;
- (void)num7;
- (void)num8;
- (void)num9;

@end

@interface numboardsubView : UIView
- (IBAction)p1:(id)sender;
- (IBAction)p2:(id)sender;
- (IBAction)p3:(id)sender;
- (IBAction)p4:(id)sender;
- (IBAction)p5:(id)sender;
- (IBAction)p6:(id)sender;
- (IBAction)p7:(id)sender;
- (IBAction)p8:(id)sender;
- (IBAction)p9:(id)sender;
- (IBAction)p0:(id)sender;
@property (nonatomic, strong)id<CallChanelDelegate>delegate;
@end


