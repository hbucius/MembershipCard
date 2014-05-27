//
//  CustomSegue.m
//  MembershipCard
//
//  Created by mstr on 5/27/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "CustomSegue.h"

@implementation CustomSegue

- (void)perform
{
    if([self.direction  isEqualToString:@"RIGHTTOLEFT"])
        {
            UIView *sv = ((UIViewController *)self.sourceViewController).view;
            UIView *dv = ((UIViewController *)self.destinationViewController).view;
            
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
            dv.center = CGPointMake(sv.center.x + sv.frame.size.width,
                                    dv.center.y);
            [window insertSubview:dv aboveSubview:sv];
            
            [UIView animateWithDuration:0.4
                             animations:^{
                                 dv.center = CGPointMake(sv.center.x,
                                                         dv.center.y);
                                 sv.center = CGPointMake(0 - sv.center.x,
                                                         dv.center.y);
                             }
                             completion:^(BOOL finished){
                                 [[self sourceViewController] presentViewController:
                                  [self destinationViewController] animated:NO completion:nil];
                             }];
            
        }
    else if ([self.direction isEqualToString:@"LEFTTORIGHT"]){
        
        UIView *sv = ((UIViewController *)self.sourceViewController).view;
        UIView *dv = ((UIViewController *)self.destinationViewController).view;
        
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        dv.center = CGPointMake(sv.center.x - sv.frame.size.width,
                                dv.center.y);
        [window insertSubview:dv aboveSubview:sv];
        
        [UIView animateWithDuration:0.4
                         animations:^{
                             dv.center = CGPointMake(sv.center.x,
                                                     dv.center.y);
                             sv.center = CGPointMake( sv.center.x+sv.frame.size.width,
                                                     dv.center.y);
                         }
                         completion:^(BOOL finished){
                             [[self sourceViewController] presentViewController:
                              [self destinationViewController] animated:NO completion:nil];
                         }];

    }
}
@end
