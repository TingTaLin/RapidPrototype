//
//  MoveButton.m
//  RapidPototype
//
//  Created by 林震軒 on 13/5/4.
//  Copyright (c) 2013年 林震軒. All rights reserved.
//
#import "MoveButton.h"
#import "NewProjectViewController_1.h"
#import <QuartzCore/QuartzCore.h>
#import "DataClass.h"

@implementation MoveButton

@synthesize delegate;
@synthesize originalPosition = _originalPosition;
@synthesize mainView;
@synthesize scrollParent;
@synthesize tempImage;




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame WithParentView:(UIView*)FatherView WithObjectType:(NSInteger)objectclass WithButtonID:(int)buttonId{
    
    self.ObjectIsFull = NO;
    //DataClass *obj = [DataClass getInstance];
    self.ButtonID = buttonId;
    self.ObjectClass = objectclass;
    
    self.InsertFrame1 = CGRectMake(345, 120, 155, 100);
    self.InsertFrame2 = CGRectMake(500, 120, 155, 100);
    self.InsertFrame3 = CGRectMake(655, 120, 155, 100);
    self.InsertFrame4 = CGRectMake(830, 120, 163, 170);
    self.InsertFrame5 = CGRectMake(915, 308, 100, 142);
    self.InsertFrame6 = CGRectMake(830, 480, 163, 170);
    self.InsertFrame7 = CGRectMake(655, 550, 155, 100);
    self.InsertFrame8 = CGRectMake(500, 550, 155, 100);
    self.InsertFrame9 = CGRectMake(345, 550, 155, 100);
    self.InsertFrame10 = CGRectMake(195, 480, 150, 170);
    self.InsertFrame11 = CGRectMake(195, 308, 100, 142);
    self.InsertFrame12 = CGRectMake(195, 120, 150, 170);
    
    //由objectClass決定圖片
    switch (self.ObjectClass) {
        case 13:
            self.ImageForObject = @"物件區&編輯區Reset.png";
            break;
        case 7:
            self.ImageForObject = @"物件區-Angle.png";
            break;
        case 1:
            self.ImageForObject = @"物件區-Light.png";
            break;
        case 2:
            self.ImageForObject = @"物件區-Vibration.png";
            break;
        case 3:
            self.ImageForObject = @"物件區-Speaker.png";
            break;
        case 4:
            self.ImageForObject = @"物件區-Button.png";
            break;
        case 5:
            self.ImageForObject = @"物件區-Tilt.png";
            break;
        case 6:
            self.ImageForObject = @"物件區-Liquid.png";
            break;
        case 8:
            self.ImageForObject = @"物件區-Sound.png";
            break;
        case 9:
            self.ImageForObject = @"物件區LightSensor.png";
            break;
        case 10:
            self.ImageForObject = @"物件區-Pressure.png";
            break;
        case 11:
            self.ImageForObject = @"物件區-iPadButton.png";
            break;
        case 12:
            self.ImageForObject = @"物件區-iPadSound.png";
            break;
            
            
            
        default:
            break;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        self.mainView = FatherView;
        // Initialization code
    }
    UITapGestureRecognizer *tap;
    
    if (self.center.x < 145) {
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magic)];
        //[self.layer setShadowColor:[UIColor clearColor].CGColor];
    }
    else{
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ShowPopOver)];
        
    }
    
    
    //加个初始化手势；
    [self addGestureRecognizer:tap];
    return self;
 
}
- (id)initWithFrame:(CGRect)frame :(UIView*)FatherView :(NSInteger)objectclass 
{
    self.ObjectIsFull = NO;
    DataClass *obj = [DataClass getInstance];
    self.ButtonID = obj.NumberOfObject;
    self.ObjectClass = objectclass;
    
    self.InsertFrame1 = CGRectMake(345, 120, 155, 100);
    self.InsertFrame2 = CGRectMake(500, 120, 155, 100);
    self.InsertFrame3 = CGRectMake(655, 120, 155, 100);
    self.InsertFrame4 = CGRectMake(830, 120, 163, 170);
    self.InsertFrame5 = CGRectMake(915, 308, 100, 142);
    self.InsertFrame6 = CGRectMake(830, 480, 163, 170);
    self.InsertFrame7 = CGRectMake(655, 550, 155, 100);
    self.InsertFrame8 = CGRectMake(500, 550, 155, 100);
    self.InsertFrame9 = CGRectMake(345, 550, 155, 100);
    self.InsertFrame10 = CGRectMake(195, 480, 150, 170);
    self.InsertFrame11 = CGRectMake(195, 308, 100, 142);
    self.InsertFrame12 = CGRectMake(195, 120, 150, 170);
    
    //由objectClass決定圖片
    switch (self.ObjectClass) {
        case 13:
            self.ImageForObject = @"物件區&編輯區Reset.png";
            break;
        case 7:
            self.ImageForObject = @"物件區-Angle.png";
            break;
        case 1:
            self.ImageForObject = @"物件區-Light.png";
            break;
        case 2:
            self.ImageForObject = @"物件區-Vibration.png";
            break;
        case 3:
            self.ImageForObject = @"物件區-Speaker.png";
            break;
        case 4:
            self.ImageForObject = @"物件區-Button.png";
            break;
        case 5:
            self.ImageForObject = @"物件區-Tilt.png";
            break;
        case 6:
            self.ImageForObject = @"物件區-Liquid.png";
            break;
        case 8:
            self.ImageForObject = @"物件區-Sound.png";
            break;
        case 9:
            self.ImageForObject = @"物件區LightSensor.png";
            break;
        case 10:
            self.ImageForObject = @"物件區-Pressure.png";
            break;
        case 11:
            self.ImageForObject = @"物件區-iPadButton.png";
            break;
        case 12:
            self.ImageForObject = @"物件區-iPadSound.png";
            break;


            
        default:
            break;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        self.mainView = FatherView;
        // Initialization code
    }
    UITapGestureRecognizer *tap;
    
    if (self.center.x < 145) {
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magic)];
    }
    else{
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ShowPopOver)];
    }
    
    
    //加个初始化手势；
    [self addGestureRecognizer:tap];
    return self;
}

