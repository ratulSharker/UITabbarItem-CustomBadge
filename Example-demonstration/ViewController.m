//
//  FirstViewController.m
//  UITabbar+CustomBadge
//
//  Created by Ratul Sharker on 5/31/16.
//

#import "ViewController.h"
#import "UITabBarItem+CustomBadge.h"
#import "InputFieldCell.h"
#import "AppDelegate.h"

#import "DefaultTabbarBadgeAnimation.h"
#import "DefaultTabbarBadgeScaleAnimation.h"
#import "DefaultTabbarBadgeFlipAnimation.h"


#define PLACEHOLDER_TEXT_KEY    @"placeholder.key"
#define INPUT_TEXT_KEY          @"input.text.key"
#define SELECTOR_KEY            @"selector.key"

@interface ViewController () <  UITableViewDataSource,
                                InputFieldCellDelegate,
                                UIAlertViewDelegate>
{
    NSArray <NSMutableDictionary*> *arrayData;
    AppDelegate *appDelegate;
    
    UIAlertView *keyboardAlert,
                *animationChangeAlert;
    
    NSArray *animationStyleObjects;
}
@end

@implementation ViewController
{
    id<UITabbarItemBadgeConfiguration> badgeConfiguration;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    badgeConfiguration = [UITabBarItem getDefaultConfigurationProvider];
    [self loadMutableDataFromPlist];
    
    appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    animationStyleObjects = @[
                              [DefaultTabbarBadgeAnimation new],
                              [DefaultTabbarBadgeScaleAnimation new],
                              [[DefaultTabbarBadgeFlipAnimation alloc] initWithFlipDirection:HORIZONTAL_FLIP],
                              [[DefaultTabbarBadgeFlipAnimation alloc] initWithFlipDirection:VERTICAL_FLIP]
                              ];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(appDelegate.amIUnderstood == NO)
    {
        keyboardAlert = [[UIAlertView alloc] initWithTitle:@"Do You understand ?"
                                                   message:@"Run the Application in simulator and check the option \"Hardware > Keyboard > Connect Hardware Keyboard\""
                                                  delegate:self
                                         cancelButtonTitle:@"NO"
                                         otherButtonTitles:@"YES", nil];
        [keyboardAlert show];
    }
}

#pragma mark IBActions
- (IBAction)onAnimationStyleChange:(id)sender
{
    animationChangeAlert = [[UIAlertView alloc] initWithTitle:@"Choose animation style"
                                                      message:@"Define how your badge animation will be"
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:  @"Default",
                                                                @"Pop",
                                                                @"Horizontal Flip",
                                                                @"Vertical Flip", nil];
    
    [animationChangeAlert show];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  arrayData ? arrayData.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InputFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    
    NSDictionary *datas = arrayData[indexPath.row];
    
    [cell setIndexPath:indexPath];
    cell.delegate = self;
    
    [cell setTextValue:datas[INPUT_TEXT_KEY]];
    [cell setPlaceholderText:datas[PLACEHOLDER_TEXT_KEY]];
    
    return cell;
}



#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView == keyboardAlert)
    {
        if(buttonIndex == alertView.cancelButtonIndex)
        {
            //  user cancel's it, so we will show it in future
            appDelegate.amIUnderstood = NO;
        }
        else
        {
            //  user understands the consequences so leave him alone to play
            appDelegate.amIUnderstood = YES;
        }
    }
    else
    {
        if(alertView.cancelButtonIndex != buttonIndex)
        {
            //button pressed which is not cancel button
            id<UITabbarItemBadgeAnimation> animationObj = animationStyleObjects[buttonIndex - 1];
            [UITabBarItem setDefaultAnimationProvider:animationObj];
        }
    }
}


#pragma mark InputFieldCellDelegate
-(void)inputFieldTextInputted:(NSString*) text forIndexPath:(NSIndexPath*)indexPath
{
    NSMutableDictionary *data = arrayData[indexPath.row];
    data[INPUT_TEXT_KEY] = text;
    
    SEL designatedSelector = NSSelectorFromString(data[SELECTOR_KEY]);
    if([self respondsToSelector:designatedSelector])
    {
        [self performSelector:designatedSelector withObject:text];
    }
}


