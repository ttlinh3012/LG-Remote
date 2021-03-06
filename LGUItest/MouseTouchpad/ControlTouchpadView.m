//
//  ControlTouchpadView.m
//  Connect SDK Sampler App
//
//  Created by Andrew Longstaff on 9/25/13.
//  Connect SDK Sample App by LG Electronics
//
//  To the extent possible under law, the person who associated CC0 with
//  this sample app has waived all copyright and related or neighboring rights
//  to the sample app.
//
//  You should have received a copy of the CC0 legalcode along with this
//  work. If not, see http://creativecommons.org/publicdomain/zero/1.0/.
//

#import "ControlTouchpadView.h"

@implementation ControlTouchpadView
{
    float oldX;
    float oldY;
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    oldX = touchLocation.x;
    oldY = touchLocation.y;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    NSLog(@"it moved");
    NSLog(@"%f;%f",oldY,oldX);
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    unsigned long fingersDown = [[event allTouches] count];
    if (self.mouseControl)
    {   NSLog(@"send move to tv");
        CGVector distance = CGVectorMake(
            touchLocation.x - oldX,
            touchLocation.y - oldY
        );
        
        if (fingersDown >= 2)
        {
            [self.mouseControl scroll:distance success:^(id responseObject)
            {
            NSLog(@"mouse scrolled!");
            } failure:^(NSError *error)
            {
                NSLog(@"Mouse scroll failed: %@", error.localizedDescription);
            }];
        } else
        {
            [self.mouseControl move:distance success:^(id responseObject)
            {
            NSLog(@"mouse moved!");
            } failure:^(NSError *error)
            {
                NSLog(@"Mouse move failed: %@", error.localizedDescription);
            }];
        }
    }

    oldX = touchLocation.x;
    oldY = touchLocation.y;
}

- (void)tapDetected:(id)sender
{
    [self.mouseControl clickWithSuccess:nil failure:nil];
    NSLog(@"tap here");
}

@end