-(void)ShowPopOver
{
    //關閉抖動跟clear shadow
    [self.delegate playSoundWhichOne:POPOVER_SOUND]; 
    [self.layer setShadowColor:[UIColor clearColor].CGColor];
    [self stopShake];
    self.alpha = 1.0;
    
    if (self.ObjectClass != RESET) {
        //create the view controller from nib
        TablePopoverController *tablePopoverController = [[TablePopoverController alloc]
                                                          initWithNibName:@"TablePopover"
                                                          bundle:[NSBundle mainBundle]];
        tablePopoverController.delegate = self;
        //set popover content size
        tablePopoverController.contentSizeForViewInPopover = CGSizeMake(320, 200);
        
        //create a popover controller
        self.popoverController = [[UIPopoverController alloc]
                                  initWithContentViewController:[[UINavigationController alloc] initWithRootViewController:tablePopoverController]];
        
        
        //present the popover view non-modal with a
        if (self.center.y > 165 && self.center.y < 175) {
            [self.popoverController presentPopoverFromRect:self.frame
                                                    inView:self.mainView
                                  permittedArrowDirections:UIPopoverArrowDirectionUp
                                                  animated:YES];
        }
        else {
            [self.popoverController presentPopoverFromRect:self.frame
                                                    inView:self.mainView
                                  permittedArrowDirections:UIPopoverArrowDirectionAny
                                                  animated:YES];
        }
    }
}

