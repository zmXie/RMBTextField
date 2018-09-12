//
//  DPPriceTextField.m
//  MedicalCircle
//
//  Created by xzm on 2018/8/3.
//  Copyright © 2018年 Dachen Tech. All rights reserved.
//

#import "DPPriceTextField.h"
#import <Masonry/Masonry.h>

@interface DPPriceTextField ()

@property (nonatomic,strong) UILabel * leftLabel;

@end

@implementation DPPriceTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.delegate = (id)self;
        self.keyboardType = UIKeyboardTypeNumberPad;
        self.maxLength = 9;
        [self addSubview:self.leftLabel];
        self.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 10)];
        self.textAlignment = NSTextAlignmentLeft;
        
        [self addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
        self.text = @"";
    }
    return self;
}

- (void)textDidChange:(UITextField *)tf
{
    if([tf.text hasPrefix:@"0"] && tf.text.length > 1)
    {
        tf.text = [tf.text substringFromIndex:1];
    }
    if(tf.text.length == 0)
    {
        tf.text = @"0";
    }
    
    CGSize textSize = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    CGFloat offset = textSize.width/2.f;
    
    if(self.textAlignment != 0)
    {
        [self.leftLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            if(self.textAlignment == 1)
            {
                make.centerX.equalTo(self).offset(- offset);
            }else
            {
                make.right.mas_equalTo(- textSize.width);
            }
        }];
    }
}

#pragma mark -- setter & getter
- (UILabel *)leftLabel
{
    if(!_leftLabel)
    {
        _leftLabel = [UILabel new];
        _leftLabel.text = @"￥";
    }
    return _leftLabel;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textDidChange:self];
}

- (void)setTextColor:(UIColor *)textColor
{
    [super setTextColor:textColor];
    self.leftLabel.textColor = textColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.leftLabel.font = font;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    
    self.leftViewMode = self.textAlignment == 2 ? UITextFieldViewModeNever : UITextFieldViewModeAlways;
    
    self.leftLabel.textAlignment = textAlignment;
    
    [self.leftLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        if(textAlignment == 0)
        {
           make.left.mas_equalTo(0);
        }else if (textAlignment == 1)
        {
            make.centerX.equalTo(self);
        }else
        {
            make.right.mas_equalTo(0);
        }
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > self.maxLength) return NO;
    return YES;
}

@end
