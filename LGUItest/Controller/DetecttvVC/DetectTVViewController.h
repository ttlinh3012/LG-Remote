//
//  DetectTVViewController.h
//  LGUItest
//
//  Created by Soosky on 18/06/2021.
//

#import <UIKit/UIKit.h>
#import "DetectTVCell.h"
#import "ConnectSDK.h"
@protocol Sendcurrentdevice
-(void)Currentdevice: (ConnectableDevice*) device;
@end

@interface DetectTVViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, DiscoveryManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *detectTable;
- (IBAction)cacelBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic)id <Sendcurrentdevice>sendDelegate;
-(void)CancelScrenDetect;
//@property (nonatomic, weak) ConnectableDevice *currentDevice;
@end


