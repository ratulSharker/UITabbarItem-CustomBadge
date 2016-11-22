//
//  DefaultSystemLikeBadgeConfiguration.h
//  UITabBarItem+CustomBadge
//
//  Created by Ratul Sharker on 11/20/16.
//  Copyright © 2016 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITabBarItem+CustomBadge.h"


//
//  a default implemented of the badge visual appearance
//

@interface DefaultSystemLikeBadgeConfiguration : NSObject <UITabbarItemBadgeConfiguration>

@property BOOL enableLog;

@property UIColor *badgeBackgroundColor;
@property UIColor *badgeTextColor;
@property UIColor *badgeBorderColor;

@property CGFloat badgeBorderWidth;

@property UIFont *badgeFont;

@property CGFloat badgeTextTopBottomSpacing;
@property CGFloat badgeTextLeftRightSpacing;
@property CGFloat badgeMinHeight;

@property CGFloat badgeLabelTopSpacing;
@property CGFloat badgeLabelRightSpacing;

@end
