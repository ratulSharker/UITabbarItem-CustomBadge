//
//  DefaultTabbarBadgeScaleAnimation.h
//  UITabBarItem+CustomBadge
//
//  Created by Ratul Sharker on 1/10/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITabBarItem+CustomBadge.h"

//
//  ANIMATION TIME RELATED MACROS
//
#define UITABBAR_CUSTOMBADGE_SCALE_ANIMATION_TIME   0.2
#define UITABBAR_CUSTOMBADGE_SCALE_FACTOR           0.01

//
//  a default implemented of the badge appear and disappear
//  animation
//

@interface DefaultTabbarBadgeScaleAnimation : NSObject<UITabbarItemBadgeAnimation>

@end
