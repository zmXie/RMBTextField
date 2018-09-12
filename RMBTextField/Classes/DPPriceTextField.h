//
//  DPPriceTextField.h
//  MedicalCircle
//
//  Created by xzm on 2018/8/3.
//  Copyright © 2018年 Dachen Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 金额输入框，带￥ */
@interface DPPriceTextField : UITextField

/** 最大输入长度,默认为9 */
@property (nonatomic,assign) NSInteger maxLength;

@end
