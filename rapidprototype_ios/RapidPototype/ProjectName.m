//
//  ProjectName.m
//  RapidPototype
//
//  Created by 林震軒 on 13/4/27.
//  Copyright (c) 2013年 林震軒. All rights reserved.
//

#import "ProjectName.h"

@implementation ProjectName

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    if (self != nil) {
        // 初始化自定义控件，注意摆放的位置，可以多试几次位置参数直到满意为止
        // createTextField函数用来初始化UITextField控件，在文件末尾附上
        self.text_oldPwd = [self createTextField:@"旧密码"
                                   withFrame:CGRectMake(22, 45, 240, 36)];
        [self addSubview:self.text_oldPwd];
        
        self.text_newPwd = [self createTextField:@"新密码"
                                   withFrame:CGRectMake(22, 90, 240, 36)];
        [self addSubview:self.text_newPwd];
        
        self.text_cfmPwd = [self createTextField:@"确认新密码"
                                   withFrame:CGRectMake(22, 135, 240, 36)];
        [self addSubview:self.text_cfmPwd];
    }
    
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
}
// Override父类的layoutSubviews方法
- (void)layoutSubviews {
    [super layoutSubviews];     // 当override父类的方法时，要注意一下是否需要调用父类的该方法
    
    for (UIView* view in self.subviews) {
        // 搜索AlertView底部的按钮，然后将其位置下移
        // IOS5以前按钮类是UIButton, IOS5里该按钮类是UIThreePartButton
        if ([view isKindOfClass:[UIButton class]] ||
            [view isKindOfClass:NSClassFromString(@"UIThreePartButton")]) {
            CGRect btnBounds = view.frame;
            btnBounds.origin.y = self.text_cfmPwd.frame.origin.y + self.text_cfmPwd.frame.size.height + 7;
            view.frame = btnBounds;
        }
    }
    
    // 定义AlertView的大小
    CGRect bounds = self.frame;
    bounds.size.height = 260;
    self.frame = bounds;
}

- (UITextField*)createTextField:(NSString*)placeholder withFrame:(CGRect)frame {
    UITextField* field = [[UITextField alloc] initWithFrame:frame];
    field.placeholder = placeholder;
    field.secureTextEntry = YES;
    field.backgroundColor = [UIColor whiteColor];
    field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    return field;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
