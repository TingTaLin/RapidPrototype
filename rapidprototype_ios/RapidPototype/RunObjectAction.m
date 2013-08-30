//
//  RunObjectAction.m
//  RapidPototype
//
//  Created by Lin Ting Ta on 13/6/15.
//  Copyright (c) 2013年 林震軒. All rights reserved.
//

#import "RunObjectAction.h"

@interface RunObjectAction ()

@end

@implementation RunObjectAction

@synthesize ble;
@synthesize button;

NSThread *newthread;
UInt8 IsUsingAnalogReadPinArray[5]={0,0,0,0,0};
bool cancel;

- (id)init
{
    self = [super init];
    
    //BLE 初始化
    ble = [[BLE alloc] init];
    [ble controlSetup:1];
    ble.delegate = self;
    
    return self;
}

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 藍芽連線

- (void)BlueToothConnect
{
    if (ble.peripherals)
        ble.peripherals = nil;

    [ble findBLEPeripherals:2];
    
    [NSTimer scheduledTimerWithTimeInterval:(float)2.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
    
    [self.delegate TellNewProjectToChangeIndAnimation:true];
}

- (void)BlueToothDisconnect
{
    if (ble.activePeripheral)
        if(ble.activePeripheral.isConnected)
        {
            [[ble CM] cancelPeripheralConnection:[ble activePeripheral]];
            [self.delegate TellNewProjectToChangeButtonImage:true];
            return;
        }
}

- (void)connectionTimer:(NSTimer *)timer
{
    [self.delegate TellNewProjectToChangeButtonImage:false];
    if (ble.peripherals.count > 0)
    {
        [ble connectPeripheral:[ble.peripherals objectAtIndex:0]];
    }
    else //連線失敗
    {
        [self.delegate TellNewProjectToChangeButtonImage:true];
        [self.delegate TellNewProjectToChangeIndAnimation:false];
        [self.delegate TellNewProjectToEnablebtnPlay:true];
    }
}

#pragma mark - 判別object類型&執行object動作(call method)

- (void)ScanAndRunAction
{
    cancel = NO;
    DataClass *obj = [DataClass getInstance];
    
    //未避免下次連線執行邏輯時近，analog的input沒有被正確reset而使用
    for (int j=1; j<=[obj TotalButtons]; j++) {
        if([obj ButtonOfIndex:j].ObjectClass>3)
        {
            [obj ButtonOfIndex:j].ObjectInputParameter = -1;
            NSLog(@"loop開始,未避免input上次沒清空，我把index為%d的Analog類型Object的ObjectInputParameter改成-1!",j);
        }
    }
    for (int i=1; i <= [obj TotalButtons]; i++) {
        button = [obj ButtonOfIndex:i];
        NSLog(@"This object has this informations: \nObjectClass:%d\nObjectnNUmber:%d\nObjectAct:%d\nObjectInputParameter:%d\nObjectOutputParameter:%d\nObjectKernel:%d\nObjectPin:%d\n",button.ObjectClass,button.ObjectNumber,button.ObjectAct,button.ObjectInputParameter,button.ObjectOutputParameter,button.ObjectKernel,button.ObjectPin);
        NSLog(@"-------------------我是分隔線---------------------");
        switch (button.ObjectClass) {
            case LED:
            {
                if (button.ObjectAct == LED_OFF) {
                    [self LED_Off:button];
                }
                else if (button.ObjectAct == LED_LIGHT) {
                    [self LED_Light:button];
                }
                else if (button.ObjectAct == LED_BLINK) {
                    [self LED_Blink:button];
                }
                else {
                    [self LED_Fade:button];
                }
                break;
            }
            case VIBRATION:
            {
                if (button.ObjectAct == VIBRATION_OFF) {
                    [self Vibration_Off:button];
                }
                else if (button.ObjectAct == VIBRATION_VIBRATE) {
                    [self Vibration_Vibrate:button];
                }
                else {
                    [self Vibration_Interval_Vibrate:button];
                }
                break;
            }
            case SPEAKER:
            {
                if (button.ObjectAct == SPEAKER_OFF) {
                    [self Speaker_Off:button];
                }
                else if (button.ObjectAct == SPEAKER_ON) {
                    [self Speaker_On:button];
                }
                else {
                    [self Speaker_Alarm:button];
                }
                break;
            }
            case BUTTON:
            {
                if (button.ObjectAct == BUTTON_READ) {
                    [self Button_Read:button];
                }
                else {

                    [self Button_Click:button];

                    // input為adino傳回來的值 表示按下1/沒按下0  output為使用者設定的值 表示按下通過1/不按下通過0
                    while (button.ObjectInputParameter != button.ObjectOutputParameter) {
                        if (cancel) {
                            return;
                        }
                        //NSLog(@"1in the loop");
                        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
                    }
                    NSLog(@"1阿母我莫名其妙就成功了！！滿足條件，跳出In the loop");
                    
                    for (int j=1; j<=[obj TotalButtons]; j++) {
                        if ([obj ButtonOfIndex:j].ObjectPin == button.ObjectPin) {
                            if([obj ButtonOfIndex:j].ObjectClass==button.ObjectClass)//這樣才不會改到analog的object
                            {
                                [obj ButtonOfIndex:j].ObjectInputParameter = -1;
                                NSLog(@"loop結束,我把index為%d的Object的ObjectInputParameter改成-1!",j);
                            }
                        }
                    }
                    
                    [self sendAdiunoStartToSendDigitalOrAnalogMessageOrNotToSend:0xA0 WithPin:button.ObjectPin ToSendOrNot:0x00];
                    
                }
                break;
            }
            case TILT:
            {
                if (button.ObjectAct == TILT_READ) {
                    [self Tilt_Read:button];
                }
                else {
                    
                    [self Tilt_Tilt:button];
                    
                    // input為adino傳回來的值 表示傾斜1/沒傾斜0  output為使用者設定的值 表示按下通過1/不按下通過0
                    while (button.ObjectInputParameter != button.ObjectOutputParameter) {
                        if (cancel) {
                            return;
                        }
                        NSLog(@"2in the loop");
                        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
                    }
                    NSLog(@"2阿母我莫名其妙就成功了！！滿足條件，跳出In the loop");
                    
                    for (int j=1; j<=[obj TotalButtons]; j++) {
                        if ([obj ButtonOfIndex:j].ObjectPin == button.ObjectPin) {
                            if([obj ButtonOfIndex:j].ObjectClass==button.ObjectClass)
                            {
                                [obj ButtonOfIndex:j].ObjectInputParameter = -1;
                                NSLog(@"loop結束,我把index為%d的Object的ObjectInputParameter改成-1!",j);
                            }
                        }
                    }
                    
                    [self sendAdiunoStartToSendDigitalOrAnalogMessageOrNotToSend:0xA0 WithPin:button.ObjectPin ToSendOrNot:0x00];
                    
                }
                break;
            }
            case LIQUID:
            {
                if (button.ObjectAct == LIQUID_READ) {
                    [self Liquid_Read:button];
                }
                else {
                    
                    [self Liquid_Wet:button];
                    
                    // input為adino傳回來的值 表示濕的1/乾的0  output為使用者設定的值 表示按下通過1/不按下通過0
                    while (button.ObjectInputParameter != button.ObjectOutputParameter) {
                        if (cancel) {
                            return;
                        }
                        NSLog(@"3in the loop");
                        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
                    }
                    NSLog(@"3阿母我莫名其妙就成功了！！滿足條件，跳出In the loop");
                    
                    for (int j=1; j<=[obj TotalButtons]; j++) {
                        if ([obj ButtonOfIndex:j].ObjectPin == button.ObjectPin) {
                            if([obj ButtonOfIndex:j].ObjectClass==button.ObjectClass)
                            {
                                [obj ButtonOfIndex:j].ObjectInputParameter = -1;
                                NSLog(@"loop結束,我把index為%d的Object的ObjectInputParameter改成-1!",j);
                            }
                        }
                    }
                    
                    [self sendAdiunoStartToSendDigitalOrAnalogMessageOrNotToSend:0xA0 WithPin:button.ObjectPin ToSendOrNot:0x00];
                    
                }
                break;
            }
            case ANGLE:
            {
                if (button.ObjectAct == ANGLE_READ) {
                    [self Angle_Read:button];
                }
                else {
                    [self Angle_Threshold:button];
                    //Input<0代表還沒有接收到analog input，在loop內等等
                    while (button.ObjectInputParameter<0) {
                        if (cancel) {
                            return;
                        }
                    }
                    //先利用正負數判斷,input是要大於output設定的值，還是小於
                    if(button.ObjectOutputParameter>0){//要大於Ouput才通過
                        while (button.ObjectInputParameter < button.ObjectOutputParameter) {
                            if (cancel) {
                                return;
                            }
                            NSLog(@"還沒大於Ouput");
                            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
                        }
                    }
                    else
                    {//要小於才通過
                        while (button.ObjectInputParameter > abs(button.ObjectOutputParameter)) {
                            if (cancel) {
                                return;
                            }
                            //NSLog(@"還沒小於Ouput");
                            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
                        }
                        
                    }
                    NSLog(@"4阿母我莫名其妙就成功了！！滿足條件，跳出In the loop");
                    
                    [self sendAdiunoStartToSendDigitalOrAnalogMessageOrNotToSend:0xB0 WithPin:button.ObjectPin ToSendOrNot:0x00];
                    
                    for (int j=1; j<=[obj TotalButtons]; j++) {
                        if ([obj ButtonOfIndex:j].ObjectPin == button.ObjectPin) {
                            if([obj ButtonOfIndex:j].ObjectClass==button.ObjectClass)
                            {
                                [obj ButtonOfIndex:j].ObjectInputParameter = -1;
                                NSLog(@"loop結束,我把index為%d的Analog類型Object的ObjectInputParameter改成-1!",j);
                            }
                        }
                    }
                }
                break;
            }
            case SOUNDSENSOR:
            {
                if (button.ObjectAct == SOUNDSENSOR_READ) {
                    [self SoundSensor_Read:button];
                }
                else {
                    [self SoundSensor_Threshold:button];
                    //Input<0代表還沒有接收到analog input，在loop內等等
                    while (button.ObjectInputParameter<0) {
                        if (cancel) {
                            return;
                        }
                    }
                    //先利用正負數判斷,input是要大於output設定的值，還是小於
                    if(button.ObjectOutputParameter>0){//要大於Ouput才通過
                        while (button.ObjectInputParameter < button.ObjectOutputParameter) {
                            if (cancel) {
                                return;
                            }
                            NSLog(@"還沒大於Ouput");
                            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
                        }
                    }
                    else
                    {//要小於才通過
                        while (button.ObjectInputParameter > abs(button.ObjectOutputParameter)) {
                            if (cancel) {
                                return;
                            }
                            NSLog(@"還沒小於Ouput");
                            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
                        }
                        
                    }
                    NSLog(@"5阿母我莫名其妙就成功了！！滿足條件，跳出In the loop");
                    
                    [self sendAdiunoStartToSendDigitalOrAnalogMessageOrNotToSend:0xB0 WithPin:button.ObjectPin ToSendOrNot:0x00];
                    for (int j=1; j<=[obj TotalButtons]; j++) {
                        if ([obj ButtonOfIndex:j].ObjectPin == button.ObjectPin) {
                            if([obj ButtonOfIndex:j].ObjectClass==button.ObjectClass)
                            {
                                [obj ButtonOfIndex:j].ObjectInputParameter = -1;
                                NSLog(@"loop結束,我把index為%d的Analog類型Object的ObjectInputParameter改成-1!",j);
                            }
                        }
                    }
                }
                break;
            }
            case LIGHTSENSOR:
            {
                if (button.ObjectAct == LIGHTSENSOR_READ) {
                    [self LightSensor_Read:button];
                }
                else if (button.ObjectAct == LIGHTSENSOR_REMEMBER) {
                    [self LightSensor_Remember:button];
                }
                else if (button.ObjectAct == LIGHTSENSOR_THRESHOLD) {
                    [self LightSensor_Threshold:button];
                    //Input<0代表還沒有接收到analog input，在loop內等等
                    while (button.ObjectInputParameter<0) {
                        if (cancel) {
                            return;
                        }
                    }
                    //先利用正負數判斷,input是要大於output設定的值，還是小於
                    if(button.ObjectOutputParameter>0){//要大於Ouput才通過
                        while (button.ObjectInputParameter < button.ObjectOutputParameter) {
                            if (cancel) {
                                return;
                            }
                            NSLog(@"還沒大於Ouput");
                            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
                        }
                    }
                    else
                    {//要小於才通過
                        while (button.ObjectInputParameter > abs(button.ObjectOutputParameter)) {
                            if (cancel) {
                                return;
                            }
                            NSLog(@"還沒小於Ouput");
                            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
                        }
                        
                    }
                    NSLog(@"6阿母我莫名其妙就成功了！！滿足條件，跳出In the loop");
                    
                    [self sendAdiunoStartToSendDigitalOrAnalogMessageOrNotToSend:0xB0 WithPin:button.ObjectPin ToSendOrNot:0x00];
                    
                    for (int j=1; j<=[obj TotalButtons]; j++) {
                        if ([obj ButtonOfIndex:j].ObjectPin == button.ObjectPin) {
                            if([obj ButtonOfIndex:j].ObjectClass==button.ObjectClass)
                            {
                                [obj ButtonOfIndex:j].ObjectInputParameter = -1;
                                NSLog(@"loop結束,我把index為%d的Analog類型Object的ObjectInputParameter改成-1!",j);
                            }
                        }
                    }
                }
                else {
                    [self LightSensor_Change:button];
                }
                break;
            }
            case PRESSURESENSOR:
            {
                if (button.ObjectAct == PRESSURESENSOR_READ) {
                    [self PressureSensor_Read:button];
                }
                else if (button.ObjectAct == PRESSURESENSOR_REMEMBER) {
                    [self PressureSensor_Remember:button];
                }
                else if (button.ObjectAct == PRESSURESENSOR_THRESHOLD) {
                    [self PressureSensor_Threshold:button];
                    //Input<0代表還沒有接收到analog input，在loop內等等
                    while (button.ObjectInputParameter<0) {
                        if (cancel) {
                            return;
                        }
                    }
                    //先利用正負數判斷,input是要大於output設定的值，還是小於
                    if(button.ObjectOutputParameter>0){//要大於Ouput才通過
                        while (button.ObjectInputParameter < button.ObjectOutputParameter) {
                            if (cancel) {
                                return;
                            }
                            NSLog(@"還沒大於Ouput");
                            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
                        }
                    }
                    else
                    {//要小於才通過
                        while (button.ObjectInputParameter > abs(button.ObjectOutputParameter)) {
                            if (cancel) {
                                return;
                            }
                            NSLog(@"還沒小於Ouput");
                            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
                        }
                        
                    }
                    NSLog(@"7阿母我莫名其妙就成功了！！滿足條件，跳出In the loop");
                    
                    [self sendAdiunoStartToSendDigitalOrAnalogMessageOrNotToSend:0xB0 WithPin:button.ObjectPin ToSendOrNot:0x00];
                }
                else {
                    [self PressureSensor_Change:button];
                }
                break;
            }
            case IPADBUTTON:
            {
                if (button.ObjectAct == IPADBUTTON_READ) {
                    [self IPadButton_Read:button];
                }
                else {
                    [self IPadButton_Click:button];
                }
                break;
            }
            case IPADSOUND:
            {
                if (button.ObjectAct == IPADSOUND_OFF) {
                    [self IpadSound_Off:button];
                }
                else if (button.ObjectAct == IPADSOUND_ALARM) {
                    [self IpadSound_Alarm:button];
                }
                else {
                    [self IpadSound_Melody:button];
                }
                break;
            }
            default: //RESET
            {
                for (int j=1; j<=[obj TotalButtons]; j++) {
                    if ([obj ButtonOfIndex:j].ObjectClass==LED||[obj ButtonOfIndex:j].ObjectClass==VIBRATION||[obj ButtonOfIndex:j].ObjectClass==SPEAKER) {
                        [self Reset:[obj ButtonOfIndex:j]];
                        NSLog(@"Reset");
                    }
                }
                break;
            }
        } //end switch
        if([obj TotalButtons]==i){
            i=0;
        }
    }//end for loop
}

#pragma mark - 執行object動作的method
-(void) LED_Off:(MoveButton*)object {
    [self sendDigitalMessageWithPin:object.ObjectPin OnorOff:0x00];
}
-(void) LED_Light:(MoveButton*)object {
    [self sendDigitalMessageWithPin:object.ObjectPin OnorOff:0x01];
}
-(void) LED_Blink:(MoveButton*)object {
    [self sendDigitalMessageWithPin:object.ObjectPin OnorOff:0x01 andValie:object.ObjectInputParameter];
}
-(void) LED_Fade:(MoveButton*)object {
    [self sendFadeDigitalMessageWithPin:object.ObjectPin OnorOff:0x01 andValue:object.ObjectInputParameter];
}
-(void) Vibration_Off:(MoveButton*)object {
    [self sendDigitalMessageWithPin:object.ObjectPin OnorOff:0x00];
}
-(void) Vibration_Vibrate:(MoveButton*)object {
    [self sendDigitalMessageWithPin:object.ObjectPin OnorOff:0x01];
}
-(void) Vibration_Interval_Vibrate:(MoveButton*)object {
    [self sendDigitalMessageWithPin:object.ObjectPin OnorOff:0x01 andValie:object.ObjectInputParameter];
}
-(void) Speaker_Off:(MoveButton*)object {
    [self sendDigitalMessageWithPin:object.ObjectPin OnorOff:0x00];
}
-(void) Speaker_On:(MoveButton*)object {
    [self sendDigitalMessageWithPin:object.ObjectPin OnorOff:0x01];
}
-(void) Speaker_Alarm:(MoveButton*)object {
    [self sendDigitalMessageWithPin:object.ObjectPin OnorOff:0x01 andValie:object.ObjectInputParameter];
}
-(void) Button_Read:(MoveButton*)object {}
-(void) Button_Click:(MoveButton*)object {
    [self sendAdiunoStartToSendDigitalOrAnalogMessageOrNotToSend:0xA0 WithPin:object.ObjectPin ToSendOrNot:0x01];
}
-(void) Tilt_Read:(MoveButton*)object {}
-(void) Tilt_Tilt:(MoveButton*)object {
    [self sendAdiunoStartToSendDigitalOrAnalogMessageOrNotToSend:0xA0 WithPin:object.ObjectPin ToSendOrNot:0x01];
}
-(void) Liquid_Read:(MoveButton*)object {}
-(void) Liquid_Wet:(MoveButton*)object {
    [self sendAdiunoStartToSendDigitalOrAnalogMessageOrNotToSend:0xA0 WithPin:object.ObjectPin ToSendOrNot:0x01];
}
-(void) Angle_Read:(MoveButton*)object {}
-(void) Angle_Threshold:(MoveButton*)object {
    [self sendAdiunoStartToSendDigitalOrAnalogMessageOrNotToSend:0xB0 WithPin:object.ObjectPin ToSendOrNot:0x01];
}
-(void) SoundSensor_Read:(MoveButton*)object {}
-(void) SoundSensor_Threshold:(MoveButton*)object {
    [self sendAdiunoStartToSendDigitalOrAnalogMessageOrNotToSend:0xB0 WithPin:object.ObjectPin ToSendOrNot:0x01];
}
-(void) LightSensor_Read:(MoveButton*)object {}
-(void) LightSensor_Remember:(MoveButton*)object {}
-(void) LightSensor_Threshold:(MoveButton*)object {
    [self sendAdiunoStartToSendDigitalOrAnalogMessageOrNotToSend:0xB0 WithPin:object.ObjectPin ToSendOrNot:0x01];
}
-(void) LightSensor_Change:(MoveButton*)object {}
-(void) PressureSensor_Read:(MoveButton*)object {}
-(void) PressureSensor_Remember:(MoveButton*)object {}
-(void) PressureSensor_Threshold:(MoveButton*)object {
    [self sendAdiunoStartToSendDigitalOrAnalogMessageOrNotToSend:0xB0 WithPin:object.ObjectPin ToSendOrNot:0x01];
}
-(void) PressureSensor_Change:(MoveButton*)object {}
-(void) IPadButton_Read:(MoveButton*)object {}
-(void) IPadButton_Click:(MoveButton*)object {}
-(void) IpadSound_Off:(MoveButton*)object {}
-(void) IpadSound_Alarm:(MoveButton*)object {}
-(void) IpadSound_Melody:(MoveButton*)object {}
-(void) Reset:(MoveButton*)object {
    [self sendDigitalMessageWithPin:object.ObjectPin OnorOff:0x00];
}

#pragma mark - BLE delegate

- (void)bleDidDisconnect
{
    NSLog(@"->Disconnected");
    [self.delegate TellNewProjectToChangeButtonImage:true];
    [self.delegate TellNewProjectToChangeIndAnimation:false];
    [self.delegate TellNewProjectIsBLEConnect:false];   //告訴NewProjectViewController現在沒有連線
    [self.delegate TellNewProjectToEnablebtnPlay:true];
    
    cancel = YES;
}

// When RSSI is changed, this will be called
-(void) bleDidUpdateRSSI:(NSNumber *) rssi
{
    
}

// When disconnected, this will be called
-(void) bleDidConnect
{
    NSLog(@"->Connected");
    [self.delegate TellNewProjectToChangeIndAnimation:false];
    [self.delegate TellNewProjectIsBLEConnect:true];   //告訴NewProjectViewController現在有連線
    [self.delegate TellNewProjectToEnablebtnPlay:true];
    newthread = [[NSThread alloc] initWithTarget:self selector:@selector(ScanAndRunAction) object:nil];
    [newthread setName:@"RUN-Thread"];
    [newthread start];
}

// When data is comming, this will be called
-(void) bleDidReceiveData:(unsigned char *)data length:(int)length
{
    DataClass *obj = [DataClass getInstance];
    // parse data, all commands are in 4-byte
    for (int i = 0; i < length; i+=4)
    {
        if (data[i] == 0x0A)    //digital
        {
            NSLog(@"receive digital message");
            for (int j=1; j<=[obj TotalButtons]; j++) {
                if ([obj ButtonOfIndex:j].ObjectPin == data[i+1]) {
                    if([obj ButtonOfIndex:j].ObjectClass<=6){
                        if (data[i+2] == 0x01) {
                            [obj ButtonOfIndex:j].ObjectInputParameter = 1;
                            NSLog(@"我接到digital 1的訊息，把index為%d的Object的ObjectInputParameter改成1!",j);
                        }
                        else
                        {
                            [obj ButtonOfIndex:j].ObjectInputParameter = 0;
                            NSLog(@"我接到digital 0的訊息，把index為%d的Object的ObjectInputParameter改成0!",j);
                        }
                    }
                }
            }
        }
        else if (data[i] == 0x0B)//analog
        {
            NSLog(@"receive Analog message");
            
            UInt16 Value;
            
            Value = data[i+3] | data[i+2] << 8;
      
            if(IsUsingAnalogReadPinArray[data[i+1]]==1){//判斷要接收才接收
                for (int j=1; j<=[obj TotalButtons]; j++) {
                    if ([obj ButtonOfIndex:j].ObjectPin == data[i+1]) {
                        if([obj ButtonOfIndex:j].ObjectClass>=7){
                            [obj ButtonOfIndex:j].ObjectInputParameter = Value;
                            NSLog(@"我接到Analog訊息，把index為%d的dObject的ObjectInputParameter改成%d!",j,Value);
                        }
                    }
                }
            }else{
                NSLog(@"我接到Analog訊息，但現在是關閉的，被我檔下來了");
            }
            
        }
    }
}

#pragma mark - iOS 傳送/接收 訊息 to/from Adiuno的method

-(void) sendDigitalMessageWithPin:(NSInteger)pin OnorOff:(NSInteger) msg
{
    UInt8 buf[4] = {0x01, 0x00, 0x00, 0x00}; //buf[1] = (1~7) 表示第幾個pin作digital輸出
    
    buf[1] = pin;  //第x個pin
    buf[2] = msg;  //set ON/OFF
    
    NSData *data = [[NSData alloc] initWithBytes:buf length:4];
    [ble write:data];
}

-(void) sendDigitalMessageWithPin:(NSInteger)pin OnorOff:(NSInteger)msg andValie:(float)value
{
    UInt8 buf[4] = {0x03, 0x00, 0x00, 0x00}; //buf[1] = (1~7) 表示第幾個pin作digital輸出

    buf[1] = pin;  //第x個pin
    buf[2] = msg;  //set ON/OFF
    buf[3] = value;//set slider value
    
    NSData *data = [[NSData alloc] initWithBytes:buf length:4];
    [ble write:data];
}

-(void) sendFadeDigitalMessageWithPin:(NSInteger)pin OnorOff:(NSInteger)msg andValue:(float)value
{
    UInt8 buf[4] = {0x04, 0x00, 0x00, 0x00}; //buf[1] = (1~7) 表示第幾個pin作digital輸出
    
    buf[1] = pin;  //第x個pin
    buf[2] = msg;  //set ON/OFF
    buf[3] = value;//set slider value
    
    NSData *data = [[NSData alloc] initWithBytes:buf length:4];
    [ble write:data];
}

-(void) sendAdiunoStartToSendDigitalOrAnalogMessageOrNotToSend:(NSInteger)DOA WithPin:(NSInteger)pin ToSendOrNot:(NSInteger)sendornot
{
    NSLog(@"我叫Arduino開始或關閉(%d)，傳輸數位或類比資料(%d)",sendornot,DOA);

    UInt8 buf[4] = {0x00, 0x00, 0x00, 0x00};
    
    buf[0] = DOA;   //Digital 0xA0 or Analog 0xB0
    buf[1] = pin;   //第x個pin
    buf[2] = sendornot;
    
    NSData *data = [[NSData alloc] initWithBytes:buf length:4];
    [ble write:data];
    
    IsUsingAnalogReadPinArray[pin]=sendornot;
}

@end
