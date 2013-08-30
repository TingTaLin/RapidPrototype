//
//  RunObjectAction.h
//  RapidPototype
//
//  Created by Lin Ting Ta on 13/6/15.
//  Copyright (c) 2013年 林震軒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataClass.h"
#import "BLE.h"

@protocol RunObjectActionDelegate <NSObject>

-(void) TellNewProjectToChangeIndAnimation:(BOOL)StartorStop;
-(void) TellNewProjectToChangeButtonImage:(BOOL)PlayorStop;
-(void) TellNewProjectIsBLEConnect:(BOOL)isConnect;
-(void) TellNewProjectToEnablebtnPlay:(BOOL)toEnable;

@end

@interface RunObjectAction : UIViewController<BLEDelegate>

@property (strong, nonatomic) id<RunObjectActionDelegate> delegate;
@property (strong, nonatomic) BLE *ble;
@property (strong, nonatomic) MoveButton *button;

-(void) BlueToothConnect;
-(void) BlueToothDisconnect;
-(void) ScanAndRunAction;

//執行object動作的method
-(void) LED_Off:(MoveButton*)object;
-(void) LED_Light:(MoveButton*)object;
-(void) LED_Blink:(MoveButton*)object;
-(void) LED_Fade:(MoveButton*)object;
-(void) Vibration_Of:(MoveButton*)objectf;
-(void) Vibration_Vibrate:(MoveButton*)object;
-(void) Vibration_Interval_Vibrate:(MoveButton*)object;
-(void) Speaker_Off:(MoveButton*)object;
-(void) Speaker_On:(MoveButton*)object;
-(void) Speaker_Alarm:(MoveButton*)object;
-(void) Button_Read:(MoveButton*)object;
-(void) Button_Click:(MoveButton*)object;
-(void) Tilt_Read:(MoveButton*)object;
-(void) Tilt_Tilt:(MoveButton*)object;
-(void) Liquid_Read:(MoveButton*)object;
-(void) Liquid_Wet:(MoveButton*)object;
-(void) Angle_Read:(MoveButton*)object;
-(void) Angle_Threshold:(MoveButton*)object;
-(void) SoundSensor_Read:(MoveButton*)object;
-(void) SoundSensor_Threshold:(MoveButton*)object;
-(void) LightSensor_Read:(MoveButton*)object;
-(void) LightSensor_Remember:(MoveButton*)object;
-(void) LightSensor_Threshold:(MoveButton*)object;
-(void) LightSensor_Change:(MoveButton*)object;
-(void) PressureSensor_Read:(MoveButton*)object;
-(void) PressureSensor_Threshold:(MoveButton*)object;
-(void) PressureSensor_Remember:(MoveButton*)object;
-(void) PressureSensor_Change:(MoveButton*)object;
-(void) IPadButton_Read:(MoveButton*)object;
-(void) IPadButton_Click:(MoveButton*)object;
-(void) IpadSound_Off:(MoveButton*)object;
-(void) IpadSound_Alarm:(MoveButton*)object;
-(void) IpadSound_Melody:(MoveButton*)object;
-(void) Reset;

//iOS 傳送/接收 訊息 to/from Adiuno的method
-(void) sendDigitalMessageWithPin:(NSInteger)pin OnorOff:(NSInteger) msg;
-(void) sendDigitalMessageWithPin:(NSInteger)pin OnorOff:(NSInteger) msg andValue:(float)value;
-(void) sendFadeDigitalMessageWithPin:(NSInteger)pin OnorOff:(NSInteger) msg andValue:(float)value;
-(void) sendAdiunoStartToSendDigitalOrAnalogMessageOrNotToSend:(NSInteger)DOA WithPin:(NSInteger)pin ToSendOrNot:(NSInteger)sendornot;
@end
