//
//  DefaultTabbarBadgeScaleAnimation.m
//  UITabBarItem+CustomBadge
//
//  Created by Ratul Sharker on 1/10/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "DefaultTabbarBadgeScaleAnimation.h"

@implementation DefaultTabbarBadgeScaleAnimation


#pragma mark UITabbarItemBadgeAnimation
-(void)UITabbarItemBadgeAppearAnimationForBadge:(UILabel*)badge
                                   withNewValue:(NSString*)msg
                                 withCompletion:(BadgeAnimationCompletionBlock)completion
{
    badge.transform = CGAffineTransformScale(CGAffineTransformIdentity,
                                             UITABBAR_CUSTOMBADGE_SCALE_FACTOR,
                                             UITABBAR_CUSTOMBADGE_SCALE_FACTOR);
    badge.text = msg;
    badge.hidden = NO;
    badge.alpha = 1.0;
    
    
    
    [UIView animateWithDuration: UITABBAR_CUSTOMBADGE_SCALE_ANIMATION_TIME
                          delay: 0.0
                        options: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                     animations: ^{
                         badge.transform = CGAffineTransformIdentity;
    }
                     completion: ^(BOOL finished) {
        if(completion)
            completion();
                         
        badge.transform = CGAffineTransformIdentity;
    }];
}

-(void)UITabbarItemBadgeDisappearAnimationForBadge:(UILabel*)badge
                                    withCompletion:(BadgeAnimationCompletionBlock)completion
{
    badge.transform = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:UITABBAR_CUSTOMBADGE_SCALE_ANIMATION_TIME
                     animations:^{
                         badge.transform = CGAffineTransformScale(CGAffineTransformIdentity,
                                                                  UITABBAR_CUSTOMBADGE_SCALE_FACTOR,
                                                                  UITABBAR_CUSTOMBADGE_SCALE_FACTOR);
                     }
                     completion:^(BOOL finished) {
                         if(completion)
                             completion();
                         
                         badge.transform = CGAffineTransformIdentity;
                         
                     }];
}

@end