#pragma mark - Touch event
//手指按下开始触摸
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //因為NewProjectViewController是將moveButton addSubView到ScrollView上面
    //所以這裡的touches是在ScrollView上的座標，只要有Scroll，Y值就會很大。
    //而原本的moveButton的Center也是在ScrollView上的座標。
    
    NSLog(@"我的ButtonId is :%d \n",_ButtonID);
    
    if (UIControlEventTouchUpInside) {
        [self addTarget:self action:@selector(alert) forControlEvents:UIControlEventTouchUpInside];
    }
    //獲得MoveButton在ScrollView上被Touch的座標！
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];
    self.originalPosition = self.center;
    NSLog(@"Original MoveButton Center:(%f,%f)",self.center.x,self.center.y);
    xDistance =  self.center.x - currentPoint.x;
    yDistance = self.center.y - currentPoint.y;

    if (self.center.x >145 && self.ButtonID < 13) {
        self.CheckFirst = NO;
    }
    else if (self.ButtonID > 12){
    }
    else {
        [self.delegate playSoundWhichOne:OBJECTPOP_SOUND];
       self.CheckFirst = YES;
        tempImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.ImageForObject]]];
        [tempImage setTransform:CGAffineTransformScale(tempImage.transform, 1, 1)];
        [tempImage setCenter:CGPointMake(self.originalPosition.x, self.originalPosition.y ) ];//不用減ScrollView Y軸的offset
        tempImage.alpha = 0.3;
        [self.scrollParent addSubview:tempImage ];//Original Center是在ScrollView上的座標，將圖加到ScrollView比較合理
        //要轉換到NewProjectView的座標轉換
        [self setCenter:CGPointMake(self.center.x, self.center.y - self.scrollParent.contentOffset.y)];
        //NSLog(@"center2:(%f,%f)",self.center.x,self.center.y);
        
    }
    //開始抖動翰增加shadow
    [self.layer setShadowColor:[UIColor grayColor].CGColor];
    [self.layer setShadowOpacity:1.0f];
    [self.layer setShadowRadius:10.0f];
    [self startShake];
    //self.alpha = 0.7;
    
    //這一行讓MoveButton往下跑，因為MoveButton原本是在ScrollView的座標系，突然被換到NewProjectViewController的座標系。所以要在換座標系之前把Center Y軸的offset減到。
    [self.mainView addSubview:self];
    [self.mainView bringSubviewToFront:self];
    
    
}
//手指按住移动过程
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [UIView beginAnimations:@"stalk" context:nil];
	[UIView setAnimationDuration:.001];
	[UIView setAnimationBeginsFromCurrentState:YES];
    //    if(isDrag)
    //    {
    //获得触摸在按钮的父视图中的坐标
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];
    //NSLog(@"center3:(%f,%f)",self.center.x,self.center.y);
    //移动按钮到当前触摸位置
    CGPoint newCenter = CGPointMake(currentPoint.x + xDistance, currentPoint.y + yDistance);
    self.center = newCenter;
    //self.alpha = 0.7;

    [UIView commitAnimations];
    // }
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"Touch Cancelled");
    
    if (self.center.x < 145 || self.center.y < 5){
        [self.scrollParent addSubview:self];
        self.center = _originalPosition;

        NSLog(@"TouchCnacelled originalPosition:(%f,%f)",self.center.x,self.center.y);
        [UIView beginAnimations:@"goback" context:nil];
        [UIView setAnimationDuration:0.4f];
        [UIView setAnimationBeginsFromCurrentState:YES];
        
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector: @selector(animationDidStop:finished:context:)];
        [UIView commitAnimations];
        //if (self.CheckFirst) {
        [self.tempImage removeFromSuperview];
            
        //}
    }else{
        [self LocationOfButton:self.ButtonID];
        
        [UIView beginAnimations:@"mockup" context:nil];
        [UIView setAnimationDuration:0.4f];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.center = self.temp;
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector: @selector(animationDidStop:finished:context:)];
        [UIView commitAnimations];
       
        //[self.popoverController dismissPopoverAnimated:YES];

    }
    //關閉抖動跟clear shadow
    [self.layer setShadowColor:[UIColor clearColor].CGColor];
    self.alpha = 1.0;
    [self stopShake];
}
//手指放開的瞬間決定動作
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
     NSLog(@"TouchEnd1");//1)沒有move就不會跑到TouchEnd，只會跑到TouchBegin就結束
                        //2)留下殘影，是因為沒有跑到TouchEnd
    
    DataClass *obj = [DataClass getInstance];
    if([obj TotalButtons] >= 12){
        self.ObjectIsFull = YES;
    }
    else{
        self.ObjectIsFull = NO;
    }
    if (!self.CheckFirst&&self.center.x <145){//不是第一次拉出來的物件&&移動結束點在物件區=被刪除掉  8/14
        [self isInsideRecycleBin:self touching:YES];

    }else if ([self isInsertRegion:self]){
        NSLog(@"This is first condition!!!\n");
        
        [self.delegate playSoundWhichOne:OBJECTINSERT_SOUND];
        NSLog(@"Play Sound~~~~~~~~~~~~");
        DataClass *obj = [DataClass getInstance];
        
      if (!self.CheckFirst) {

          if (self.ButtonID < self.InsertID) {
              self.InsertID = self.InsertID - 1;
          }
        [obj DeleteMoveButton:self.ButtonID];
        [obj ForwardReplace:self.ButtonID];
        for (int i = 1; i < [obj TotalButtons]+1; i++) {
            //NSLog(@"This is for loop~~~\n");
            [UIView beginAnimations:@"ForwarReplace" context:nil];
            [UIView setAnimationDuration:0.4f];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [obj ButtonOfIndex:i].center = [self LocationOfButton:i];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector: @selector(animationDidStop:finished:context:)];
            [UIView commitAnimations];
            [obj ButtonOfIndex:i].ButtonID = i;
        }
        if (self.InsertID > [obj TotalButtons]) {
            self.InsertID = [obj TotalButtons]+1;//因為換位是先delete在insert所以此時的TotalButtons要加1
        }
        
        [obj BackwardReplace:self.InsertID];
        [obj InsertInArray:self IndexOfInsert:self.InsertID];

        for (int i = 0; i < [obj TotalButtons]+1; i++) {
            [UIView beginAnimations:@"BackwardReplace" context:nil];
            [UIView setAnimationDuration:0.4f];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [obj ButtonOfIndex:i].center = [self LocationOfButton:i];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector: @selector(animationDidStop:finished:context:)];
            [UIView commitAnimations];
            [obj ButtonOfIndex:i].ButtonID = i;
        }
      }//不是第一次拉出來的換位
      else if(self.CheckFirst && !self.ObjectIsFull){
          if (self.InsertID > [obj TotalButtons]) {
              self.InsertID = [obj TotalButtons]+1;//因為換位是先delete在insert所以此時的TotalButtons要加1
          }
          
          NSLog(@"InsertID is : %d\n",self.InsertID);
          [obj BackwardReplace:self.InsertID];
          
          if ( !self.ObjectIsFull) {
              
              if (obj.NumberOfObject < 12) {
                  obj.NumberOfObject++;
              }
                  self.ButtonID = self.InsertID;
                  
                  switch (self.ObjectClass) {
                      case ANGLE:
                          [self.delegate AngleAction:[self LocationOfButton:self.ButtonID] WithId:self.InsertID];
                          break;
                      case LED:
                          [self.delegate LightButton:[self LocationOfButton:self.ButtonID] WithId:self.InsertID];
                          break;
                      case VIBRATION:
                          [self.delegate VibrationButton:[self LocationOfButton:self.ButtonID] WithId:self.InsertID];
                          break;
                      case SPEAKER:
                          [self.delegate SpeakerButton:[self LocationOfButton:self.ButtonID] WithId:self.InsertID];
                          break;
                      case BUTTON:
                          [self.delegate BButton:[self LocationOfButton:self.ButtonID] WithId:self.InsertID];
                          break;
                      case TILT:
                          [self.delegate TiltButton:[self LocationOfButton:self.ButtonID] WithId:self.InsertID];
                          break;
                      case LIQUID:
                          [self.delegate LiquidButton:[self LocationOfButton:self.ButtonID] WithId:self.InsertID];
                          break;
                      case SOUNDSENSOR:
                          [self.delegate SoundButton:[self LocationOfButton:self.ButtonID] WithId:self.InsertID];
                          break;
                      case LIGHTSENSOR:
                          [self.delegate LightSensor:[self LocationOfButton:self.ButtonID] WithId:self.InsertID];
                          break;
                      case PRESSURESENSOR:
                          [self.delegate Pressure:[self LocationOfButton:self.ButtonID] WithId:self.InsertID];
                          break;
                      case IPADBUTTON:
                          [self.delegate IPadButton:[self LocationOfButton:self.ButtonID] WithId:self.InsertID];
                          break;
                      case RESET:
                          [self.delegate ResetAction:[self LocationOfButton:self.ButtonID] WithId:self.InsertID];
                          break;
                      case IPADSOUND:
                          [self.delegate IPadSound:[self LocationOfButton:self.ButtonID] WithId:self.InsertID];
                          break;
                      default:
                          break;
                  }
                  
                  [self.tempImage removeFromSuperview];
                  self.center = _originalPosition;
                  [self.scrollParent addSubview:self];
                  self.ButtonID = 0;
              

          }

          for (int i = 0; i < [obj TotalButtons]+1; i++) {
              [UIView beginAnimations:@"BackwardReplace" context:nil];
              [UIView setAnimationDuration:0.4f];
              [UIView setAnimationBeginsFromCurrentState:YES];
              [obj ButtonOfIndex:i].center = [self LocationOfButton:i];
              [UIView setAnimationDelegate:self];
              [UIView setAnimationDidStopSelector: @selector(animationDidStop:finished:context:)];
              [UIView commitAnimations];
              [obj ButtonOfIndex:i].ButtonID = i;
          }
      }
      else{
          
          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning!"
                                                          message:@"最大限制物件數為12個,若要新增請先移除. 謝謝合作 :)"
                                                         delegate:self
                                                cancelButtonTitle:@"確定"
                                                otherButtonTitles:nil, nil];
          
          alert.alertViewStyle = UIAlertViewStyleDefault;
          [alert show];
          //超過12個 ,do nothing
          [UIView beginAnimations:@"goback" context:nil];
          [UIView setAnimationDuration:0.4f];
          [UIView setAnimationBeginsFromCurrentState:YES];
          self.center = _originalPosition;
          [UIView setAnimationDelegate:self];
          [UIView setAnimationDidStopSelector: @selector(animationDidStop:finished:context:)];
          [UIView commitAnimations];
          if (self.CheckFirst) {
              [self.tempImage removeFromSuperview];
              [self.scrollParent addSubview:self];
              self.ButtonID = 0;
          }
      }
    }
     else if (self.center.x < 145 || self.center.y < 5 ){
        NSLog(@"This is Second condition!!!\n");
        [self.scrollParent addSubview:self];
        self.center = _originalPosition;
        [self.tempImage removeFromSuperview];
        // NSLog(@"(%f,%f)",self.scrollParent.scrollEnabled:y);
        NSLog(@"(TouchEnd2!!)");
    
     }
     else if (self.center.x >145){
        NSLog(@"This is third condition!!!");
        
        [self.delegate playSoundWhichOne:OBJECTINSERT_SOUND];
        NSLog(@"Play Sound!!!");
        
        DataClass *obj = [DataClass getInstance];
        [self MakeObject:obj.NumberOfObject];
    }
     else{
         
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning!"
                                                         message:@"最大限制物件數為12個,若要新增請先移除. 謝謝合作 :)"
                                                        delegate:self
                                               cancelButtonTitle:@"確定"
                                               otherButtonTitles:nil, nil];
         
         alert.alertViewStyle = UIAlertViewStyleDefault;
         [alert show];
        //超過12個 ,do nothing
        [UIView beginAnimations:@"goback" context:nil];
        [UIView setAnimationDuration:0.4f];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.center = _originalPosition;
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector: @selector(animationDidStop:finished:context:)];
        [UIView commitAnimations];
        if (self.CheckFirst) {
            [self.tempImage removeFromSuperview];
            [self.scrollParent addSubview:self];
            self.ButtonID = 0;
        }
    }
    
    
    //關閉抖動跟clear shadow
    [self.layer setShadowColor:[UIColor clearColor].CGColor];
    self.alpha = 1.0;
    [self stopShake];
}

