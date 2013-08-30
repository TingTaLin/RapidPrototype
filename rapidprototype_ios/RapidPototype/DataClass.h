//
//  DataClass.h
//  RapidPototype
//
//  Created by 林震軒 on 13/5/13.
//  Copyright (c) 2013年 林震軒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoveButton.h"

@interface DataClass : NSObject {
    
    NSString *str;
    int NumberOfObject;//編輯區上物件總數
    int RemoveID;//記錄被Remove的button ID
    int AnalogPinUsed[5];   //用來記錄、監控analog pin腳使用狀況的array 空間為0~4
    int DigitalPinUsed[8];  //用來記錄、監控digital pin腳使用狀況的array 空間為1~7
    MoveButton* ObjectOnBoard[20];  //用來記錄現在畫面中的所有物件的array 1~12
    int ObjectPWMCount;         //記錄使用PWM行為的物件個數 最多3個
}
@property(nonatomic,retain)NSString *str;
@property int NumberOfObject;
@property int RemoveID;
//@property (nonatomic,strong)MoveButton *ObjectOnBoard[20];



-(int)IndexOfButtonArray:(MoveButton*) ButtonObject;
-(MoveButton*)ButtonOfIndex:(int) Index;//傳回指定位置的movebutton
-(int)TotalButtons;//在ObjectOnBoard裡面實際上存有MoveButton的總數
-(void)DeleteMoveButton:(int)removeId;//從ObjectOnBoard remove Button
-(void)ForwardReplace:(int)StartIndex;//往前遞補
-(void)BackwardReplace:(int)StartIndex;//往後遞補
-(void)InsertInArray:(MoveButton*)InsertButton IndexOfInsert:(int)Index;//插入Button並放進ObjectOnBoard

- (int)setPin:(MoveButton *) button;    //判斷新創物件是否重複決定pin腳是否相同
- (int)setNewPin:(MoveButton *) button; //不同物件安插不同pin腳
- (int)setNewPWMPin:(MoveButton *) button;  //設置 pwm pin腳

+(DataClass*)getInstance;
+(void)clearInstance;

@end
//MoveButton *ObjectOnBoard[20];