#pragma mark selector's implementation
-(void)badgeValueSettings:(NSString*)text
{
    if(text.length)
        self.tabBarItem.badgeValue = text;
    else
        self.tabBarItem.badgeValue = nil;
}

-(void)badgeBackgroundColorSettings:(NSString*)text
{
    UIColor *bgColor = [self colorExtractorFromText:text];
    if(bgColor)
    {
        badgeConfiguration.badgeBackgroundColor = bgColor;
        [self reloadCustomBadgeConfiguration];
    }
}

-(void)badgeTextColorSettings:(NSString*)text
{
    UIColor *textColor = [self colorExtractorFromText:text];
    
    if(textColor)
    {
        badgeConfiguration.badgeTextColor = textColor;
        [self reloadCustomBadgeConfiguration];
    }
}

-(void)badgeBorderColorSettings:(NSString*)text
{
    UIColor *borderColor = [self colorExtractorFromText:text];
    
    if(borderColor)
    {
        badgeConfiguration.badgeBorderColor = borderColor;
        [self reloadCustomBadgeConfiguration];
    }
}

-(void)badgeBorderWidthSettings:(NSString*)text
{
    CGFloat borderWidth = text.floatValue;
    
    if(borderWidth >= 0)
    {
        badgeConfiguration.badgeBorderWidth = borderWidth;
        [self reloadCustomBadgeConfiguration];
    }
}

-(void)badgeFontSizeSettings:(NSString*)text
{
    CGFloat fontSize = text.floatValue;
    
    if(fontSize > 0.0)
    {
        UIFont *synthesizedFont = [UIFont systemFontOfSize:fontSize];
        badgeConfiguration.badgeFont = synthesizedFont;
        
        [self reloadCustomBadgeConfiguration];
    }
}

-(void)badgeTextTopBottomSettings:(NSString*)text
{
    CGFloat textTopBottomSpacing = text.floatValue;
    
    if(textTopBottomSpacing >= 0)
    {
        badgeConfiguration.badgeTextTopBottomSpacing = textTopBottomSpacing;
        [self reloadCustomBadgeConfiguration];
    }
}

-(void)badgeTextLeftRightSettings:(NSString*)text
{
    CGFloat textLeftRightSpacing = text.floatValue;
    
    if(textLeftRightSpacing >= 0)
    {
        badgeConfiguration.badgeTextLeftRightSpacing = textLeftRightSpacing;
        [self reloadCustomBadgeConfiguration];
    }
}

-(void)badgeLabelTopSpacing:(NSString*)text
{
    CGFloat labelTopSpacing = text.floatValue;
    
    badgeConfiguration.badgeLabelTopSpacing = labelTopSpacing;
    [self reloadCustomBadgeConfiguration];
}

-(void)badgeLabelRightSpacing:(NSString*)text
{
    CGFloat labelRightSpacing = text.floatValue;
    
    badgeConfiguration.badgeLabelRightSpacing = labelRightSpacing;
    [self reloadCustomBadgeConfiguration];
}



#pragma mark private helper method
-(UIColor *)colorExtractorFromText:(NSString*)text
{
    text = [NSString stringWithFormat:@"%@Color", text.lowercaseString];
    
    SEL colorSelector = NSSelectorFromString(text);
    
    if([UIColor respondsToSelector:colorSelector])
    {
        return [UIColor performSelector:colorSelector];
    }
    else
    {
        return nil;
    }
}

-(void)reloadCustomBadgeConfiguration
{
    for(UITabBarItem *item in self.tabBarController.tabBar.items)
    {
        [item reloadBadgeConfiguration];
    }
}

-(void)loadMutableDataFromPlist
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSArray<NSDictionary*> * immutableData = [NSArray arrayWithContentsOfFile:plistPath];
    
    NSMutableArray<NSMutableDictionary*> *synthesizedData = [[NSMutableArray alloc] init];
    for(NSDictionary *data in immutableData)
    {
        [synthesizedData addObject:[NSMutableDictionary dictionaryWithDictionary:data]];
    }
    
    arrayData = [NSArray arrayWithArray:synthesizedData];
}

@end
