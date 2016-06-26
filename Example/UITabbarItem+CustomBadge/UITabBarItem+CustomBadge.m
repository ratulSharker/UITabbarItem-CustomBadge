//
//  UITabBarItem+CustomBadge.m
//  UITabbar+CustomBadge
//
//  Created by Ratul Sharker on 5/31/16.
//

#import "UITabBarItem+CustomBadge.h"
#import "AppDelegate.h"



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


//
//  overriding the getter of the badge value
//
-(NSString*)badgeValue
{
    UILabel *customBadge = (customBadgeLabels) ? customBadgeLabels[[NSString stringWithFormat:@"%u", self.hash]] : nil;
    return (customBadge != nil) ? customBadge.text : @"";
}



//
//  overriding the setter of the badge value
//
-(void) setBadgeValue:(NSString *)value
{
    @synchronized (UITabbarCustomBadgeConst) {
        
        //  initialized only once
        if(!customBadgeLabels)
            customBadgeLabels = [[NSMutableDictionary alloc] init];
        else
        {
            //NSLog(@"custom badge labels %@", customBadgeLabels);
        }
        
#ifdef ENABLE_OVERLAPING_FEATURE
        if(!respectiveTabbars)
            respectiveTabbars = [[NSMutableDictionary alloc] init];
#endif
        
        //  getting the tabbar & particular customBadge
        UILabel *customBadge = (customBadgeLabels) ? customBadgeLabels[[NSString stringWithFormat:@"%u", self.hash]] : nil;
        
        if(customBadge == nil)
        {
            //initialize it with necessary params
            customBadge = [[UILabel alloc] initWithFrame:CGRectZero];
            customBadge.textAlignment = NSTextAlignmentCenter;
            customBadge.textColor = UITABBAR_CUSTOMBADGE_TEXT_COLOR;
            customBadge.backgroundColor = UITABBAR_CUSTOMBADGE_BACKGROUND_COLOR;
            [customBadge setUserInteractionEnabled:FALSE];
            customBadge.font = UITABBAR_CUSTOMBADGE_TEXT_FONT;
            customBadge.clipsToBounds = YES;
            customBadge.layer.borderWidth = UITABBAR_CUSTOMBADGE_BORDER_WIDTH;
            customBadge.layer.borderColor = UITABBAR_CUSTOMBADGE_BORDER_COLOR.CGColor;
            
            [customBadgeLabels setObject:customBadge
                                  forKey:[NSString stringWithFormat:@"%u", self.hash]];
            
#ifdef ENABLE_OVERLAPING_FEATURE
            
            UIView *tabbarView = respectiveTabbars[[NSString stringWithFormat:@"%u", self.hash]];
            if(tabbarView == nil)
            {
                //  we need to dig for the tabbarview
                UIView *tabbarItemView = (UIView *)[self performSelector:@selector(view)];
                while(tabbarItemView != nil)
                {
                    if([tabbarItemView isKindOfClass:[UITabBar class]])
                    {
                        [respectiveTabbars setObject:tabbarItemView
                                              forKey:[NSString stringWithFormat:@"%u", self.hash]];
                        tabbarView = tabbarItemView;
                        break;
                    }
                    tabbarItemView = tabbarItemView.superview;
                }
            }
            
            //
            //  now we can say that, tabbarView is cached
            //
            [tabbarView addSubview:customBadge];
#else
            
            //
            //  we want our customBadge inside the
            //  UITabbarItem
            //
            UIView *tabbarItemView = (UIView *)[self performSelector:@selector(view)];
            [tabbarItemView addSubView:customBadge];
#endif
            //
            //  SET INITIAL PARAM -- NECESSARY FOR THE FADE IN-OUT ANIMATION
            //
            customBadge.alpha = 0.0;
            customBadge.hidden = YES;
            
        }
        
        //
        //  now check on the value
        //
        if(value)
        {
            //
            //  make cusotmBadge visible
            //  set its frame
            //  set the text value
            
            customBadge.hidden = NO;
            [UIView animateWithDuration:UITABBAR_CUSTOMBADGE_TEXT_TRANSITION_DURATION
                             animations:^{
                                 customBadge.alpha = 1.0;
                             }];
            
            
            [UIView transitionWithView:customBadge
                              duration:UITABBAR_CUSTOMBADGE_SHOW_HIDE_FADE_ANIMATION_DURATION
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                customBadge.text = value;
                            } completion:nil];
            
            
            UIView *tabbarItemView = [(UIView*)self performSelector:@selector(view)];
            
            
            //resize according to the size of the text
            CGSize maximumSize = CGSizeMake(tabbarItemView.frame.size.width,
                                            UITABBAR_CUSTOMBADGE_HEIGHT - 2 * UITABBAR_CUSTOMBADGE_TOP_BOTTOM_PADDING);
            NSString *updatedMsg= value;
            
            CGRect rect = [updatedMsg boundingRectWithSize:maximumSize
                                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                attributes:@{NSFontAttributeName : customBadge.font}
                                                   context:nil];
            
            double width = rect.size.width + 2 * UITABBAR_CUSTOMBADGE_LEFT_RIGHT_PADDING;    //  space allowance for padding
            width = (width < UITABBAR_CUSTOMBADGE_HEIGHT) ? UITABBAR_CUSTOMBADGE_HEIGHT : width;  //  width must be greater or equal to height
            
            //corner radius is set prior, because of the animation
            customBadge.layer.cornerRadius = MIN(width,
                                                 UITABBAR_CUSTOMBADGE_HEIGHT) / 2;

            
            CGFloat positionX;
            CGFloat positionY;
#ifdef  ENABLE_OVERLAPING_FEATURE
            UIView *tabbarView = respectiveTabbars[[NSString stringWithFormat:@"%u", self.hash]];
            
            CGPoint offset = [tabbarItemView convertPoint:CGPointZero toView:tabbarView];
            
            NSLog(@"tabbarView (%@)", tabbarView);
            NSLog(@"tabbarItemView (%@)", tabbarItemView);
            NSLog(@"offset (%@)", NSStringFromCGPoint(offset));
            
            positionX = offset.x;
            positionY = offset.y;
#else
            positionX = 0.0;
            positionY = 0.0;
#endif
            customBadge.frame = CGRectMake(tabbarItemView.frame.size.width - width - UITABBAR_CUSTOMBADGE_LEFT_RIGHT_PADDING - UITABBAR_CUSTOMBADGE_RIGHT_MARGIN + positionX,
                                           UITABBAR_CUSTOMBADGE_Y_POSITION_MARGIN + positionY,
                                           width,
                                           UITABBAR_CUSTOMBADGE_HEIGHT);
            
            
            
            
        }
        else
        {
            [UIView animateWithDuration:UITABBAR_CUSTOMBADGE_SHOW_HIDE_FADE_ANIMATION_DURATION
                             animations:^{
                                 customBadge.alpha = 0.0;
                             } completion:^(BOOL finished) {
                                 customBadge.hidden = YES;
                             }];
            customBadge.text = @"";
        }
    }
}

@end
