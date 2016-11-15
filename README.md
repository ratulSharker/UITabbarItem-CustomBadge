<img src='https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/master/demo/banner_logo.png' align='center'>
<br/>
<br/>
<br/>
<br/>
[![codebeat badge](https://codebeat.co/badges/9c717038-9cae-4a08-b9b7-a8258cc4f4d1)](https://codebeat.co/projects/github-com-ratulsharker-uitabbaritem-custombadge)

##Background
There is no public api from [Apple](https://developer.apple.com/). But it's not impossible to cusotmize the 
[UITabbarItem](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITabBarItem_Class/) badge 
with [UILabel](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UILabel_Class/). I've been inspired by **enryold**'s [repository](https://github.com/enryold/UITabBarItem-CustomBadge).
I think this could be done in a better way, by overriding the `-(void)setBadgeValue:(NSString*)value` & the `-(NSString*)badgeValue`. In this way an existing project doesn't need to 
change the badge value settings related function calls. This is how the whole thing is maintained.

This project is under the MIT Liecense, feel free to use this code base under compilance.

##Installation
Installation of `UITabbarItem+CustomBadge` is easy, just add [UITabbarItem+CustomBadge](https://github.com/ratulSharker/UITabbarItem-CustomBadge/tree/master/Example/UITabbarItem%2BCustomBadge) category in your xcode project. Change the content of this category to meet your requiremnt and you're good to go.

##Advance Customization
From the release custom animation support is added. A default animation is also added. If no animation specified, there will be no animation by default. You need to specify the animation as follows

```obj-c
      //  here set your desired animation implementation. DefaultTabbarBadgeAnimation is provided as an example
      [UITabBarItem setDefaultAnimationProvider:[[DefaultTabbarBadgeAnimation alloc] init]];   
```
A good place to do this initialisation is in the `AppDelegate`'s  `DidfinishLaunchingWithOptions` method.


##Demo
<img src='https://github.com/ratulSharker/UITabbarItem-CustomBadge/blob/ratul_adding_configurable_properties/demo/UITabbarItem%2BCustomBadge%2BDemo.gif'>



Feel free to contact me @Sharker.ratul.08@gmail.com
