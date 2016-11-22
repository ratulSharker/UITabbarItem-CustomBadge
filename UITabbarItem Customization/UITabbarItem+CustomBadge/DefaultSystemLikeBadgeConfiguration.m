//
//  DefaultSystemLikeBadgeConfiguration.m
//  UITabBarItem+CustomBadge
//
//  Created by Ratul Sharker on 11/20/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "DefaultSystemLikeBadgeConfiguration.h"


@implementation DefaultSystemLikeBadgeConfiguration

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        //  initialize the configuration here
        [self initializeConfiguration];
    }
    
    return self;
}

#pragma mark private helper
-(void)initializeConfiguration
{
    _enableLog = NO;
    
    _badgeBackgroundColor = [UIColor redColor];
    _badgeTextColor = [UIColor whiteColor];
    _badgeBorderColor = [UIColor greenColor];
    
    _badgeBorderWidth = 0.0;
    
    _badgeFont = [UIFont systemFontOfSize:10];
    
    _badgeTextTopBottomSpacing = 3;
    _badgeTextLeftRightSpacing = 3;
    _badgeMinHeight = 18;
    
    _badgeLabelTopSpacing = 0;
    _badgeLabelRightSpacing = 0;
}
@end
