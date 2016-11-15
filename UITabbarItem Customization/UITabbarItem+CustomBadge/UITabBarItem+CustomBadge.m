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

#pragma mark public class method
+(void)setDefaultAnimationProvider:(id<UITabbarItemBadgeAnimation>) animationProvider
{
    badgeAnimationProvider = animationProvider;
}

//
//  overriding the getter of the badge value
//
-(NSString*)badgeValue
{
    UILabel *customBadge = (customBadgeLabels) ? customBadgeLabels[[NSString stringWithFormat:@"%u",(unsigned)self.hash]] : nil;
    return (customBadge != nil) ? customBadge.text : @"";
}




//
//  overriding the setter of the badge value
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
-(void)initializeCustomBadgeLabelDictionariesIfNecessary
{
    if(!customBadgeLabels)
    {
        customBadgeLabels = [[NSMutableDictionary alloc] init];
    }
    else
    {
        
#ifdef UITABBAR_CUSTOMBADGE_ENABLE_LOG
        NSLog(@"custom badge labels %@", customBadgeLabels);
#endif
    }
    
    //
    //  extra feature related initilaization
    //
#ifdef ENABLE_OVERLAPING_FEATURE
    if(!respectiveTabbars)
        respectiveTabbars = [[NSMutableDictionary alloc] init];
#endif
    
}

-(UILabel*)initializeAnBadgeLabelAccordingToMacro
{
    UILabel *customBadge = [[UILabel alloc] initWithFrame:CGRectZero];
    customBadge.textAlignment = NSTextAlignmentCenter;
    customBadge.textColor = UITABBAR_CUSTOMBADGE_TEXT_COLOR;
    customBadge.backgroundColor = UITABBAR_CUSTOMBADGE_BACKGROUND_COLOR;
    [customBadge setUserInteractionEnabled:FALSE];
    customBadge.font = UITABBAR_CUSTOMBADGE_TEXT_FONT;
    customBadge.clipsToBounds = YES;
    customBadge.layer.borderWidth = UITABBAR_CUSTOMBADGE_BORDER_WIDTH;
    customBadge.layer.borderColor = UITABBAR_CUSTOMBADGE_BORDER_COLOR.CGColor;
    customBadge.alpha = 0.0;
    customBadge.hidden = YES;
    return customBadge;
}
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

-(CGSize)sizingBadgeLabel:(UILabel*)customBadge AccordingToMacrosAndMsg:(NSString*)msg InTabbar:(UIView*)tabbarItemView
{
    //
    //  resize according to the size of the text
    //  only changing the height & width of the
    //
    CGSize maximumSize = CGSizeMake(tabbarItemView.frame.size.width,
                                    UITABBAR_CUSTOMBADGE_HEIGHT - 2 * UITABBAR_CUSTOMBADGE_TOP_BOTTOM_PADDING);
    NSString *updatedMsg= msg;
    CGRect rect = [updatedMsg boundingRectWithSize:maximumSize
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                        attributes:@{NSFontAttributeName : customBadge.font}
                                           context:nil];
    
    double width = rect.size.width + 2 * UITABBAR_CUSTOMBADGE_LEFT_RIGHT_PADDING;    //  space allowance for padding
    width = (width < UITABBAR_CUSTOMBADGE_HEIGHT) ? UITABBAR_CUSTOMBADGE_HEIGHT : width;  //  width must be greater or equal to height
    
    //corner radius is set prior, because of the animation
    customBadge.layer.cornerRadius = MIN(width,
                                         UITABBAR_CUSTOMBADGE_HEIGHT) / 2;
    
    return CGSizeMake(width, UITABBAR_CUSTOMBADGE_HEIGHT);
}

-(CGRect)getFrameOfBadgeLabelSize:(CGSize)badgeSize InTabbar:(UIView*)tabbarItemView
{
    //
    //  determining the origin
    //
    CGFloat positionX;
    CGFloat positionY;
#ifdef  ENABLE_OVERLAPING_FEATURE
    UIView *tabbarView = respectiveTabbars[[NSString stringWithFormat:@"%u", (unsigned) self.hash]];
    
    CGPoint offset = [tabbarItemView convertPoint:CGPointZero toView:tabbarView];
    
#ifdef UITABBAR_CUSTOMBADGE_ENABLE_LOG
    NSLog(@"tabbarView (%@)", tabbarView);
    NSLog(@"tabbarItemView (%@)", tabbarItemView);
    NSLog(@"offset (%@)", NSStringFromCGPoint(offset));
#endif
    
    positionX = offset.x;
    positionY = offset.y;
#else
    positionX = 0.0;
    positionY = 0.0;
#endif

    positionX = tabbarItemView.frame.size.width - badgeSize.width - UITABBAR_CUSTOMBADGE_LEFT_RIGHT_PADDING - UITABBAR_CUSTOMBADGE_RIGHT_MARGIN + positionX;
    positionY = UITABBAR_CUSTOMBADGE_Y_POSITION_MARGIN + positionY;
    
    return CGRectMake(positionX,
                      positionY,
                      badgeSize.width,
                      badgeSize.height);
}

-(void)callBadgeAnimationProviderAppearanceAnimationwithBadge:(UILabel*)badgeLabel withValue:(NSString*)msg withCompletion:(BadgeAnimationCompletionBlock)completion
{
    if(badgeAnimationProvider &&
       [badgeAnimationProvider respondsToSelector:@selector(UITabbarItemBadgeAppearAnimationForBadge:
                                                                 withNewValue: withCompletion:)])
    {
        [badgeAnimationProvider UITabbarItemBadgeAppearAnimationForBadge:badgeLabel withNewValue:msg withCompletion:completion];
    }
    else
    {
#ifdef UITABBAR_CUSTOMBADGE_ENABLE_LOG
        NSLog(@"tabbaritem badge animation provider appear animation not provided");
#endif
        if(completion)
            completion();
    }
}

-(void)callBadgeAnimationProviderDisappearanceAnimationwithBadge:(UILabel*)badgeLabel withCompletion:(BadgeAnimationCompletionBlock)completion
{
    if(badgeAnimationProvider &&
       [badgeAnimationProvider respondsToSelector:@selector(UITabbarItemBadgeDisappearAnimationForBadge:withCompletion:)])
    {
        [badgeAnimationProvider UITabbarItemBadgeDisappearAnimationForBadge:badgeLabel withCompletion:completion];
    }
    else
    {
#ifdef UITABBAR_CUSTOMBADGE_ENABLE_LOG
        NSLog(@"tabbaritem badge animation provider disappear animation not provided");
#endif
        
        if(completion)
            completion();
    }
}



@end
