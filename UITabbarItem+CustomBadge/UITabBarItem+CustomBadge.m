//
//  UITabBarItem+CustomBadge.m
//  UITabbar+CustomBadge
//
//  Created by Ratul Sharker on 5/31/16.
//

#import "UITabBarItem+CustomBadge.h"



@implementation UITabBarItem (CustomBadge)

//
//  members variables
//
NSMutableDictionary *customBadgeLabels;

#ifdef ENABLE_OVERLAPING_FEATURE
NSMutableDictionary *respectiveTabbars;
#endif

//
//  static  variables
//
static NSString *UITabbarCustomBadgeConst = @"UITABBAR_CUSTOMBADGE_CONST";
static id<UITabbarItemBadgeAnimation>   badgeAnimationProvider;
static id<UITabbarItemBadgeConfiguration> badgeConfigurationProvider;



#pragma mark public class method
//
//  let set your animation provider here to be in effect.
//  a good place to set this animation provider is the
//  AppDelegate's didFinishLaunchingWithOptions method
//
+(void)setDefaultAnimationProvider:(id<UITabbarItemBadgeAnimation>) animationProvider
{
    badgeAnimationProvider = animationProvider;
}

//
//  let you set the badge level customization configuration.
//  a good place to set this customization configuration is
//  the AppDelegate's didFinishLaunchingWithOptions method
//
+(void)setDefaultConfigurationProvider:(id<UITabbarItemBadgeConfiguration>) configurationProvider
{
    badgeConfigurationProvider = configurationProvider;
}

//
//  this method provided the last assigned customization
//  configuration. this method facilitates you to not maintaining
//  a reference to the last assigned confiuration. after assign the
//  configuration, just forget it, whenever necessary use this method
//  to grab the last assinged configuration settings
//
+(id<UITabbarItemBadgeConfiguration>)getDefaultConfigurationProvider
{
    return badgeConfigurationProvider;
}

#pragma mark public instance method

//
//  this method lets you to re-apply the
//  last assigned configuration. remember
//  the scope of this method is upto tabbar item.
//  so if you want apply the last change to all tabbar
//  badge, you should loop through all the tabbar item
//  and call this method for all the tabbar item.
//
-(void)reloadBadgeConfiguration
{
    UILabel *customBadge = [self getCustomBadgeForCurrentTabbarItem];
    
    if(customBadge)
    {
        //
        //  if custom badge been already initialized,
        //  then modify it, other wise no need to modify
        //  because initializing a customBadge label
        //  will be configured with last configuration value
        //
        [self applyBadgeConfiguration:customBadge];
        
        UIView *tabbarItemView = [(UIView*)self performSelector:@selector(view)];
        
        //  determine the size of the badge lable
        //  determine the frame of the badge
        CGSize badgeSize = [self sizingBadgeLabel:customBadge
                          AccordingToMacrosAndMsg:customBadge.text
                                         InTabbar:tabbarItemView];
        CGRect badgeFrame = [self getFrameOfBadgeLabelSize:badgeSize
                                                  InTabbar:tabbarItemView];
        customBadge.frame = badgeFrame;
    }
}

//
//  overriden the getter of the
//  badgeValue property declared in
//  the tababr item
//
-(NSString*)badgeValue
{
    UILabel *customBadge = [self getCustomBadgeForCurrentTabbarItem];
    return (customBadge != nil) ? customBadge.text : @"";
}

//
//  overriden the setter of the
//  badgeValue property declared in
//  the tababr item
//
-(void) setBadgeValue:(NSString *)value
{
    @synchronized (UITabbarCustomBadgeConst) {
        
        //  initialized only once
        [self initializeCustomBadgeLabelDictionariesIfNecessary];
        
        //  getting the tabbar & particular customBadge
        UILabel *customBadge = (customBadgeLabels) ? customBadgeLabels[[NSString stringWithFormat:@"%u", (unsigned) self.hash]] : nil;
        
        if(customBadge == nil)
        {
            //
            //  initialize it with necessary params
            //
            customBadge = [self initializeAnBadgeLabelAccordingToMacro];
            
            //
            //  storing the initialized badge label
            //
            [customBadgeLabels setObject:customBadge
                                  forKey:[NSString stringWithFormat:@"%u", (unsigned)self.hash]];
            
#ifdef ENABLE_OVERLAPING_FEATURE
            
            //
            //  dig out the most top tabbar view
            //
            UIView *tabbarView = [self getCachedTopTabbarView];
            
            //
            //  now we can say that, tabbarView is cached
            //
            [tabbarView addSubview:customBadge];
#else
            //
            //  we want our customBadge inside the
            //  UITabbarItem, no matter where it stays
            //
            UIView *tabbarItemView = (UIView *)[self performSelector:@selector(view)];
            [tabbarItemView addSubview:customBadge];
#endif
            
        }
        
        
        //
        //  now check on the value, perform necessary action
        //  according to your value
        //
        if(value)
        {
            UIView *tabbarItemView = [(UIView*)self performSelector:@selector(view)];
            
            //  determine the size of the badge lable
            CGSize badgeSize = [self sizingBadgeLabel:customBadge AccordingToMacrosAndMsg:value InTabbar:tabbarItemView];
            CGRect badgeFrame = [self getFrameOfBadgeLabelSize:badgeSize InTabbar:tabbarItemView];
            customBadge.frame = badgeFrame;
            
            BadgeAnimationCompletionBlock showingCompletion = ^{
                    customBadge.text = value;
                    customBadge.hidden = NO;
                    customBadge.alpha = 1.0;
            };
            [self callBadgeAnimationProviderAppearanceAnimationwithBadge:customBadge
                                                               withValue:value
                                                          withCompletion:showingCompletion];
        }
        else
        {
            BadgeAnimationCompletionBlock hidingCompletion = ^{
                    customBadge.text = @"";
                    customBadge.alpha = 0.0;
                    customBadge.hidden = YES;
            };
            
            [self callBadgeAnimationProviderDisappearanceAnimationwithBadge:customBadge
                                                             withCompletion:hidingCompletion];
        }
    }
}

