//
//  InputFieldCell.m
//  UITabBarItem+CustomBadge
//
//  Created by Ratul Sharker on 11/21/16.
//

#import "InputFieldCell.h"

@interface InputFieldCell() <UITextFieldDelegate>
{
    IBOutlet UITextField *mViewInputTextField;
    NSIndexPath *indexPath;
}
@end

@implementation InputFieldCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    mViewInputTextField.delegate = self;
    
}

#pragma mark public helper method
-(void)setTextValue:(NSString*)text
{
    mViewInputTextField.text = text;
}
-(void)setPlaceholderText:(NSString*)placeholder
{
    mViewInputTextField.placeholder = placeholder;
}
-(void)setIndexPath:(NSIndexPath*)ip
{
    indexPath = ip;
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-               (BOOL)textField:(UITextField *)textField
  shouldChangeCharactersInRange:(NSRange)range
              replacementString:(NSString *)string
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(inputFieldTextInputted:forIndexPath:)])
    {
        NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        [self.delegate inputFieldTextInputted:text forIndexPath:indexPath];
    }
    else
    {
        NSLog(@"delegate not found");
    }
    
    return YES;
}

@end