//產生物件
-(void)MakeObject:(int)buttonId{
    
    DataClass *obj = [DataClass getInstance];
    if([obj TotalButtons] >= 12){
        self.ObjectIsFull = YES;
    }
    else{
        self.ObjectIsFull = NO;
    }
    
    if ( !self.ObjectIsFull) {

        //檢查是否為第一次從物件區拖拉物件出來
        if (self.CheckFirst ) {
            DataClass *obj = [DataClass getInstance];
            if (obj.NumberOfObject < 12) {
                obj.NumberOfObject++;
                buttonId++;
            }
            self.ButtonID = buttonId;
            
            switch (self.ObjectClass) {
                case ANGLE:
                    [self.delegate AngleAction:[self LocationOfButton:self.ButtonID] WithId:self.ButtonID];
                    break;
                case LED:
                    [self.delegate LightButton:[self LocationOfButton:self.ButtonID] WithId:self.ButtonID ];
                    break;
                case VIBRATION:
                    [self.delegate VibrationButton:[self LocationOfButton:self.ButtonID] WithId:self.ButtonID];
                    break;
                case SPEAKER:
                    [self.delegate SpeakerButton:[self LocationOfButton:self.ButtonID] WithId:self.ButtonID];
                    break;
                case BUTTON:
                    [self.delegate BButton:[self LocationOfButton:self.ButtonID] WithId:self.ButtonID];
                    break;
                case TILT:
                    [self.delegate TiltButton:[self LocationOfButton:self.ButtonID] WithId:self.ButtonID];
                    break;
                case LIQUID:
                    [self.delegate LiquidButton:[self LocationOfButton:self.ButtonID] WithId:self.ButtonID];
                    break;
                case SOUNDSENSOR:
                    [self.delegate SoundButton:[self LocationOfButton:self.ButtonID] WithId:self.ButtonID];
                    break;
                case LIGHTSENSOR:
                    [self.delegate LightSensor:[self LocationOfButton:self.ButtonID] WithId:self.ButtonID];
                    break;
                case PRESSURESENSOR:
                    [self.delegate Pressure:[self LocationOfButton:self.ButtonID] WithId:self.ButtonID];
                    break;
                case IPADBUTTON:
                    [self.delegate IPadButton:[self LocationOfButton:self.ButtonID] WithId:self.ButtonID];
                    break;
                case RESET:
                    [self.delegate ResetAction:[self LocationOfButton:self.ButtonID] WithId:self.ButtonID];
                    break;
                case IPADSOUND:
                    [self.delegate IPadSound:[self LocationOfButton:self.ButtonID] WithId:self.ButtonID];
                    break;
                default:
                    break;
            }
            
            [self.tempImage removeFromSuperview];
            self.center = _originalPosition;
            [self.scrollParent addSubview:self];
            self.ButtonID = 0;
            
            if (obj.NumberOfObject == 12) {
                self.ObjectIsFull = YES;
            }
        }
        else{
            [self LocationOfButton:self.ButtonID];
            
            [UIView beginAnimations:@"mockup" context:nil];
            [UIView setAnimationDuration:0.4f];
            [UIView setAnimationBeginsFromCurrentState:YES];
            self.center = self.temp;
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector: @selector(animationDidStop:finished:context:)];
            [UIView commitAnimations];
        }
    }
    else if (self.ObjectIsFull){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning!"
                                                        message:@"最大限制物件數為12個,若要新增請先移除. 謝謝合作 :)"
                                                       delegate:self
                                              cancelButtonTitle:@"確定"
                                              otherButtonTitles:nil, nil];
        
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
        
        //超過12個 ,do nothing
        [UIView beginAnimations:@"goback" context:nil];
        [UIView setAnimationDuration:0.4f];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.center = _originalPosition;
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector: @selector(animationDidStop:finished:context:)];
        [UIView commitAnimations];
        if (self.CheckFirst) {
            [self.tempImage removeFromSuperview];
            [self.scrollParent addSubview:self];
            self.ButtonID = 0;
        }
    }
    
}

