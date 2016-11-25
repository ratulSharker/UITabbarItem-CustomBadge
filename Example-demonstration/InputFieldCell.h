//
//  InputFieldCell.h
//  UITabBarItem+CustomBadge
//
//  Created by Ratul Sharker on 11/21/16.
//  Copyright © 2016 test. All rights reserved.
//

#import <UIKit/UIKit.h>


#define CELL_IDENTIFIER     @"input-cell"

@protocol InputFieldCellDelegate <NSObject>

-(void)inputFieldTextInputted:(NSString*) text forIndexPath:(NSIndexPath*)indexPath;

@end


@interface InputFieldCell : UITableViewCell

@property(strong) id<InputFieldCellDelegate> delegate;

-(void)setTextValue:(NSString*)text;
-(void)setPlaceholderText:(NSString*)placeholder;
-(void)setIndexPath:(NSIndexPath*)ip;

@end
