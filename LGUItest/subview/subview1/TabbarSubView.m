//
//  tabbarsubview.m
//  LGUItest
//
//  Created by Soosky on 24/05/2021.
//

#import "TabbarSubView.h"
#import "TabbarController.h"
@implementation TabbarSubView


- (IBAction)remotebtnact:(id)sender {
    self.remotefooter.image = [UIImage imageNamed:@"footer_btnremote1.png"];
    self.channelfooter.image = [UIImage imageNamed:@"footer_btnchannel0.png"];
    self.settingsfooter.image = [UIImage imageNamed:@"footer_btnsettings0.png"];
    [self.screenDelegate setScreen1];
    
}
- (IBAction)chanelbtnact:(id)sender {
    self.remotefooter.image = [UIImage imageNamed:@"footer_btnremote0.png"];
    self.channelfooter.image = [UIImage imageNamed:@"footer_btnchannel1.png"];
    self.settingsfooter.image = [UIImage imageNamed:@"footer_btnsettings0.png"];
    [self.screenDelegate setScreen2];
//    [self.cellDelegate loadcelllist];
}

- (IBAction)settingbtn:(id)sender {
    self.remotefooter.image = [UIImage imageNamed:@"footer_btnremote0.png"];
    self.channelfooter.image = [UIImage imageNamed:@"footer_btnchannel0.png"];
    self.settingsfooter.image = [UIImage imageNamed:@"footer_btnsettings1.png"];
    [self.screenDelegate setScreen3];
}


@end