#pragma mark - 決定Button位置的method

-(CGPoint) LocationOfButton :(int)buttonId{
    switch (buttonId) {
        case 1:
            self.temp = CGPointMake(345, 170);
            break;
        case 2:
            self.temp = CGPointMake(500, 170);
            break;
        case 3:
            self.temp = CGPointMake(655, 170);
            break;
        case 4:
            self.temp = CGPointMake(810, 170);
            break;
        case 5:
            self.temp = CGPointMake(963, 308);
            break;
        case 6:
            self.temp = CGPointMake(963, 450);
            break;
        case 7:
            self.temp = CGPointMake(810, 600);
            break;
        case 8:
            self.temp = CGPointMake(655, 600);
            break;
        case 9:
            self.temp = CGPointMake(500, 600);
            break;
        case 10:
            self.temp = CGPointMake(345, 600);
            break;
        case 11:
            self.temp = CGPointMake(242, 450);
            break;
        case 12:
            self.temp = CGPointMake(242, 308);
            break;
            
        default:
            self.temp = CGPointMake(580, 330);
            break;
    }
    
    return self.temp;
    
}
-(BOOL) isInsideRecycleBin:(MoveButton *)button touching:(BOOL)finished{
    
    DataClass *obj = [DataClass getInstance];
    
    //CGRect binFrame = CGRectMake(966, 641, 60, 60);
    
    if (button.center.x<145){//CGRectIntersectsRect(binFrame, button.frame) == TRUE
        if (finished){
            self.RemoveBtnID = self.ButtonID;
            obj.RemoveID = self.RemoveBtnID;
            if (obj.NumberOfObject > 0 && self.originalPosition.x > 145) {
                obj.NumberOfObject--;
                [self RemoveButton:self.ButtonID];
                
                [button removeFromSuperview];
                if (obj.NumberOfObject < 12) {
                self.ObjectIsFull = NO;
            }
            }
            
            
    
            NSLog(@"AfterREmove number is:%d\n",obj.NumberOfObject);
    
            [self.delegate playSoundWhichOne:TRASH_SOUND];
            
            //刪除動畫
            UIImageView * animation = [[UIImageView alloc] init];
            animation.frame = CGRectMake(self.center.x - 32, self.center.y - 32, 60, 60);
            animation.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed: @"iconEliminateItem1.png"],
                                         [UIImage imageNamed: @"iconEliminateItem2.png"],
                                         [UIImage imageNamed: @"iconEliminateItem3.png"],
                                         [UIImage imageNamed: @"iconEliminateItem4.png"]
                                         ,nil];
            [animation setAnimationRepeatCount:1];
            [animation setAnimationDuration:0.35];
            [animation startAnimating];
            [self.mainView addSubview:animation];
            [animation bringSubviewToFront:self.mainView];

        
        }
        return YES;
    }
    else {
        return NO;
    }
}
-(void)RemoveButton:(int)removeID{
    
    NSLog(@"removeID is: %d",removeID);
    DataClass *obj = [DataClass getInstance];
    [obj DeleteMoveButton:removeID];
    [obj ForwardReplace:removeID];
    
    for (int i = 0; i < [obj TotalButtons]+1; i++) {//?
        [UIView beginAnimations:@"ForwarReplace" context:nil];
        [UIView setAnimationDuration:0.4f];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [obj ButtonOfIndex:i].center = [self LocationOfButton:i];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector: @selector(animationDidStop:finished:context:)];
        [UIView commitAnimations];
        [obj ButtonOfIndex:i].ButtonID = i;
    }
}
-(BOOL) isInsertRegion:(MoveButton *)button{
    
    if (CGRectIntersectsRect(self.frame, self.InsertFrame1)||CGRectIntersectsRect(self.frame, self.InsertFrame2)||CGRectIntersectsRect(self.frame, self.InsertFrame3)||CGRectIntersectsRect(self.frame, self.InsertFrame4)||CGRectIntersectsRect(self.frame, self.InsertFrame5)||CGRectIntersectsRect(self.frame, self.InsertFrame7)||CGRectIntersectsRect(self.frame, self.InsertFrame8)||CGRectIntersectsRect(self.frame, self.InsertFrame9)||CGRectIntersectsRect(self.frame, self.InsertFrame10)||CGRectIntersectsRect(self.frame, self.InsertFrame11)||CGRectIntersectsRect(self.frame, self.InsertFrame12)){
        
        if (CGRectIntersectsRect(self.frame, self.InsertFrame1)){
            self.InsertID = 2;
        }
        if (CGRectIntersectsRect(self.frame, self.InsertFrame2)){
            self.InsertID = 3;
        }
        if (CGRectIntersectsRect(self.frame, self.InsertFrame3)){
            self.InsertID = 4;
        }
        if (CGRectIntersectsRect(self.frame, self.InsertFrame4)){
            self.InsertID = 5;
        }
        if (CGRectIntersectsRect(self.frame, self.InsertFrame5)){
            self.InsertID = 6;
        }
        if (CGRectIntersectsRect(self.frame, self.InsertFrame6)){
            self.InsertID = 7;
        }
        if (CGRectIntersectsRect(self.frame, self.InsertFrame7)){
            self.InsertID = 8;
        }
        if (CGRectIntersectsRect(self.frame, self.InsertFrame8)){
            self.InsertID = 9;
        }
        if (CGRectIntersectsRect(self.frame, self.InsertFrame9)){
            self.InsertID = 10;
        }
        if (CGRectIntersectsRect(self.frame, self.InsertFrame10)){
            self.InsertID = 11;
        }
        if (CGRectIntersectsRect(self.frame, self.InsertFrame11)){
            self.InsertID = 12;
        }
        if (CGRectIntersectsRect(self.frame, self.InsertFrame12)){
            self.InsertID = 1;
        }
        return YES;
    }
    else {
        return NO;
    }
}

