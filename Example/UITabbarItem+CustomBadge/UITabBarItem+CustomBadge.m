//
//  UITabBarItem+CustomBadge.m
//  UITabbar+CustomBadge
//
//  Created by Ratul Sharker on 5/31/16.
//

#import "UITabBarItem+CustomBadge.h"

//
//  SIZING RELATED MACROS
//
#define UITABBAR_CUSTOMBADGE_TOP_BOTTOM_PADDING  2
#define UITABBAR_CUSTOMBADGE_LEFT_RIGHT_PADDING  4
#define UITABBAR_CUSTOMBADGE_HEIGHT             18
#define UITABBAR_CUSTOMBADGE_Y_POSITION_MARGIN  -5
#define UITABBAR_CUSTOMBADGE_BORDER_WIDTH       0.75

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



@implementation UITabBarItem (CustomBadge)

static NSString *UITabbarCustomBadgeConst = @"UITABBAR_CUSTOMBADGE_CONST";

NSMutableDictionary *customBadgeLabels;


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
        
        //  getting the tabbar & particular customBadge
        UIView *sv = (UIView *)[self performSelector:@selector(view)];
        
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
            
            [sv addSubview:customBadge];
            
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
            
            
            
            
            //resize according to the size of the text
            CGSize maximumSize = CGSizeMake(sv.frame.size.width, UITABBAR_CUSTOMBADGE_HEIGHT - 2 * UITABBAR_CUSTOMBADGE_TOP_BOTTOM_PADDING);
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
            
            customBadge.frame = CGRectMake(sv.frame.size.width - width - UITABBAR_CUSTOMBADGE_LEFT_RIGHT_PADDING,
                                           UITABBAR_CUSTOMBADGE_Y_POSITION_MARGIN,
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
