//
//  SettingsViewController.h
//  LGUItest
//
//  Created by Soosky on 08/06/2021.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"
#import <MessageUI/MessageUI.h>

@interface SettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *UItableview;

@end