#pragma mark - Shaking button object when moving

- (void)startShake{
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    shakeAnimation.duration = 0.08;
    shakeAnimation.autoreverses = YES;
    shakeAnimation.repeatCount = MAXFLOAT;
    shakeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, -0.1, 0, 0, 1)];
    shakeAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, 0.1, 0, 0, 1)];
    
    [self.layer addAnimation:shakeAnimation forKey:@"shakeAnimation"];
}
- (void)stopShake{
    [self.layer removeAnimationForKey:@"shakeAnimation"];
}

#pragma mark - 接popover table傳回的資料並處理的method

- (void)didSelectRowWithAct:(NSString*)act
{
    [self.label setText:act];
    switch (self.ObjectClass) {
        case LED: {
            if ([act isEqualToString:@"Off"]) {
                self.ObjectAct = LED_OFF;
                self.ObjectInputParameter = -1;
                self.ObjectOutputParameter = -1;
            }
            else {  //Light
                self.ObjectAct = LED_LIGHT;
                self.ObjectInputParameter = -1;   //無/Input 0or1
                self.ObjectOutputParameter = -1;
            }
            break;
        }
        case VIBRATION: {
            if ([act isEqualToString:@"Off"]) {
                self.ObjectAct = VIBRATION_OFF;
                self.ObjectInputParameter = -1;
                self.ObjectOutputParameter = -1;
            }
            else {  //Vibrate
                self.ObjectAct = VIBRATION_VIBRATE;
                self.ObjectInputParameter = -1;   //無/Input 0or1
                self.ObjectOutputParameter = -1;
            }
            break;
        }
        case SPEAKER: {
            if ([act isEqualToString:@"Off"]) {
                self.ObjectAct = SPEAKER_OFF;
                self.ObjectInputParameter = -1;
                self.ObjectOutputParameter = -1;
            }
            else {  //On
                self.ObjectAct = SPEAKER_ON;
                self.ObjectInputParameter = -1;   //無/Input 0or1
                self.ObjectOutputParameter = -1;
            }
            break;
        }
        case BUTTON: {
            [self setBackgroundImage:[UIImage imageNamed:@"編輯區-黃框.png"] forState:UIControlStateNormal];
            self.ObjectAct = BUTTON_READ;
            self.ObjectInputParameter = -1;
            self.ObjectOutputParameter = 0;   //Output 0or1
            break;
        }
        case TILT: {
            [self setBackgroundImage:[UIImage imageNamed:@"編輯區-黃框.png"] forState:UIControlStateNormal];
            self.ObjectAct = TILT_READ;
            self.ObjectInputParameter = -1;
            self.ObjectOutputParameter = 0;   //Output 0or1
            break;
        }
        case LIQUID: {
            [self setBackgroundImage:[UIImage imageNamed:@"編輯區-黃框.png"] forState:UIControlStateNormal];
            self.ObjectAct = LIQUID_READ;
            self.ObjectInputParameter = -1;
            self.ObjectOutputParameter = 0;   //Output 0or1
            break;
        }
        case ANGLE: {
            [self setBackgroundImage:[UIImage imageNamed:@"編輯區-黃框.png"] forState:UIControlStateNormal];
            self.ObjectAct = ANGLE_READ;
            self.ObjectInputParameter = -1;
            self.ObjectOutputParameter = 0;   //0~1023(浮動)
            break;
        }
        case SOUNDSENSOR: {
            [self setBackgroundImage:[UIImage imageNamed:@"編輯區-黃框.png"] forState:UIControlStateNormal];
            self.ObjectAct = SOUNDSENSOR_READ;
            self.ObjectInputParameter = -1;
            self.ObjectOutputParameter = 0;   //0~1023(浮動)
            break;
        }
        case LIGHTSENSOR: {
            if ([act isEqualToString:@"Read"]) {
                [self setBackgroundImage:[UIImage imageNamed:@"編輯區-黃框.png"] forState:UIControlStateNormal];
                self.ObjectAct = LIGHTSENSOR_READ;
                self.ObjectInputParameter = -1;
                self.ObjectOutputParameter = 0;   //0~1023(浮動)
            }
            else {  //Remember
                [self setBackgroundImage:[UIImage imageNamed:@"編輯區-黃框.png"] forState:UIControlStateNormal];
                self.ObjectAct = LIGHTSENSOR_REMEMBER;
                self.ObjectInputParameter = -1;
                self.ObjectOutputParameter = 0;   //0~1023(固定)
            }
            break;
        }
        case PRESSURESENSOR: {
            if ([act isEqualToString:@"Read"]) {
                [self setBackgroundImage:[UIImage imageNamed:@"編輯區-黃框.png"] forState:UIControlStateNormal];
                self.ObjectAct = PRESSURESENSOR_READ;
                self.ObjectInputParameter = -1;
                self.ObjectOutputParameter = 0;   //0~1023(浮動)
            }
            else {  //Remember
                [self setBackgroundImage:[UIImage imageNamed:@"編輯區-黃框.png"] forState:UIControlStateNormal];
                self.ObjectAct = PRESSURESENSOR_REMEMBER;
                self.ObjectInputParameter = -1;
                self.ObjectOutputParameter = 0;   //0~1023(固定)
            }
            break;
        }
        case IPADBUTTON: {
            if ([act isEqualToString:@"Read"]) {
                [self setBackgroundImage:[UIImage imageNamed:@"編輯區-黃框.png"] forState:UIControlStateNormal];
                self.ObjectAct = IPADBUTTON_READ;
                self.ObjectInputParameter = -1;
                self.ObjectOutputParameter = 0;   //Output 0or1
            }
            else {
                [self setBackgroundImage:[UIImage imageNamed:@"編輯區-紅框.png"] forState:UIControlStateNormal];
                self.ObjectAct = IPADBUTTON_CLICK;
                self.ObjectInputParameter = -1;
                self.ObjectOutputParameter = 0;   //Output 0or1
            }
            break;
        }
        default: {  //IPADSOUND
            if ([act isEqualToString:@"Off"]) {
                self.ObjectAct = IPADSOUND_OFF;
            }
            else {  //alarm
                self.ObjectAct = IPADSOUND_ALARM;
            }
            break;
        }
    }
    [self.popoverController dismissPopoverAnimated:YES];
}

