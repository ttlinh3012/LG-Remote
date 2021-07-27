//
//  SubAViewController.h
//  LGUItest
//
//  Created by Soosky on 16/06/2021.
//

#import <UIKit/UIKit.h>
#import "BaseSubVViewController.h"


@interface SubAViewController : BaseSubVViewController

@property (strong, nonatomic) IBOutlet UIImageView *weelySubAImage;
@property (strong, nonatomic) IBOutlet UIImageView *lifetimeSubAImage;
@property (strong, nonatomic) IBOutlet UIImageView *trialSubAImage;
@property (weak, nonatomic) IBOutlet UILabel *productIDDescription;


- (IBAction)cancelBtn:(id)sender;

- (IBAction)trialBtnPress:(id)sender;
- (IBAction)weeklyBtnPress:(id)sender;
- (IBAction)lifeTimeBtnPress:(id)sender;
- (IBAction)termsOffUseBtnPress:(id)sender;
- (IBAction)privacyPolicyBtnPress:(id)sender;
- (IBAction)restore:(id)sender;


@end

