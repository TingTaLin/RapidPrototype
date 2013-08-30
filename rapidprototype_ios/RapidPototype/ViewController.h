//
//  ViewController.h
//  RapidPototype
//
//  Created by 林震軒 on 13/4/27.
//  Copyright (c) 2013年 林震軒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{

}

@property (strong, nonatomic) IBOutlet UIButton *Example1;
@property (strong, nonatomic) IBOutlet UIButton *Example2;
@property (strong, nonatomic) IBOutlet UIButton *Example3;
@property (strong, nonatomic) IBOutlet UIButton *Example4;
@property (strong, nonatomic) IBOutlet UIButton *Example5;
@property (strong, nonatomic) IBOutlet UIButton *Example6;
@property (strong, nonatomic) IBOutlet UIButton *Open1;
@property (strong, nonatomic) IBOutlet UIButton *Open2;
@property (strong, nonatomic) IBOutlet UIButton *Open3;
@property (strong, nonatomic) IBOutlet UIButton *Open4;
@property (strong, nonatomic) IBOutlet UIButton *Open5;
@property (strong, nonatomic) IBOutlet UIButton *CreateNew;

@property (strong, nonatomic) IBOutlet UIScrollView *Scroll_Example;
@property (strong, nonatomic) IBOutlet UIScrollView *Scroll_Open;
@property (strong, nonatomic) NSString *tempName;
@property (strong, nonatomic) NSString *NewProName;
//1代表為New Project;0代表舊的project;2代表example
@property NSInteger ProjectState;
- (IBAction)Open1:(UIButton *)sender;
- (IBAction)Open2:(UIButton *)sender;
- (IBAction)Open3:(UIButton *)sender;
- (IBAction)Open4:(UIButton *)sender;
- (IBAction)Open5:(UIButton *)sender;

-(IBAction)createNew:(UIButton *)sender;

@end
