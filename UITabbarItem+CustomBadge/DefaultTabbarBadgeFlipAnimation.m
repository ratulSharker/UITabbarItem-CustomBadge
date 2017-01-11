//
//  DefaultTabbarBadgeFlipAnimation.m
//  UITabBarItem+CustomBadge
//
//  Created by Ratul Sharker on 1/11/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "DefaultTabbarBadgeFlipAnimation.h"

@implementation DefaultTabbarBadgeFlipAnimation
{
    UITABBAR_CUSTOMBADGE_FLIP_DIRECTION direction;
}


#pragma mark initializer method
-(instancetype)initWithFlipDirection:(UITABBAR_CUSTOMBADGE_FLIP_DIRECTION)dir
{
    self = [super init];
    if(self)
    {
        [self setDirection:dir];
    }
    
    return self;
}

#pragma mark public method
-(void)setDirection:(UITABBAR_CUSTOMBADGE_FLIP_DIRECTION)dir
{
    direction = dir;
}

#pragma mark UITabbarItemBadgeAnimation
-(void)UITabbarItemBadgeAppearAnimationForBadge:(UILabel*)badge
                                   withNewValue:(NSString*)msg
                                 withCompletion:(BadgeAnimationCompletionBlock)completion
{
    
    badge.layer.transform = CATransform3DIdentity;
    badge.layer.zPosition = UITABBAR_CUSTOMBADGE_FLIP_BADGE_Z_INDEX;
    
    badge.hidden = NO;
    badge.alpha = 1.0;
    
    badge.layer.backgroundColor = [UIColor greenColor].CGColor;
    
    badge.layer.transform = CATransform3DIdentity;
    
    [UIView animateWithDuration:UITABBAR_CUSTOMBADGE_FLIP_ANIMATION_DURATION
                          delay: 0.0
                        options: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
        badge.layer.transform = CATransform3DRotate(CATransform3DIdentity,
                                                    M_PI,
                                                    direction == VERTICAL_FLIP,
                                                    direction == HORIZONTAL_FLIP,
                                                    0);
        badge.text = @"";
    }
                     completion:^(BOOL finished) {
                         
                         badge.text = msg;
                         if(completion)
                             completion();
                         badge.layer.transform = CATransform3DIdentity;
    }];
}

-(void)UITabbarItemBadgeDisappearAnimationForBadge:(UILabel*)badge
                                    withCompletion:(BadgeAnimationCompletionBlock)completion
{
    
    badge.layer.transform = CATransform3DIdentity;
    badge.layer.zPosition = UITABBAR_CUSTOMBADGE_FLIP_BADGE_Z_INDEX;
    
    [UIView animateWithDuration:UITABBAR_CUSTOMBADGE_FLIP_ANIMATION_DURATION
                          delay: 0.0
                        options: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
        badge.layer.transform = CATransform3DRotate(CATransform3DIdentity,
                                                    M_PI,
                                                    direction == VERTICAL_FLIP,
                                                    direction == HORIZONTAL_FLIP,
                                                    0);
        badge.alpha = 0.5;
        badge.text = @"";
        
    }
                     completion:^(BOOL finished) {
                         
                         if(completion)
                             completion();
                         
                         badge.layer.transform = CATransform3DIdentity;
    }];
}


@end
