//
//  UITabbarItemBadgeConfiguration.h
//  UITabBarItem+CustomBadge
//
//  Created by Ratul Sharker on 11/20/16.
//

#ifndef UITabbarItemBadgeConfiguration_h
#define UITabbarItemBadgeConfiguration_h

//
//  This protocol declares the properties
//  implementing which will allow to change
//  the visual appearance of the custom
//  badge
//
@protocol UITabbarItemBadgeConfiguration <NSObject>

@required

    //
    //  enable or disable verbose log
    //
    @property BOOL enableLog;

    //
    //  badge's color related properites
    //
    @property UIColor *badgeBackgroundColor;
    @property UIColor *badgeTextColor;
    @property UIColor *badgeBorderColor;

    //
    //  badge border width
    //
    @property CGFloat badgeBorderWidth;

    //
    //  badge label's font
    //
    @property UIFont *badgeFont;

    //
    //  badge label sizing related properties
    //
    @property CGFloat badgeTextTopBottomSpacing;
    @property CGFloat badgeTextLeftRightSpacing;
    @property CGFloat badgeMinHeight;

    //
    //  badge label's origin related properties
    //
    @property CGFloat badgeLabelTopSpacing;
    @property CGFloat badgeLabelRightSpacing;

@end

#endif /* UITabbarItemBadgeConfiguration_h */
