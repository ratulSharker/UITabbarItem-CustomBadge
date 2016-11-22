//
//  UITabBarItem+CustomBadge.h
//  UITabbar+CustomBadge
//
//  Created by Ratul Sharker on 5/31/16.
//

#import <UIKit/UIKit.h>
#import "UITabbarItemAnimation.h"
#import "UITabbarItemBadgeConfiguration.h"

//
//  DETERMINES DOES OVERLAPPING OF BADGE LABEL UPON TABBAR ITEM WILL BE SUPPORTED OR NOT
//
//  it's recommended to use the overlapping feature,
//  it will place your lable at the top of the all of the
//  view, in hierarchy of the bar button items subview scale
//
#define ENABLE_OVERLAPING_FEATURE


//
//  extension to add feature and override feature
//
@interface UITabBarItem (CustomBadge)

//
//  let set your animation provider here to be in effect.
//  a good place to set this animation provider is the
//  AppDelegate's didFinishLaunchingWithOptions method
//
+(void)setDefaultAnimationProvider:(id<UITabbarItemBadgeAnimation>) animationProvider;

//
//  let you set the badge level customization configuration.
//  a good place to set this customization configuration is
//  the AppDelegate's didFinishLaunchingWithOptions method
//
+(void)setDefaultConfigurationProvider:(id<UITabbarItemBadgeConfiguration>) configurationProvider;

//
//  this method provided the last assigned customization
//  configuration. this method facilitates you to not maintaining
//  a reference to the last assigned confiuration. after assign the
//  configuration, just forget it, whenever necessary use this method
//  to grab the last assinged configuration settings
//
+(id<UITabbarItemBadgeConfiguration>)getDefaultConfigurationProvider;

//
//  this method lets you to re-apply the
//  last assigned configuration. remember
//  the scope of this method is upto tabbar item.
//  so if you want apply the last change to all tabbar
//  badge, you should loop through all the tabbar item
//  and call this method for all the tabbar item.
//
-(void)reloadBadgeConfiguration;

@end
