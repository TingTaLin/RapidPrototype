//
//  LV2SliderViewController.h
//  RapidPototype
//
//  Created by Lin Ting Ta on 13/6/5.
//  Copyright (c) 2013年 林震軒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoveButton.h"
#import "ObjectClassDefine.h"

@protocol LV2SliderViewControllerDelegate <NSObject>

- (void)didLv2WithAct:(NSString*)act andvalue:(float)value;
- (void)didLv2WithAct:(NSString *)act andvalue:(float)value byGreaterOrLessthan:(NSString *)GreaterOrLessthan;

@end

@interface LV2SliderViewController : UIViewController

@property (strong, nonatomic) id<LV2SliderViewControllerDelegate> delegate;
@property (strong, nonatomic) NSString *act;

@property (strong, nonatomic) IBOutlet UISlider *Slider;
@property (strong, nonatomic) IBOutlet UILabel *lblMin;
@property (strong, nonatomic) IBOutlet UILabel *lblMax;
@property (strong, nonatomic) IBOutlet UILabel *lblSwich;
@property (strong, nonatomic) IBOutlet UILabel *lblSliderTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblSliderValue;
@property (strong, nonatomic) IBOutlet UISwitch *GreatOrLess;
- (IBAction)SliderChange:(UISlider *)sender;
- (IBAction)GreatOrLessChange:(UISwitch *)sender;




@end
