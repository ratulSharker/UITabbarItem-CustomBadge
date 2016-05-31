//
//  UITabBarItem+CustomBadge.m
//  UITabbar+CustomBadge
//
//  Created by Ratul Sharker on 5/31/16.
//

#import "UITabBarItem+CustomBadge.h"

#define TOP_BOTTOM_PADDING  2
#define LEFT_RIGHT_PADDING  4
#define DEFAULT_HEIGHT      18
#define DEFAULT_FONT_SIZE   10

#define Y_POSITION_MARGIN   -5


NSString *CONST = @"ABC";

@implementation UITabBarItem (CustomBadge)

NSMutableDictionary *customBadgeLabels;
//
//  overriding the getter of the badge value
//

-(NSString*)badgeValue
{
    UILabel *customBadge = (customBadgeLabels) ? customBadgeLabels[[NSString stringWithFormat:@"%ld", self.hash]] : nil;
    return (customBadge != nil) ? customBadge.text : @"";
}

//
//  overriding the setter of the badge value
//
-(void) setBadgeValue:(NSString *)value
{
    @synchronized (CONST) {
        
        //  initialized only once
        if(!customBadgeLabels)
            customBadgeLabels = [[NSMutableDictionary alloc] init];
        else
        {
            //NSLog(@"custom badge labels %@", customBadgeLabels);
        }
        
        //  getting the tabbar & particular customBadge
        UIView *sv = (UIView *)[self performSelector:@selector(view)];
        
        UILabel *customBadge = (customBadgeLabels) ? customBadgeLabels[[NSString stringWithFormat:@"%ld", self.hash]] : nil;
        
        if(customBadge == nil)
        {
            //initialize it with necessary params
            customBadge = [[UILabel alloc] initWithFrame:CGRectZero];
            customBadge.textAlignment = NSTextAlignmentCenter;
            customBadge.textColor = [UIColor whiteColor];
            customBadge.backgroundColor = [UIColor purpleColor];
            [customBadge setUserInteractionEnabled:FALSE];
            customBadge.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE];
            customBadge.clipsToBounds = YES;
            
            [customBadgeLabels setObject:customBadge
                                  forKey:[NSString stringWithFormat:@"%ld", self.hash]];
            
            [sv addSubview:customBadge];
            
            //
            //
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
            [UIView animateWithDuration:0.5
                             animations:^{
                                 customBadge.alpha = 1.0;
                             }];
            
            
            [UIView transitionWithView:customBadge duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                customBadge.text = value;
            } completion:nil];
            
            
            
            
            //resize according to the size of the text
            CGSize maximumSize = CGSizeMake(sv.frame.size.width, DEFAULT_HEIGHT - 2 * TOP_BOTTOM_PADDING);
            NSString *updatedMsg= value;
            
            CGRect rect = [updatedMsg boundingRectWithSize:maximumSize
                                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                attributes:@{NSFontAttributeName : customBadge.font}
                                                   context:nil];
            
            double width = rect.size.width + 2 * LEFT_RIGHT_PADDING;    //  space allowance for padding
            width = (width < DEFAULT_HEIGHT) ? DEFAULT_HEIGHT : width;  //  width must be greater or equal to height
            
            //corner radius is set prior, because of the animation
            customBadge.layer.cornerRadius = MIN(width,
                                                 DEFAULT_HEIGHT) / 2;
            
            customBadge.frame = CGRectMake(sv.frame.size.width - width - LEFT_RIGHT_PADDING,
                                           Y_POSITION_MARGIN,
                                           width,
                                           DEFAULT_HEIGHT);
        }
        else
        {
            
            [UIView animateWithDuration:0.5 animations:^{
                customBadge.alpha = 0.0;
            } completion:^(BOOL finished) {
                customBadge.hidden = YES;
            }];
            customBadge.text = @"";
        }
    }
}




@end
