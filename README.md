<img src='https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/demo/banner_logo.png' align='center'>
<br/>
<br/>
<br/>
<br/>
[![codebeat badge](https://codebeat.co/badges/9c717038-9cae-4a08-b9b7-a8258cc4f4d1)](https://codebeat.co/projects/github-com-ratulsharker-uitabbaritem-custombadge)
[![Build Status](https://travis-ci.org/ratulSharker/UITabbarItem-CustomBadge.svg?branch=master)](https://travis-ci.org/ratulSharker/UITabbarItem-CustomBadge)
[![Cocoapod](https://img.shields.io/badge/pod-2.0.2-red.svg)](https://cocoapods.org/?q=UITabbarItem-Custombadge)
[![Platform](https://img.shields.io/badge/platform-ios-green.svg)](https://en.wikipedia.org/wiki/IOS)
[![License](https://img.shields.io/github/license/mashape/apistatus.svg)](https://opensource.org/licenses/MIT)

##Demo
<img src='https://github.com/ratulSharker/Gif-Demonstration/blob/master/UITabbarItem%2BCustomBadge/UITabbarItem%2BCustomBadge-demo.gif'/>

##Background
There is no public api from [Apple](https://developer.apple.com/). But it's not impossible to cusotmize the 
[UITabbarItem](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITabBarItem_Class/) badge 
with [UILabel](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UILabel_Class/). I've been inspired by **enryold**'s [repository](https://github.com/enryold/UITabBarItem-CustomBadge).
I think this could be done in a better way, by overriding the `-(void)setBadgeValue:(NSString*)value` & the `-(NSString*)badgeValue`. In this way an existing project doesn't need to 
change the badge value settings related function calls. This is how the whole thing is maintained.

This project is under the MIT Liecense, feel free to use this code base under compilance.

##Installation
###Using Cocoapod
```ruby
pod 'UITabbarItem-CustomBadge'
```

###Manual 
Installation of `UITabbarItem+CustomBadge` is easy, just add [UITabbarItem+CustomBadge](https://github.com/ratulSharker/UITabbarItem-CustomBadge/tree/master/Example/UITabbarItem%2BCustomBadge) category in your xcode project. Change the content of this category to meet your requiremnt and you're good to go.

Installation of `UITabbarItem+CustomBadge` is easy, include following files in your project
 + [UITabbarItemAnimation.h](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%20Customization/UITabbarItem%2BCustomBadge/UITabbarItemAnimation.h)
 + [UITabbarItemBadgeConfiguration.h](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%20Customization/UITabbarItem%2BCustomBadge/UITabbarItemBadgeConfiguration.h)
 + [UITabBarItem+CustomBadge.h](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%20Customization/UITabbarItem%2BCustomBadge/UITabBarItem%2BCustomBadge.h)
 + [UITabBarItem+CustomBadge.m](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%20Customization/UITabbarItem%2BCustomBadge/UITabBarItem%2BCustomBadge.m)
 + [DefaultTabbarBadgeAnimation.h](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%20Customization/UITabbarItem%2BCustomBadge/DefaultTabbarBadgeAnimation.h)
 + [DefaultTabbarBadgeAnimation.m](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%20Customization/UITabbarItem%2BCustomBadge/DefaultTabbarBadgeAnimation.m)
 + [DefaultTabbarBadgeFlipAnimation.h](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%2BCustomBadge/DefaultTabbarBadgeFlipAnimation.h)
 + [DefaultTabbarBadgeFlipAnimation.m](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%2BCustomBadge/DefaultTabbarBadgeFlipAnimation.m)
 + [DefaultTabbarBadgeScaleAnimation.h](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%2BCustomBadge/DefaultTabbarBadgeScaleAnimation.h)
 + [DefaultTabbarBadgeScaleAnimation.m](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%2BCustomBadge/DefaultTabbarBadgeScaleAnimation.m)
 + [DefaultSystemLikeBadgeConfiguration.h](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%20Customization/UITabbarItem%2BCustomBadge/DefaultSystemLikeBadgeConfiguration.h)
 + [DefaultSystemLikeBadgeConfiguration.m](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%20Customization/UITabbarItem%2BCustomBadge/DefaultSystemLikeBadgeConfiguration.m)

###Initializing
Now initilaize custom badge in your project's `AppDelegate`'s `didFinishLaunchingwithOptions...` as follows

```obj-c
//other imports...
#import "UITabbarItem+CustomBadge.h"
#import "DefaultTabbarBadgeAnimation.h"
#import "DefaultSystemLikeBadgeConfiguration.h"


...
...
...
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
      //supplying the animation parameter
      [UITabBarItem setDefaultAnimationProvider:[[DefaultTabbarBadgeAnimation alloc] init]];
      [UITabBarItem setDefaultConfigurationProvider:[[DefaultSystemLikeBadgeConfiguration alloc] init]];
            
      //rest of your code goes following...
            
      return YES;
}
```

##Advance Customization
###Customizing the badge appearance
To change a new appearance for the badge, create a new class extending `NSObject` conforming the protocol [UITabbarItemBadgeConfiguration.h](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%20Customization/UITabbarItem%2BCustomBadge/UITabbarItemBadgeConfiguration.h). Declare all the properties which are in the protocol. In the implementation file set your appropriate values to meet your requirement. Then to use this configuration implementation set as follows :

```obj-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
      //
      // here assumed that the MyOwnConfiguration is the class that you made for configuration
      //
      //supplying the animation parameter
      [UITabBarItem setDefaultAnimationProvider:[[DefaultTabbarBadgeAnimation alloc] init]];
      [UITabBarItem setDefaultConfigurationProvider:[[MyOwnConfiguration alloc] init]];
            
      //rest of your code goes following...
            
      return YES;
}
```

###Customizing the animation style
In order to provide your own animation, declare a new class extends from `NSObject` which conforms to the protocol [UITabbarItemAnimation.h](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%20Customization/UITabbarItem%2BCustomBadge/UITabbarItemAnimation.h). Implement two methods of the protocol. Then to use this configuration implementation set as follows :
```obj-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
      //
      // here assumed that the MyOwnAnimationProvider is the class that you made for configuration
      //
      //supplying the animation parameter
      [UITabBarItem setDefaultAnimationProvider:[[MyOwnAnimationProvider alloc] init]];
      [UITabBarItem setDefaultConfigurationProvider:[[DefaultSystemLikeBadgeConfiguration alloc] init]];
            
      //rest of your code goes following...
            
      return YES;
}
```

Feel free to file an issue if there any.


##Change log 2.0.2
1. Two new animation class are added as the default animation class.
2. Example project updated to show demonstration of custom animation classes.
3. Two new animation uses `UIViewAnimationOptionAllowUserInteraction` which is available ios8.0+ so the project min sdk version changes to ios8.0, if you want to support lower version of SDK please ignore these two animation classes.
4. Project builded with xcode8.2.1 .
