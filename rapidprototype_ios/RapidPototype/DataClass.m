//
//  DataClass.m
//  RapidPototype
//
//  Created by 林震軒 on 13/5/13.
//  Copyright (c) 2013年 林震軒. All rights reserved.
//

#import "DataClass.h"

@implementation DataClass
@synthesize str;
@synthesize NumberOfObject;
@synthesize RemoveID;

static DataClass *instance =nil;

-(int)IndexOfButtonArray:(MoveButton*) ButtonObject{
    
    ObjectOnBoard[NumberOfObject] = ButtonObject;
    
    
    return  NumberOfObject ;
    
}
-(MoveButton*)ButtonOfIndex:(int)Index
{
    return ObjectOnBoard[Index];
}
-(int)TotalButtons{
    int count = 0;
    for (int i = 1; i < 13; i++) {
        if (ObjectOnBoard[i] != NULL) {
            count++;
        }
    }
    
//    NSLog(@"現在TotalButtons在Array裡面有：%d 個\n",count);
    return  count;
}
-(void)DeleteMoveButton:(int)removeId{
    //找出要移除物件被安排的pin腳，然後把對應的pin腳監測array(Analog or Digital)中對應的element設為0
    MoveButton *button = ObjectOnBoard[removeId];
    NSInteger removePin = button.ObjectPin;
    if (button.ObjectClass == ANGLE || button.ObjectClass == SOUNDSENSOR ||
        button.ObjectClass == LIGHTSENSOR || button.ObjectClass == PRESSURESENSOR) {
        AnalogPinUsed[removePin] = 0;
    }
    else {
        DigitalPinUsed[removePin] = 0;
    }
    ObjectOnBoard[removeId] = NULL;
}
-(void)ForwardReplace:(int)StartIndex{
    for (int i = StartIndex; i < [self TotalButtons]+1; i++) {
        //NSLog(@"This is Forward's loop.....\n");
        ObjectOnBoard[i] = ObjectOnBoard[i+1];
    }
}
-(void)BackwardReplace:(int)StartIndex{
    for (int i = [self TotalButtons]; [self TotalButtons]<13 && i>StartIndex-1 ; i--) {
        ObjectOnBoard[i+1] = ObjectOnBoard[i];
    }
}
-(void)InsertInArray:(MoveButton*)InsertButton IndexOfInsert:(int)Index{
    ObjectOnBoard[Index] = InsertButton;
}

#pragma mark - Choosing Object Pin腳

- (int)setPin:(MoveButton *)button
{
    NSLog(@"objectPWMCount default value is %d",ObjectPWMCount);
    //對照畫面上現在的所有物件 看是否有相同種類 有的話就假設是指相同物件 pin腳預設為同一個
    for (int i=1; i<=[self TotalButtons]; i++) {
        if (button.ObjectClass == ObjectOnBoard[i].ObjectClass) {
            return ObjectOnBoard[i].ObjectPin;
        }
    }
    //沒有相同物件種類 設置新的pin腳
    return [self setNewPin:button];
}

- (int)setNewPin:(MoveButton *)button
{
    if (button.ObjectClass == ANGLE || button.ObjectClass == SOUNDSENSOR ||
        button.ObjectClass == LIGHTSENSOR || button.ObjectClass == PRESSURESENSOR) {
        if (AnalogPinUsed[0] == 0) {
            AnalogPinUsed[0] = 1;
            return 0;
        }
        else if (AnalogPinUsed[1] == 0) {
            AnalogPinUsed[1] = 1;
            return 1;
        }
        else if (AnalogPinUsed[2] == 0) {
            AnalogPinUsed[2] = 1;
            return 2;
        }
        else if (AnalogPinUsed[3] == 0) {
            AnalogPinUsed[3] = 1;
            return 3;
        }
        else if (AnalogPinUsed[4] == 0) {
            AnalogPinUsed[4] = 1;
            return 4;
        }
        else {
            return -1;
        }
    }
    else {
        if (DigitalPinUsed[1] == 0) {
            DigitalPinUsed[1] = 1;
            return 1;
        }
        else if (DigitalPinUsed[2] == 0) {
            DigitalPinUsed[2] = 1;
            return 2;
        }
        else if (DigitalPinUsed[4] == 0) {
            DigitalPinUsed[4] = 1;
            return 4;
        }
        else if (DigitalPinUsed[7] == 0) {
            DigitalPinUsed[7] = 1;
            return 7;
        }
        else if (DigitalPinUsed[3] == 0) {
            DigitalPinUsed[3] = 1;
            return 3;
        }
        else if (DigitalPinUsed[5] == 0) {
            DigitalPinUsed[5] = 1;
            return 5;
        }
        else if (DigitalPinUsed[6] == 0) {
            DigitalPinUsed[6] = 1;
            return 6;
        }
        else {
            return -1;
        }
    }
}

- (int)setNewPWMPin:(MoveButton *)button
{
    if (ObjectPWMCount == 3) {
        return -1;  //  PWM (fade行為)使用超過3個
    }
    else {
        if (DigitalPinUsed[3] == 0) {
            DigitalPinUsed[3] = 1;
            ObjectPWMCount++;
            return 3;
        }
        else if (DigitalPinUsed[5] == 0) {
            DigitalPinUsed[5] = 1;
            ObjectPWMCount++;
            return 5;
        }
        else if (DigitalPinUsed[6] == 0) {
            DigitalPinUsed[6] = 1;
            ObjectPWMCount++;
            return 6;
        }
        else
            return -2;  //不同的物件使用過多，佔據了PWM pin腳
    }
}

#pragma mark - get DataClass instance

+(DataClass *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            
            instance= [DataClass new];
        }
    }
    return instance;
}

+(void)clearInstance
{
    instance = nil;
}

@end