- (void)didLv2WithAct:(NSString *)act andLv2Act:(NSString *)act2
{
    
    [self.label setText:act];
    switch (self.ObjectClass) {
        case BUTTON:
        {
            [self setBackgroundImage:[UIImage imageNamed:@"編輯區-紅框.png"] forState:UIControlStateNormal];
            self.ObjectAct = BUTTON_CLICK;
            if ([act2 isEqualToString:@"按下通過"]) {
                self.ObjectOutputParameter = 1;    //1按下通過/0不按下通過
            }
            else {  //沒按下通過
                self.ObjectOutputParameter = 0;
            }
            break;
        }
        case TILT:
        {
            [self setBackgroundImage:[UIImage imageNamed:@"編輯區-紅框.png"] forState:UIControlStateNormal];
            self.ObjectAct = TILT_TILT;
            if ([act2 isEqualToString:@"傾斜通過"]) {
                self.ObjectOutputParameter = 1;    //1傾斜通過/0不傾斜通過
            }
            else {
                self.ObjectOutputParameter = 0;
            }
            break;
        }
        case LIQUID:
        {
            [self setBackgroundImage:[UIImage imageNamed:@"編輯區-紅框.png"] forState:UIControlStateNormal];
            self.ObjectAct = LIQUID_WET;
            if ([act2 isEqualToString:@"有感測到液體通過"]) {
                self.ObjectOutputParameter = 1;    //1有碰觸到液體通過/0沒碰觸到液體通過
            }
            else {
                self.ObjectOutputParameter = 0;
            }
            break;
        }
        default:    //IPADSOUND
        {
            self.ObjectAct = IPADSOUND_MELODY;
            
            // Do Something to play system sound
            
            break;
        }
    }
    
    [self.popoverController dismissPopoverAnimated:YES];
}
- (void)magic{
    
}

