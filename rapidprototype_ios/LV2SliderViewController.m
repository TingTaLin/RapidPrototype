//
//  LV2SliderViewController.m
//  RapidPototype
//
//  Created by Lin Ting Ta on 13/6/5.
//  Copyright (c) 2013年 林震軒. All rights reserved.
//

#import "LV2SliderViewController.h"

@interface LV2SliderViewController ()

@end

@implementation LV2SliderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self.act isEqualToString:@"Threshold"])     {[self.navigationItem setTitle:@"Threshold"];}
    else if ([self.act isEqualToString:@"Change"])  {[self.navigationItem setTitle:@"Change"];}
    else if ([self.act isEqualToString:@"Blink"])   {[self.navigationItem setTitle:@"Blink"];}
    else if ([self.act isEqualToString:@"Fade"])    {[self.navigationItem setTitle:@"Fade"];}
    else if ([self.act isEqualToString:@"Alarm"])   {[self.navigationItem setTitle:@"Alarm"];}
    else /*         Interval Vibrate           */   {[self.navigationItem setTitle:@"Interval Vibrate"];}
    
    UIBarButtonItem *DoneBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(done)];
    self.navigationItem.rightBarButtonItem = DoneBtnItem;
    
    //設定slider的最大、最小和起始值  label的顯示文字
    if (((MoveButton*)self.delegate).ObjectClass == ANGLE || ((MoveButton*)self.delegate).ObjectClass == PRESSURESENSOR) {
        self.lblMin.text = @"0";
        self.lblMax.text = @"1023";
        self.Slider.minimumValue = 0;
        self.Slider.maximumValue = 1023;
        self.Slider.value = 50;
    }
    else if (((MoveButton*)self.delegate).ObjectClass == SOUNDSENSOR) {
        self.lblMin.text = @"-";
        self.lblMax.text = @"+";
        self.Slider.minimumValue = 0;
        self.Slider.maximumValue = 1023;
        self.Slider.value = 50;
    }
    else if (((MoveButton*)self.delegate).ObjectClass == LIGHTSENSOR) {
        if ([self.act isEqualToString:@"Threshold"]) {
            self.lblMin.text = @"Dark";
            self.lblMax.text = @"Su";
            self.Slider.minimumValue = 0;
            self.Slider.maximumValue = 1023;
            self.Slider.value = 50;
        }
        else {  //change
            self.lblMin.text = @"0";
            self.lblMax.text = @"1023";
            self.Slider.minimumValue = 0;
            self.Slider.maximumValue = 1023;
            self.Slider.value = 50;
        }
    }
    else {
        self.lblSwich.text = @"";
        self.GreatOrLess.hidden = YES;
        if ([self.act isEqualToString:@"Blink"] ||
            [self.act isEqualToString:@"Alarm"] ||
            [self.act isEqualToString:@"Interval Vibrate"]) {
            self.lblSliderTitle.text = @"Frequency:";
            self.lblMin.text = @"25";
            self.lblMax.text = @"255";
            self.Slider.minimumValue = 25;
            self.Slider.maximumValue = 255;
            self.Slider.value = 50;
        }
        else if ([self.act isEqualToString:@"Fade"]) {
            self.lblSliderTitle.text = @"Duration:";
            self.lblMin.text = @"5";
            self.lblMax.text = @"180";
            self.Slider.minimumValue = 5;
            self.Slider.maximumValue = 180;
            self.Slider.value = 50;
        }
    }
    self.lblSliderValue.text = [NSString stringWithFormat:@"%.0f",self.Slider.value];
    [self.lblSwich setText:@"Greater than slider value"];

    //如果之前有給過參數，用之前的參數當做起始值
    if (((MoveButton*)self.delegate).ObjectClass <= 3) {    //LED Vibration Speaker
        if (((MoveButton*)self.delegate).ObjectInputParameter != -1) {
            self.Slider.value = ((MoveButton*)self.delegate).ObjectInputParameter;
            self.lblSliderValue.text = [NSString stringWithFormat:@"%.0f",self.Slider.value];
        }
    }
    else {
        if ([self.act isEqualToString:@"Threshold"]) {
            if (((MoveButton*)self.delegate).ObjectOutputParameter != 0) {
                self.Slider.value = fabsf(((MoveButton*)self.delegate).ObjectOutputParameter);
                self.lblSliderValue.text = [NSString stringWithFormat:@"%.0f",self.Slider.value];
                if (((MoveButton*)self.delegate).ObjectOutputParameter > 0) {
                    self.GreatOrLess.on = true;
                    [self.lblSwich setText:@"Greater than slider value"];
                }
                else {
                    self.GreatOrLess.on = false;
                    [self.lblSwich setText:@"Less than slider value"];
                }
            }
        }
        else {  //change
            //change的保留值?
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    self.contentSizeForViewInPopover = CGSizeMake(320, 200);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)done
{
    if (((MoveButton*)self.delegate).ObjectClass == ANGLE || ((MoveButton*)self.delegate).ObjectClass == SOUNDSENSOR ||
        ((MoveButton*)self.delegate).ObjectClass == LIGHTSENSOR || ((MoveButton*)self.delegate).ObjectClass == PRESSURESENSOR) {
        if (self.GreatOrLess.on) {
            [self.delegate didLv2WithAct:self.act andvalue:self.Slider.value byGreaterOrLessthan:@"Greater"];
        }
        else {
            [self.delegate didLv2WithAct:self.act andvalue:self.Slider.value byGreaterOrLessthan:@"Less"];
        }
    }
    else {
        [self.delegate didLv2WithAct:self.act andvalue:self.Slider.value];
    }
}

- (IBAction)SliderChange:(UISlider *)sender {
    self.lblSliderValue.text = [NSString stringWithFormat:@"%.0f",self.Slider.value];
}

- (IBAction)GreatOrLessChange:(UISwitch *)sender {
    if (self.GreatOrLess.on) {
        [self.lblSwich setText:@"Greater than slider value"];
    }
    else {
        [self.lblSwich setText:@"Less than slider value"];
    }
}
@end
