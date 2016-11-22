//
//  DefaultTabbarBadgeAnimation.m
//  UITabBarItem+CustomBadge
//
//  Created by Ratul Sharker on 11/15/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "DefaultTabbarBadgeAnimation.h"

@implementation DefaultTabbarBadgeAnimation

//
//  appearing animation protocol implementation
//
-(void)UITabbarItemBadgeAppearAnimationForBadge:(UILabel*)badge
                                   withNewValue:(NSString*)msg
                                 withCompletion:(BadgeAnimationCompletionBlock)completion
{
    badge.hidden = NO;
    
    [UIView animateWithDuration:UITABBAR_CUSTOMBADGE_TEXT_TRANSITION_DURATION
                     animations:^{
                         badge.alpha = 1.0;
                     }];
    
    UIApplication *app = [UIApplication sharedApplication];

    [app beginIgnoringInteractionEvents];
    
    [UIView transitionWithView:badge
                      duration:UITABBAR_CUSTOMBADGE_SHOW_HIDE_FADE_ANIMATION_DURATION
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        badge.text = msg;
                    } completion:^(BOOL finished) {
                        if(completion)
                            completion();
                        [app endIgnoringInteractionEvents];
                    }];
    
}

//
//  disappearing animation protocol implementation
//
-(void)UITabbarItemBadgeDisappearAnimationForBadge:(UILabel*)badge
                                    withCompletion:(BadgeAnimationCompletionBlock)completion
{
    
    [UIView animateWithDuration:UITABBAR_CUSTOMBADGE_SHOW_HIDE_FADE_ANIMATION_DURATION
                     animations:^{
                         badge.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         badge.hidden = YES;
                         
                         if(completion)
                             completion();
                     }];
}


@end
