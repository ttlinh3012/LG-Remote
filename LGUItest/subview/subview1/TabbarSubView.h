//
//  tabbarsubview.h
//  LGUItest
//
//  Created by Soosky on 24/05/2021.
//

#import <UIKit/UIKit.h>

@protocol SetScreenDelegate
@optional
- (void)setScreen1;
- (void)setScreen2;
- (void)setScreen3;

@end



@interface TabbarSubView : UIView
@property (weak, nonatomic) IBOutlet UIButton *fremotebtn;
@property (weak, nonatomic) IBOutlet UIButton *fchanelbtn;
@property (weak, nonatomic) IBOutlet UIButton *fsettingbtn;

@property (nonatomic,weak)id<SetScreenDelegate>screenDelegate;

//@property (nonatomic,weak)id<LoadCell>cellDelegate;

@property (weak, nonatomic) IBOutlet UIImageView *remotefooter;
@property (weak, nonatomic) IBOutlet UIImageView *channelfooter;
@property (weak, nonatomic) IBOutlet UIImageView *settingsfooter;


@end


