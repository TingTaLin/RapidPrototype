//
//  NewProjectViewController_1.h
//  RapidPototype
//
//  Created by 林震軒 on 13/5/31.
//  Copyright (c) 2013年 林震軒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MoveButton.h"
#import "TablePopoverController.h"
#import "RunObjectAction.h"

#import "ObjectClassDefine.h"
#import "ObjectActDefine.h"


@interface NewProjectViewController_1 : UIViewController<MoveButtonDelegate, RunObjectActionDelegate>
{
    //IBOutlet UIButton *btnPlay; 改用NextBtnItem 8/14
    UIBarButtonItem *NextBtnItem;
    //IBOutlet UIActivityIndicatorView *indConnecting;
    
    SystemSoundID connectingSound;
    SystemSoundID disconnectSound;
    SystemSoundID objectpopSound;
    SystemSoundID objectinsertSound;
    SystemSoundID trashSound;
    SystemSoundID popoverSound;
    SystemSoundID clickdoneSound;
}
@property (strong, nonatomic) IBOutlet UIScrollView *Scroll_ChoosingItems;
@property (strong, nonatomic) IBOutlet UILabel *PrName;//儲存ProjectName

/*-----------------------------------------------------------------
 
                         Pin腳示意圖的宣告
 
 -----------------------------------------------------------------*/
@property (retain, nonatomic) IBOutlet UIView *PinsDiagram;//示意圖
@property (strong, nonatomic) IBOutlet UIView *CoverView;//示意圖出現時的背景淡化
@property (strong, nonatomic) IBOutlet UIImageView *ArduinoImage;
//Digital Objects & Arrows
@property (strong, nonatomic) IBOutlet UIImageView *DigitalObject1;
@property (strong, nonatomic) IBOutlet UIImageView *DigitalObject2;
@property (strong, nonatomic) IBOutlet UIImageView *DigitalObject3;
@property (strong, nonatomic) IBOutlet UIImageView *DigitalObject4;
@property (strong, nonatomic) IBOutlet UIImageView *DigitalObject5;
@property (strong, nonatomic) IBOutlet UIImageView *DigitalObject6;
@property (strong, nonatomic) IBOutlet UIImageView *DigitalObject7;
@property (strong, nonatomic) IBOutlet UIImageView *DigitalArrow1;
@property (strong, nonatomic) IBOutlet UIImageView *DigitalArrow2;
@property (strong, nonatomic) IBOutlet UIImageView *DigitalArrow3;
@property (strong, nonatomic) IBOutlet UIImageView *DigitalArrow4;
@property (strong, nonatomic) IBOutlet UIImageView *DigitalArrow5;
@property (strong, nonatomic) IBOutlet UIImageView *DigitalArrow6;
@property (strong, nonatomic) IBOutlet UIImageView *DigitalArrow7;
//Analog Object & Arrows
@property (strong, nonatomic) IBOutlet UIImageView *AnalogObject0;
@property (strong, nonatomic) IBOutlet UIImageView *AnalogObject1;
@property (strong, nonatomic) IBOutlet UIImageView *AnalogObject2;
@property (strong, nonatomic) IBOutlet UIImageView *AnalogObject3;
@property (strong, nonatomic) IBOutlet UIImageView *AnalogObject4;
@property (strong, nonatomic) IBOutlet UIImageView *AnalogArrow0;
@property (strong, nonatomic) IBOutlet UIImageView *AnalogArrow1;
@property (strong, nonatomic) IBOutlet UIImageView *AnalogArrow2;
@property (strong, nonatomic) IBOutlet UIImageView *AnalogArrow3;
@property (strong, nonatomic) IBOutlet UIImageView *AnalogArrow4;

- (IBAction)ConfirmButton:(id)sender;


@property (strong, nonatomic) MoveButton *aaa;
@property  NSInteger receiveID; //
@property (strong, nonatomic) NSString *tempName;

@property (strong, nonatomic) UIPopoverController *popoverController;
@property (strong, nonatomic) RunObjectAction *runobjectaction;
@property BOOL isBLEConnect;

- (void)LightButton:(CGPoint)location WithId:(int)buttonId;
- (void)VibrationButton:(CGPoint)location WithId:(int)buttonId;
- (void)SpeakerButton:(CGPoint)location WithId:(int)buttonId;
- (void)BButton:(CGPoint)location WithId:(int)buttonId;
- (void)TiltButton:(CGPoint)location WithId:(int)buttonId;
- (void)LiquidButton:(CGPoint)location WithId:(int)buttonId;
- (void)AngleAction :(CGPoint)location WithId:(int)buttonId;
- (void)SoundButton:(CGPoint)location WithId:(int)buttonId; 
- (void)LightSensor:(CGPoint)location WithId:(int)buttonId;
- (void)Pressure:(CGPoint)location WithId:(int)buttonId;
- (void)IPadButton:(CGPoint)location WithId:(int)buttonId;
- (void)IPadSound:(CGPoint)location WithId:(int)buttonId;
- (void)ResetAction:(CGPoint)location WithId:(int)buttonId;
//- (IBAction)btnPlayClicked:(id)sender WithId:(int)buttonId;
-(void)playSoundWhichOne:(int)Song;

- (UIImage*)setAnalogPinsDiagramImage:(MoveButton*) button;
- (void)setAnalogPinsDiagramPin:(MoveButton*) button;
- (UIImage*)setDigitalPinsDiagramImage:(MoveButton*) button;
- (void)setDigitalPinsDiagramPin:(MoveButton*) button;

- (id)initWithNibName:(NSString *)nibNameOrNil title:(NSString *)title bundle:(NSBundle *)nibBundleOrNil;
@end
