//
//  UITabbarItemAnimation.h
//  UITabBarItem+CustomBadge
//
//  Created by Ratul Sharker on 11/20/16.
//

#ifndef UITabbarItemAnimation_h
#define UITabbarItemAnimation_h

//
//  completion block and protocol declaration
//  to be used into the custom animation implementation
//
typedef void(^BadgeAnimationCompletionBlock)();

//
//  @Discussion
//
//  If you want to provide an custom animation, whenever a badge value is set,
//  you must declare a class who conforms to this following protocol. This
//  protocol is consist of two methods.
//
//  - BadgeAppearAnimationForBadge...
//  - BadgeDisappearAnimationForBadge...
//
//  we will discuss each function just before their delcaration.
//
@protocol UITabbarItemBadgeAnimation <NSObject>

//
//  @Discussion
//  This function will be called when the badge value will change to something
//  except nil. In this method, it is not expected to change the frame or size
//  of the badge label. If you had to change it somehow, please save the frame
//  and the size before you gonna change it, and finally when all the transition
//  completed, it's the implementer's responsibility to set them / keep their
//  previous value.
//
//  @param
//  - badge : A UILabel, which is the actual badge text.
//  - msg   : NSString represent the next msg to assign. You may want to animate the text assign action
//  - completion : a completion which is sent by the UITabbar+CustomBadge that ensure the final state,
//                  you are about to execute that blocl after all you animation been completed.
//
-(void)UITabbarItemBadgeAppearAnimationForBadge:(UILabel*)badge
                                   withNewValue:(NSString*)msg
                                 withCompletion:(BadgeAnimationCompletionBlock)completion;
//
//
//
//
//
-(void)UITabbarItemBadgeDisappearAnimationForBadge:(UILabel*)badge
                                    withCompletion:(BadgeAnimationCompletionBlock)completion;
@end

#endif /* UITabbarItemAnimation_h */
