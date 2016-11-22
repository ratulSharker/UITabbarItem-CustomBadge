<img src='https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/demo/banner_logo.png' align='center'>
<br/>
<br/>
<br/>
<br/>
[![codebeat badge](https://codebeat.co/badges/9c717038-9cae-4a08-b9b7-a8258cc4f4d1)](https://codebeat.co/projects/github-com-ratulsharker-uitabbaritem-custombadge)
[![Build Status](https://travis-ci.org/ratulSharker/UITabbarItem-CustomBadge.svg?branch=master)](https://travis-ci.org/ratulSharker/UITabbarItem-CustomBadge)

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
Installation of `UITabbarItem+CustomBadge` is easy, just add [UITabbarItem+CustomBadge](https://github.com/ratulSharker/UITabbarItem-CustomBadge/tree/master/Example/UITabbarItem%2BCustomBadge) category in your xcode project. Change the content of this category to meet your requiremnt and you're good to go.

Installation of `UITabbarItem+CustomBadge` is easy, include following files in your project
 + [UITabbarItemAnimation.h](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%20Customization/UITabbarItem%2BCustomBadge/UITabbarItemAnimation.h)
 + [UITabbarItemBadgeConfiguration.h](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%20Customization/UITabbarItem%2BCustomBadge/UITabbarItemBadgeConfiguration.h)
 + [UITabBarItem+CustomBadge.h](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%20Customization/UITabbarItem%2BCustomBadge/UITabBarItem%2BCustomBadge.h)
 + [UITabBarItem+CustomBadge.m](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%20Customization/UITabbarItem%2BCustomBadge/UITabBarItem%2BCustomBadge.m)
 + [DefaultTabbarBadgeAnimation.h](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%20Customization/UITabbarItem%2BCustomBadge/DefaultTabbarBadgeAnimation.h)
 + [DefaultTabbarBadgeAnimation.m](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%20Customization/UITabbarItem%2BCustomBadge/DefaultTabbarBadgeAnimation.m)
 + [DefaultSystemLikeBadgeConfiguration.h](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%20Customization/UITabbarItem%2BCustomBadge/DefaultSystemLikeBadgeConfiguration.h)
 + [DefaultSystemLikeBadgeConfiguration.m](https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/UITabbarItem%20Customization/UITabbarItem%2BCustomBadge/DefaultSystemLikeBadgeConfiguration.m)

Now in your project's `AppDelegate`'s `didFinishLaunchingwithOptions...` as follows

```obj-c
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
