//
//  DefaultTabbarBadgeFlipAnimation.h
//  UITabBarItem+CustomBadge
//
//  Created by Ratul Sharker on 1/11/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITabBarItem+CustomBadge.h"

//
//  ANIMATION TIME RELATED MACROS
//
#define UITABBAR_CUSTOMBADGE_FLIP_ANIMATION_DURATION    0.2
#define UITABBAR_CUSTOMBADGE_FLIP_BADGE_Z_INDEX         100

typedef enum
{
    HORIZONTAL_FLIP,
    VERTICAL_FLIP
} UITABBAR_CUSTOMBADGE_FLIP_DIRECTION;

//
//  a default implemented of the badge appear and disappear
//  animation
//
@interface DefaultTabbarBadgeFlipAnimation : NSObject <UITabbarItemBadgeAnimation>

-(instancetype)initWithFlipDirection:(UITABBAR_CUSTOMBADGE_FLIP_DIRECTION)direction;
-(void)setDirection:(UITABBAR_CUSTOMBADGE_FLIP_DIRECTION)direction;

@end
