//
//  ProjectName.h
//  RapidPototype
//
//  Created by 林震軒 on 13/4/27.
//  Copyright (c) 2013年 林震軒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectName : UIAlertView
@property(nonatomic, retain) UITextField* text_oldPwd;    // 旧密码输入框
@property(nonatomic, retain) UITextField* text_newPwd;    // 新密码输入框
@property(nonatomic, retain) UITextField* text_cfmPwd;    // 新密码确认框

@end
