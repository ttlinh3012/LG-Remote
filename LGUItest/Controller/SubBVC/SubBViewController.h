//
//  SubBViewController.h
//  LGUItest
//
//  Created by Soosky on 16/06/2021.
//

#import <UIKit/UIKit.h>
#import "BaseSubVViewController.h"


@interface SubBViewController : BaseSubVViewController
@property (strong, nonatomic) IBOutlet UIImageView *weeklyImage;
@property (strong, nonatomic) IBOutlet UIImageView *lifetimeImage;

@property (weak, nonatomic) IBOutlet UIView *View_Player;

- (IBAction)lifetimeBtn:(id)sender;
- (IBAction)weekyBtn:(id)sender;
- (IBAction)continueBtn:(id)sender;
- (IBAction)cancelBtn:(id)sender;
- (IBAction)privacyPolicyBtn:(id)sender;
- (IBAction)termsOfUseBtn:(id)sender;



@end