#pragma mark private helper method
//
//  initializes the required dictionary strucures
//  required for locating the badge label and their
//  holder view
//
-(void)initializeCustomBadgeLabelDictionariesIfNecessary
{
    if(!customBadgeLabels)
    {
        customBadgeLabels = [[NSMutableDictionary alloc] init];
    }
    else
    {
        if(badgeConfigurationProvider && badgeConfigurationProvider.enableLog)
            NSLog(@"custom badge labels %@", customBadgeLabels);
    }
    
    //
    //  extra feature related initilaization
    //
#ifdef ENABLE_OVERLAPING_FEATURE
    if(!respectiveTabbars)
        respectiveTabbars = [[NSMutableDictionary alloc] init];
#endif
    
}

//
//  initializes an label and assign some property according
//  to the configuration.
//  beware, returned lable's alpha is set 0.0 and it's hidden
//
-(UILabel*)initializeAnBadgeLabelAccordingToMacro
{
    UILabel *customBadge = [[UILabel alloc] initWithFrame:CGRectZero];
    customBadge.textAlignment = NSTextAlignmentCenter;

    [self applyBadgeConfiguration:customBadge];
    
    [customBadge setUserInteractionEnabled:FALSE];
    
    customBadge.clipsToBounds = YES;
    
    customBadge.alpha = 0.0;
    customBadge.hidden = YES;
    return customBadge;
}

//
//  returning the top view inside the tabbar
//
-(UIView*)getCachedTopTabbarView
{
    UIView *tabbarView = respectiveTabbars[[NSString stringWithFormat:@"%u",(unsigned)self.hash]];
    if(tabbarView == nil)
    {
        //  we need to dig for the tabbarview
        UIView *tabbarItemView = (UIView *)[self performSelector:@selector(view)];
        while(tabbarItemView != nil)
        {
            if([tabbarItemView isKindOfClass:[UITabBar class]])
            {
                [respectiveTabbars setObject:tabbarItemView
                                      forKey:[NSString stringWithFormat:@"%u",(unsigned)self.hash]];
                tabbarView = tabbarItemView;
                break;
            }
            tabbarItemView = tabbarItemView.superview;
        }
    }
    
    return tabbarView;
}

//
//  provide the label which denote the custom badge label
//  beware this method could return nil
//  check after the result been recieved
//
-(UILabel*)getCustomBadgeForCurrentTabbarItem
{
    return (customBadgeLabels) ? customBadgeLabels[[NSString stringWithFormat:@"%u",(unsigned)self.hash]] : nil;
}

//
//  calculates the size according to the assigned
//  configuration.
//
-(CGSize)sizingBadgeLabel:(UILabel*)customBadge
  AccordingToMacrosAndMsg:(NSString*)msg
                 InTabbar:(UIView*)tabbarItemView
{
    //
    //  resize according to the size of the text
    //  only changing the height & width of the
    //
    
    CGFloat minHeight = badgeConfigurationProvider ? badgeConfigurationProvider.badgeMinHeight : 0;
    CGFloat topBottomSpacing = badgeConfigurationProvider ? badgeConfigurationProvider.badgeTextTopBottomSpacing : 0;
    CGFloat leftRightSpacing = badgeConfigurationProvider ? badgeConfigurationProvider.badgeTextLeftRightSpacing : 0;
    CGFloat badgeLabelRightSpacing = badgeConfigurationProvider ? badgeConfigurationProvider.badgeLabelRightSpacing : 0;
    
    CGSize maximumSize = CGSizeMake(tabbarItemView.frame.size.width - badgeLabelRightSpacing,
                                    minHeight - 2 * topBottomSpacing);
    NSString *updatedMsg= msg;
    CGRect rect = [updatedMsg boundingRectWithSize:maximumSize
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                        attributes:@{NSFontAttributeName : customBadge.font}
                                           context:nil];
    
    CGFloat height = rect.size.height + 2 * topBottomSpacing;   // space allowance for spacing
    CGFloat width = rect.size.width + 2 * leftRightSpacing;    //  space allowance for spacing
    
    width = MAX(height, width);  //  width must be greater or equal to height
    
    //corner radius is set prior, because of the animation
    customBadge.layer.cornerRadius = MIN(width,
                                         height) / 2;
    return CGSizeMake(width, height);
}

