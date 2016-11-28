//
//  DefaultTabbarBadgeAnimation.h
//  UITabBarItem+CustomBadge
//
//  Created by Ratul Sharker on 11/15/16.
//

#import <Foundation/Foundation.h>
#import "UITabBarItem+CustomBadge.h"


//
//  ANIMATION TIME RELATED MACROS
//
#define UITABBAR_CUSTOMBADGE_TEXT_TRANSITION_DURATION 0.3
#define UITABBAR_CUSTOMBADGE_SHOW_HIDE_FADE_ANIMATION_DURATION 0.3

//
//  a default implemented of the badge appear and disappear
//  animation
//
@interface DefaultTabbarBadgeAnimation : NSObject <UITabbarItemBadgeAnimation>

@end
