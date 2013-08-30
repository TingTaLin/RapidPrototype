//
//  MoveButton.h
//  RapidPototype
//
//  Created by 林震軒 on 13/5/4.
//  Copyright (c) 2013年 林震軒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "TablePopoverController.h"
#import "LV2SliderViewController.h"
#import "LV2TableViewController.h"
#import "ObjectActDefine.h"
#import "ObjectClassDefine.h"

@protocol MoveButtonDelegate <NSObject>
- (void)ResetAction:(CGPoint)location WithId:(int)buttonId;
- (void)AngleAction:(CGPoint)location WithId:(int)buttonId;
- (void)BButton:(CGPoint)location WithId:(int)buttonId;
- (void)LightButton:(CGPoint)location WithId:(int)buttonId;
- (void)LiquidButton:(CGPoint)location WithId:(int)buttonId;
- (void)Pressure:(CGPoint)location WithId:(int)buttonId;
- (void)SoundButton:(CGPoint)location WithId:(int)buttonId;
- (void)SpeakerButton:(CGPoint)location WithId:(int)buttonId;
- (void)TiltButton:(CGPoint)location WithId:(int)buttonId;
- (void)VibrationButton:(CGPoint)location WithId:(int)buttonId;
- (void)IPadButton:(CGPoint)location WithId:(int)buttonId;
- (void)IPadSound:(CGPoint)location WithId:(int)buttonId;
- (void)LightSensor:(CGPoint)location WithId:(int)buttonId;
-(void)playSoundWhichOne:(int)Song;
@end
@interface MoveButton : UIButton
{
    CGFloat xDistance; //触摸点和中心点x方向移动的距离
    CGFloat yDistance; //触摸点和中心点y方向移动的距离
    
    id<MoveButtonDelegate> _delegate;
    
    CGPoint _originalPosition;
    
    // PARENT VIEW WHERE THE VIEWS CAN BE DRAGGED
    UIView *_mainView;
    // SCROLL VIEW WHERE YOU GONNA PUT THE THUMBNAILS
    UIScrollView *scrollParent;
    
    UIImageView *tempImage;

    
}
@property (nonatomic, retain) id<MoveButtonDelegate> delegate;
@property (nonatomic) CGPoint originalPosition;
@property (nonatomic, retain) UIView *mainView;
@property (nonatomic, retain) UIScrollView *scrollParent;
@property (nonatomic, retain) UIImageView *tempImage;
@property int ButtonID;
@property int InsertID;
@property int RemoveBtnID;
@property BOOL CheckFirst;//檢查是否在scroll裡面
@property BOOL ObjectIsFull;
@property CGPoint temp;
@property CGRect InsertFrame1;
@property CGRect InsertFrame2;
@property CGRect InsertFrame3;
@property CGRect InsertFrame4;
@property CGRect InsertFrame5;
@property CGRect InsertFrame6;
@property CGRect InsertFrame7;
@property CGRect InsertFrame8;
@property CGRect InsertFrame9;
@property CGRect InsertFrame10;
@property CGRect InsertFrame11;
@property CGRect InsertFrame12;
@property (nonatomic, retain)NSString *ImageForObject;
@property (strong, nonatomic) UIPopoverController *popoverController;


@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UILabel *label;

//@property NSInteger ObjectID;             //物件排列位置(1~12)
@property NSInteger ObjectClass;            //物件種類
@property NSInteger ObjectNumber;           //物件編號_數位(1~7)_類比(1~5)<同一種Object，可能有兩個以上>
@property NSInteger ObjectAct;              //物件行為
@property NSInteger ObjectInputParameter;   //物件(需要)輸入行為參數
@property NSInteger ObjectOutputParameter;  //物件輸出行為參數
@property NSInteger ObjectKernel;           //物件連接的Kernel(default 1)
@property NSInteger ObjectPin;              //物件連接的腳位


- (id)initWithFrame:(CGRect)frame WithParentView:(UIView*)FatherView WithObjectType:(NSInteger)objectclass WithButtonID:(int)buttonId;
- (id)initWithFrame:(CGRect)frame :(UIView*)FatherView :(NSInteger)objectclass;
//-(void) touchDown;
//-(void) touchUp;
-(CGPoint) LocationOfButton:(int)buttonId;
-(BOOL) isInsideRecycleBin:(MoveButton *)button touching:(BOOL)finished;
-(BOOL) isInsertRegion:(MoveButton *)button;
-(void)RemoveButton:(int)removeID;
-(void)MakeObject:(int)buttonId;
-(void) magic;//阿達說的

@end