//
//  calculates the badge frame size
//  while the badge calculated size is given and
//  the tabbar view is given
//
-(CGRect)getFrameOfBadgeLabelSize:(CGSize)badgeSize
                         InTabbar:(UIView*)tabbarItemView
{
    //
    //  determining the origin
    //
    CGFloat positionX;
    CGFloat positionY;
#ifdef  ENABLE_OVERLAPING_FEATURE
    UIView *tabbarView = respectiveTabbars[[NSString stringWithFormat:@"%u", (unsigned) self.hash]];
    
    CGPoint offset = [tabbarItemView convertPoint:CGPointZero toView:tabbarView];
    
    if(badgeConfigurationProvider && badgeConfigurationProvider.enableLog)
    {
        NSLog(@"tabbarView (%@)", tabbarView);
        NSLog(@"tabbarItemView (%@)", tabbarItemView);
        NSLog(@"offset (%@)", NSStringFromCGPoint(offset));
    }
    
    positionX = offset.x;
    positionY = offset.y;
#else
    positionX = 0.0;
    positionY = 0.0;
#endif

    CGFloat badgeLableRightSpacing = badgeConfigurationProvider ? badgeConfigurationProvider.badgeLabelRightSpacing : 0;
    CGFloat badgeLabelTopSpacing = badgeConfigurationProvider ? badgeConfigurationProvider.badgeLabelTopSpacing : 0;
    
    positionX = tabbarItemView.frame.size.width - badgeSize.width - badgeLableRightSpacing + positionX;
    positionY = badgeLabelTopSpacing + positionY;
    
    return CGRectMake(positionX,
                      positionY,
                      badgeSize.width,
                      badgeSize.height);
}

//
//  this method helps to apply some basic configuration
//  except sizing and origin.
//
-(void)applyBadgeConfiguration:(UILabel*)customBadge
{
    customBadge.textColor = (badgeConfigurationProvider && badgeConfigurationProvider.badgeTextColor)
    ? badgeConfigurationProvider.badgeTextColor
    : [UIColor blackColor];
    
    customBadge.backgroundColor = (badgeConfigurationProvider && badgeConfigurationProvider.badgeBackgroundColor)
    ? badgeConfigurationProvider.badgeBackgroundColor
    :[UIColor blackColor];
    
    customBadge.layer.borderColor = (badgeConfigurationProvider && badgeConfigurationProvider.badgeBorderColor)
    ? badgeConfigurationProvider.badgeBorderColor.CGColor
    : [UIColor blackColor].CGColor;
    
    customBadge.layer.borderWidth = (badgeConfigurationProvider)
    ? badgeConfigurationProvider.badgeBorderWidth
    : 2.0;
    
    customBadge.font = (badgeConfigurationProvider && badgeConfigurationProvider.badgeFont)
    ? badgeConfigurationProvider.badgeFont
    : [UIFont systemFontOfSize:18];
}

//
//  this method facilitates to call the animation delegate
//
-(void)callBadgeAnimationProviderAppearanceAnimationwithBadge:(UILabel*)badgeLabel
                                                    withValue:(NSString*)msg
                                               withCompletion:(BadgeAnimationCompletionBlock)completion
{
    if(badgeAnimationProvider &&
       [badgeAnimationProvider respondsToSelector:@selector(UITabbarItemBadgeAppearAnimationForBadge:
                                                                 withNewValue: withCompletion:)])
    {
        [badgeAnimationProvider UITabbarItemBadgeAppearAnimationForBadge:badgeLabel withNewValue:msg withCompletion:completion];
    }
    else
    {
        if(badgeConfigurationProvider && badgeConfigurationProvider.enableLog)
            NSLog(@"tabbaritem badge animation provider appear animation not provided");
        
        if(completion)
            completion();
    }
}

//
//  this method facilitates to call the animation delegate
//
-(void)callBadgeAnimationProviderDisappearanceAnimationwithBadge:(UILabel*)badgeLabel
                                                  withCompletion:(BadgeAnimationCompletionBlock)completion
{
    if(badgeAnimationProvider &&
       [badgeAnimationProvider respondsToSelector:@selector(UITabbarItemBadgeDisappearAnimationForBadge:withCompletion:)])
    {
        [badgeAnimationProvider UITabbarItemBadgeDisappearAnimationForBadge:badgeLabel withCompletion:completion];
    }
    else
    {
        if(badgeConfigurationProvider && badgeConfigurationProvider.enableLog)
            NSLog(@"tabbaritem badge animation provider disappear animation not provided");
        
        if(completion)
            completion();
    }
}



@end
