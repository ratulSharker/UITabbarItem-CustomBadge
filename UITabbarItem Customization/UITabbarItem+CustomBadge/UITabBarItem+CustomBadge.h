//
//  UITabBarItem+CustomBadge.h
//  UITabbar+CustomBadge
//
//  Created by Ratul Sharker on 5/31/16.
//

#import <UIKit/UIKit.h>




//
//  completion block and protocol declaration
//  to be used into the custom animation implementation
//
typedef void(^BadgeAnimationCompletionBlock)();

@protocol UITabbarItemBadgeAnimation <NSObject>

-(void)UITabbarItemBadgeAppearAnimationForBadge:(UILabel*)badge
                                   withNewValue:(NSString*)msg
                                 withCompletion:(BadgeAnimationCompletionBlock)completion;

-(void)UITabbarItemBadgeDisappearAnimationForBadge:(UILabel*)badge
                                    withCompletion:(BadgeAnimationCompletionBlock)completion;
@end


//
//  log related macro
//
#define UITABBAR_CUSTOMBADGE_ENABLE_LOG

//
//  SIZING RELATED MACROS
//
#define UITABBAR_CUSTOMBADGE_TOP_BOTTOM_PADDING  0
#define UITABBAR_CUSTOMBADGE_LEFT_RIGHT_PADDING  0
#define UITABBAR_CUSTOMBADGE_HEIGHT             18
#define UITABBAR_CUSTOMBADGE_Y_POSITION_MARGIN  -0
#define UITABBAR_CUSTOMBADGE_BORDER_WIDTH       0.75

//
//  PLACING RELATED MACROS
//
#define UITABBAR_CUSTOMBADGE_RIGHT_MARGIN       0

//
//  DOES OVERLAPPING WILL BE SUPPORTED
//
#define ENABLE_OVERLAPING_FEATURE

//
//  COLOR RELATED MACROS
//
#define UITABBAR_CUSTOMBADGE_BACKGROUND_COLOR   [UIColor yellowColor]
#define UITABBAR_CUSTOMBADGE_TEXT_COLOR         [UIColor redColor]
#define UITABBAR_CUSTOMBADGE_BORDER_COLOR       [UIColor redColor]

//
//  ANIMATION TIME RELATED MACROS
//
#define UITABBAR_CUSTOMBADGE_TEXT_TRANSITION_DURATION 0.5
#define UITABBAR_CUSTOMBADGE_SHOW_HIDE_FADE_ANIMATION_DURATION 0.5

//
//  FONT RELATED MACROS
//
#define UITABBAR_CUSTOMBADGE_TEXT_FONT  [UIFont systemFontOfSize:10]

@interface UITabBarItem (CustomBadge)

//@property id<UITabbarItemBadgeAnimation> badgeAnimationProvider;


+(void)setDefaultAnimationProvider:(id<UITabbarItemBadgeAnimation>) animationProvider;

@end
