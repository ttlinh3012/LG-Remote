//
//  numboardsubView.m
//  LGUItest
//
//  Created by Soosky on 07/06/2021.
//

#import "numboardsubView.h"
#import "ViewController.h"

@implementation numboardsubView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)p0:(id)sender {
    NSLog(@"press num0");
    [self.delegate num0];
}

- (IBAction)p9:(id)sender {
    [self.delegate num9];
}

- (IBAction)p8:(id)sender {
    [self.delegate num8];
}

- (IBAction)p7:(id)sender {
    [self.delegate num7];
}

- (IBAction)p6:(id)sender {
    [self.delegate num6];
}

- (IBAction)p5:(id)sender {
    [self.delegate num5];
}

- (IBAction)p4:(id)sender {
    [self.delegate num4];
}

- (IBAction)p3:(id)sender {
    [self.delegate num3];
}

- (IBAction)p2:(id)sender {
    [self.delegate num2];
}

- (IBAction)p1:(id)sender {
    [self.delegate num1];
}
@end