- (void)didLv2WithAct:(NSString*)act andvalue:(float)value
{
    [self.delegate playSoundWhichOne:CLICKDONE_SOUND];
    [self.label setText:act];
    switch (self.ObjectClass) {
        case LED:
        {
            if ([act isEqualToString:@"Blink"]) {
                self.ObjectAct = LED_BLINK;
                self.ObjectInputParameter = value;    //25~255(arduino再乘3)/Input0~1023再map
                self.ObjectOutputParameter = -1;
            }
            else {  //Fade
                //先判斷之前是否有LED Object，行為是Fade，就使用同一個Pin腳
                DataClass *obj = [DataClass getInstance];
                
                for (int i = 1; i < [obj TotalButtons]+1; i++) {
                    
                    if([obj ButtonOfIndex:i].ObjectClass == self.ObjectClass){
                        if([obj ButtonOfIndex:i].ObjectAct==LED_FADE){
                            self.ObjectPin=[obj ButtonOfIndex:i].ObjectPin;                
                            break;
                        }
                    }
                }
                //判斷是否原本或是已換為3,5,6 若是，就確定轉成Fade行為
                if (self.ObjectPin == 3 || self.ObjectPin == 5 || self.ObjectPin == 6) {
                    self.ObjectAct = LED_FADE;
                    self.ObjectInputParameter = value;  // 5~180
                    self.ObjectOutputParameter = -1;
                }else{
                    int pwm_pin = [obj setNewPWMPin:self];
                    if (pwm_pin > 0) {
                        self.ObjectPin = pwm_pin;
                        NSLog(@"還是有近來...");
                        ////////////DataClass 要將物件原本安排的pin腳釋出/////////////////
                        
                        self.ObjectAct = LED_FADE;
                        self.ObjectInputParameter = value;  // 5~180
                        self.ObjectOutputParameter = -1;
                    }
                    else {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"無法使用pwm行為" message:@"使用的物件過多，無法使用fade行為" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                    }
                }
                
            }
            break;
        }
        case SPEAKER:
        {
            self.ObjectAct = SPEAKER_ALARM;
            self.ObjectInputParameter = value;    //25~255(arduino再乘3)/Input0~1023再map
            self.ObjectOutputParameter = -1;
            break;
        }
        case VIBRATION:
        {
            self.ObjectAct = VIBRATION_INTERVAL_VIBRATE;
            self.ObjectInputParameter = value;    //25~255(arduino再乘3)/Input0~1023再map
            self.ObjectOutputParameter = -1;
            break;
        }
        default:    //IPADSOUND
        {
            self.ObjectAct = IPADSOUND_ALARM;
            break;
        }
    }
    [self.popoverController dismissPopoverAnimated:YES];
}

- (void)didLv2WithAct:(NSString *)act andvalue:(float)value byGreaterOrLessthan:(NSString *)GreaterOrLessthan
{
    //比較input傳進來的數值是否大於或小於所設定的標準值(slider的值)
    [self.delegate playSoundWhichOne:CLICKDONE_SOUND];
    [self.label setText:act];
    switch (self.ObjectClass) {
        case ANGLE:
        {
            [self setBackgroundImage:[UIImage imageNamed:@"編輯區-紅框.png"] forState:UIControlStateNormal];
            self.ObjectAct = ANGLE_THRESHOLD;
            self.ObjectInputParameter = -1;  //0~1023/Input0~1023  arduino傳來的值
            
            if ([GreaterOrLessthan isEqualToString:@"Greater"]) {
                self.ObjectOutputParameter = value; //  value的值用正負區分存在outputparameter裡，正的話代表條件為input的值要大於value，負則代表條件為input的值要小於value
            }
            else { //[GreaterOrLessthan isEqualToString:@"Less"]
                self.ObjectOutputParameter = -value;
            }
            
            break;
        }
        case SOUNDSENSOR:
        {
            [self setBackgroundImage:[UIImage imageNamed:@"編輯區-紅框.png"] forState:UIControlStateNormal];
            self.ObjectAct = SOUNDSENSOR_THRESHOLD;
            self.ObjectInputParameter = -1;  //0~1023/Input0~1023
            
            if ([GreaterOrLessthan isEqualToString:@"Greater"]) {
                self.ObjectOutputParameter = value;
            }
            else { //[GreaterOrLessthan isEqualToString:@"Less"]
                self.ObjectOutputParameter = -value;
            }
            
            break;
        }
        case LIGHTSENSOR:
        {
            [self setBackgroundImage:[UIImage imageNamed:@"編輯區-紅框.png"] forState:UIControlStateNormal];
            if ([act isEqualToString:@"Threshold"]) {
                self.ObjectAct = LIGHTSENSOR_THRESHOLD;
                self.ObjectInputParameter = -1;    //0~1023/Input0~1023
                if ([GreaterOrLessthan isEqualToString:@"Greater"]) {
                    self.ObjectOutputParameter = value;
                }
                else { //[GreaterOrLessthan isEqualToString:@"Less"]
                    self.ObjectOutputParameter = -value;
                }
            }
            else {  //Change    比較input傳進來的數值是否在所設的變動率內(slider的值)
                self.ObjectAct = LIGHTSENSOR_CHANGE;
                self.ObjectInputParameter = 0;    //比較值0~1023/Input0~1023
                self.ObjectOutputParameter = -1; //變動率30~800   
            }
            break;
        }
        default: {  //PRESSURESENSOR
            [self setBackgroundImage:[UIImage imageNamed:@"編輯區-紅框.png"] forState:UIControlStateNormal];
            if ([act isEqualToString:@"Threshold"]) {
                self.ObjectAct = PRESSURESENSOR_THRESHOLD;
                self.ObjectInputParameter = -1;    //0~1023/Input0~1023
                if ([GreaterOrLessthan isEqualToString:@"Greater"]) {
                    self.ObjectOutputParameter = value;
                }
                else { //[GreaterOrLessthan isEqualToString:@"Less"]
                    self.ObjectOutputParameter = -value;
                }
            }
            else {  //Change
                self.ObjectAct = PRESSURESENSOR_CHANGE;
                self.ObjectInputParameter = 0;    //比較值0~1023/Input0~1023
                self.ObjectOutputParameter = -1;  //變動率30~800  
            }
            break;
        }
    }
    [self.popoverController dismissPopoverAnimated:YES];
}

@end
