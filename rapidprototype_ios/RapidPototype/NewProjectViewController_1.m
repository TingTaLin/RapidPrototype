//
//  NewProjectViewController_1.m
//  RapidPototype
//
//  Created by 林震軒 on 13/5/31.
//  Copyright (c) 2013年 林震軒. All rights reserved.
//

#import "NewProjectViewController_1.h"
#import "ProjectName.h"
#import "MoveButton.h"
#import "dot.h"

#import "DataClass.h"

@interface NewProjectViewController_1 ()

@end
@implementation NewProjectViewController_1
@synthesize receiveID;
@synthesize popoverController;
@synthesize runobjectaction;

int padding = 3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.ReceiveID = receiveID;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil title:(NSString *)title bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        [self.navigationItem setTitle:title];
        // Custom initialization
        //self.ReceiveID = receiveID;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
}

- (void)viewWillDisappear:(BOOL)animated
{
    [runobjectaction BlueToothDisconnect];
}

- (void)viewDidLoad
{
    
    [DataClass clearInstance];
    
    self.PinsDiagram.layer.borderWidth = 5.0f;
    self.PinsDiagram.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.PinsDiagram.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.6, 0.6);

    
    
    
    DataClass *obj = [DataClass getInstance];
    obj.NumberOfObject = 0;
    NSLog(@"DataClass number is:%d\n",obj.NumberOfObject);
    
    [self.Scroll_ChoosingItems setScrollEnabled:YES];
    [self.Scroll_ChoosingItems setContentSize:CGSizeMake(169, 2640)];
    
    runobjectaction = [[RunObjectAction alloc] init];
    runobjectaction.delegate = self;
    self.isBLEConnect = false;  //initail
    
    // create the sound
	NSString *sndpath = [[NSBundle mainBundle] pathForResource:@"connectingSound" ofType:@"wav"];
	CFURLRef baseURL = (__bridge CFURLRef)[NSURL fileURLWithPath:sndpath];
	
	// Identify it as not a UI Sound
    AudioServicesCreateSystemSoundID(baseURL, &connectingSound);
	AudioServicesPropertyID flag = 0;  // 0 means always play
	AudioServicesSetProperty(kAudioServicesPropertyIsUISound, sizeof(SystemSoundID), &connectingSound, sizeof(AudioServicesPropertyID), &flag);
    
	NSString *sndpath2 = [[NSBundle mainBundle] pathForResource:@"disconnectSound" ofType:@"wav"];
	CFURLRef baseURL2 = (__bridge CFURLRef)[NSURL fileURLWithPath:sndpath2];
	
    AudioServicesCreateSystemSoundID(baseURL2, &disconnectSound);
	AudioServicesSetProperty(kAudioServicesPropertyIsUISound, sizeof(SystemSoundID), &disconnectSound, sizeof(AudioServicesPropertyID), &flag);
    
	NSString *sndpath3 = [[NSBundle mainBundle] pathForResource:@"objectpopSound" ofType:@"wav"];
	CFURLRef baseURL3 = (__bridge CFURLRef)[NSURL fileURLWithPath:sndpath3];
	
    AudioServicesCreateSystemSoundID(baseURL3, &objectpopSound);
	AudioServicesSetProperty(kAudioServicesPropertyIsUISound, sizeof(SystemSoundID), &objectpopSound, sizeof(AudioServicesPropertyID), &flag);
    
    NSString *sndpath4 = [[NSBundle mainBundle] pathForResource:@"objectinsertSound" ofType:@"wav"];
	CFURLRef baseURL4 = (__bridge CFURLRef)[NSURL fileURLWithPath:sndpath4];
	
    AudioServicesCreateSystemSoundID(baseURL4, &objectinsertSound);
	AudioServicesSetProperty(kAudioServicesPropertyIsUISound, sizeof(SystemSoundID), &objectinsertSound, sizeof(AudioServicesPropertyID), &flag);
    
    NSString *sndpath5 = [[NSBundle mainBundle] pathForResource:@"trashSound" ofType:@"wav"];
	CFURLRef baseURL5 = (__bridge CFURLRef)[NSURL fileURLWithPath:sndpath5];
	
    AudioServicesCreateSystemSoundID(baseURL5, &trashSound);
	AudioServicesSetProperty(kAudioServicesPropertyIsUISound, sizeof(SystemSoundID), &trashSound, sizeof(AudioServicesPropertyID), &flag);
    
    NSString *sndpath6 = [[NSBundle mainBundle] pathForResource:@"popoverSound" ofType:@"wav"];
	CFURLRef baseURL6 = (__bridge CFURLRef)[NSURL fileURLWithPath:sndpath6];
	
    AudioServicesCreateSystemSoundID(baseURL6, &popoverSound);
	AudioServicesSetProperty(kAudioServicesPropertyIsUISound, sizeof(SystemSoundID), &popoverSound, sizeof(AudioServicesPropertyID), &flag);
    
    NSString *sndpath7 = [[NSBundle mainBundle] pathForResource:@"clickdoneSound" ofType:@"mp3"];
	CFURLRef baseURL7 = (__bridge CFURLRef)[NSURL fileURLWithPath:sndpath7];
	
    AudioServicesCreateSystemSoundID(baseURL7, &clickdoneSound);
	AudioServicesSetProperty(kAudioServicesPropertyIsUISound, sizeof(SystemSoundID), &clickdoneSound, sizeof(AudioServicesPropertyID), &flag);
/*----------------------------------------------------------------------------------------------------
 
                                          用程式create button種類
 
 ----------------------------------------------------------------------------------------------------*/
    
#pragma mark - init 圖型化物件區的 MoveButton
    
    //LED Button
    MoveButton *Object_Light = [[MoveButton alloc] initWithFrame:CGRectMake(35, 28, 100, 100) WithParentView:self.view WithObjectType:LED WithButtonID:obj.NumberOfObject];
    [Object_Light setBackgroundImage:[UIImage imageNamed:@"物件區-Light.png"] forState:UIControlStateNormal];
    Object_Light.mainView = self.view;
    Object_Light.delegate = self;
    Object_Light.scrollParent = self.Scroll_ChoosingItems;
    [self.Scroll_ChoosingItems addSubview:Object_Light];
    
    //Vibration Button
    //MoveButton *Object_Vibration = [[MoveButton alloc] initWithFrame:CGRectMake(35, 142, 100, 100) :self.view :VIBRATION];
    MoveButton *Object_Vibration = [[MoveButton alloc] initWithFrame:CGRectMake(35, 142, 100, 100) WithParentView:self.view WithObjectType:VIBRATION WithButtonID:obj.NumberOfObject];
    [Object_Vibration setBackgroundImage:[UIImage imageNamed:@"物件區-Vibration.png"] forState:UIControlStateNormal];
    Object_Vibration.mainView = self.view;
    Object_Vibration.delegate = self;
    Object_Vibration.scrollParent = self.Scroll_ChoosingItems;
    [self.Scroll_ChoosingItems addSubview:Object_Vibration];
    
    //Speaker Button
    //MoveButton *Object_Speaker = [[MoveButton alloc] initWithFrame:CGRectMake(35, 268, 100, 100) :self.view :SPEAKER];
    MoveButton *Object_Speaker = [[MoveButton alloc] initWithFrame:CGRectMake(35, 268, 100, 100) WithParentView:self.view WithObjectType:SPEAKER WithButtonID:obj.NumberOfObject];
    [Object_Speaker setBackgroundImage:[UIImage imageNamed:@"物件區-Speaker.png"] forState:UIControlStateNormal];
    Object_Speaker.mainView = self.view;
    Object_Speaker.delegate = self;
    Object_Speaker.scrollParent = self.Scroll_ChoosingItems;
    [self.Scroll_ChoosingItems addSubview:Object_Speaker];
    
    // BButton
    //MoveButton *Object_BButton = [[MoveButton alloc] initWithFrame:CGRectMake(35, 389, 100, 100) :self.view :BUTTON];
    MoveButton *Object_BButton = [[MoveButton alloc] initWithFrame:CGRectMake(35, 389, 100, 100) WithParentView:self.view WithObjectType:BUTTON WithButtonID:obj.NumberOfObject];
    [Object_BButton setBackgroundImage:[UIImage imageNamed:@"物件區-Button.png"] forState:UIControlStateNormal];
    Object_BButton.mainView = self.view;
    Object_BButton.delegate = self;
    Object_BButton.scrollParent = self.Scroll_ChoosingItems;
    [self.Scroll_ChoosingItems addSubview:Object_BButton];
    
    //Tilt Button
    //MoveButton *Object_Tilt = [[MoveButton alloc] initWithFrame:CGRectMake(35, 522, 100, 100) :self.view :TILT];
    MoveButton *Object_Tilt = [[MoveButton alloc] initWithFrame:CGRectMake(35, 522, 100, 100) WithParentView:self.view WithObjectType:TILT WithButtonID:obj.NumberOfObject];
    [Object_Tilt setBackgroundImage:[UIImage imageNamed:@"物件區-Tilt.png"] forState:UIControlStateNormal];
    Object_Tilt.mainView = self.view;
    Object_Tilt.delegate = self;
    Object_Tilt.scrollParent = self.Scroll_ChoosingItems;
    [self.Scroll_ChoosingItems addSubview:Object_Tilt];
    
    //Liquid Button
    //MoveButton *Object_Liquid = [[MoveButton alloc] initWithFrame:CGRectMake(35, 648, 100, 100) :self.view :LIQUID];
    MoveButton *Object_Liquid = [[MoveButton alloc] initWithFrame:CGRectMake(35, 648, 100, 100) WithParentView:self.view WithObjectType:LIQUID WithButtonID:obj.NumberOfObject];
    [Object_Liquid setBackgroundImage:[UIImage imageNamed:@"物件區-Liquid.png"] forState:UIControlStateNormal];
    Object_Liquid.mainView = self.view;
    Object_Liquid.delegate = self;
    Object_Liquid.scrollParent = self.Scroll_ChoosingItems;
    [self.Scroll_ChoosingItems addSubview:Object_Liquid];
    
    
    //Angle Button
   // MoveButton *Object_Angle = [[MoveButton alloc] initWithFrame:CGRectMake(35, 775, 100, 100) :self.view :ANGLE];
    MoveButton *Object_Angle = [[MoveButton alloc] initWithFrame:CGRectMake(35, 775, 100, 100) WithParentView:self.view WithObjectType:ANGLE WithButtonID:obj.NumberOfObject];
    [Object_Angle setBackgroundImage:[UIImage imageNamed:@"物件區-Angle.png"] forState:UIControlStateNormal];
    Object_Angle.mainView = self.view;
    Object_Angle.delegate = self;
    Object_Angle.scrollParent = self.Scroll_ChoosingItems;
    [self.Scroll_ChoosingItems addSubview:Object_Angle];
    
    //Sound Sensor
   // MoveButton *Object_Sound = [[MoveButton alloc] initWithFrame:CGRectMake(35, 903, 100, 100) :self.view :SOUNDSENSOR];
    MoveButton *Object_Sound = [[MoveButton alloc] initWithFrame:CGRectMake(35, 903, 100, 100) WithParentView:self.view WithObjectType:SOUNDSENSOR WithButtonID:obj.NumberOfObject];
    [Object_Sound setBackgroundImage:[UIImage imageNamed:@"物件區-Sound.png"] forState:UIControlStateNormal];
    Object_Sound.mainView = self.view;
    Object_Sound.delegate = self;
    Object_Sound.scrollParent = self.Scroll_ChoosingItems;
    [self.Scroll_ChoosingItems addSubview:Object_Sound];
    
    //LightSensor Button
    //MoveButton *Object_LightSensor = [[MoveButton alloc] initWithFrame:CGRectMake(35, 1033, 100, 100) :self.view :LIGHTSENSOR];
    MoveButton *Object_LightSensor = [[MoveButton alloc] initWithFrame:CGRectMake(35, 1033, 100, 100) WithParentView:self.view WithObjectType:LIGHTSENSOR WithButtonID:obj.NumberOfObject];
    [Object_LightSensor setBackgroundImage:[UIImage imageNamed:@"物件區LightSensor.png"] forState:UIControlStateNormal];
    Object_LightSensor.mainView = self.view;
    Object_LightSensor.delegate = self;
    Object_LightSensor.scrollParent = self.Scroll_ChoosingItems;
    [self.Scroll_ChoosingItems addSubview:Object_LightSensor];
    
    //Pressure Button
    //MoveButton *Object_Pressure = [[MoveButton alloc] initWithFrame:CGRectMake(35, 1161, 100, 100) :self.view :PRESSURESENSOR];
    MoveButton *Object_Pressure = [[MoveButton alloc] initWithFrame:CGRectMake(35, 1161, 100, 100) WithParentView:self.view WithObjectType:PRESSURESENSOR WithButtonID:obj.NumberOfObject];
    [Object_Pressure setBackgroundImage:[UIImage imageNamed:@"物件區-Pressure.png"] forState:UIControlStateNormal];
    Object_Pressure.mainView = self.view;
    Object_Pressure.delegate = self;
    Object_Pressure.scrollParent = self.Scroll_ChoosingItems;
    [self.Scroll_ChoosingItems addSubview:Object_Pressure];
    
    //iPadButton Button
   // MoveButton *Object_iPadButton = [[MoveButton alloc] initWithFrame:CGRectMake(35, 1289, 100, 100) :self.view :IPADBUTTON];
    MoveButton *Object_iPadButton = [[MoveButton alloc] initWithFrame:CGRectMake(35, 1289, 100, 100) WithParentView:self.view WithObjectType:IPADBUTTON WithButtonID:obj.NumberOfObject];
    [Object_iPadButton setBackgroundImage:[UIImage imageNamed:@"物件區-iPadButton.png"] forState:UIControlStateNormal];
    Object_iPadButton.mainView = self.view;
    Object_iPadButton.delegate = self;
    Object_iPadButton.scrollParent = self.Scroll_ChoosingItems;
    [self.Scroll_ChoosingItems addSubview:Object_iPadButton];
    
    //iPadSound Button
    //MoveButton *Object_iPadSound = [[MoveButton alloc] initWithFrame:CGRectMake(35, 1417, 100, 100) :self.view :IPADSOUND];
    MoveButton *Object_iPadSound = [[MoveButton alloc] initWithFrame:CGRectMake(35, 1417, 100, 100) WithParentView:self.view WithObjectType:IPADSOUND WithButtonID:obj.NumberOfObject];
    [Object_iPadSound setBackgroundImage:[UIImage imageNamed:@"物件區-iPadSound.png"] forState:UIControlStateNormal];
    Object_iPadSound.mainView = self.view;
    Object_iPadSound.delegate = self;
    Object_iPadSound.scrollParent = self.Scroll_ChoosingItems;
    [self.Scroll_ChoosingItems addSubview:Object_iPadSound];
    
    //Reset Button
    //MoveButton *Object_Reset = [[MoveButton alloc] initWithFrame:CGRectMake(35, 1543, 100, 100) :self.view :RESET];
    MoveButton *Object_Reset = [[MoveButton alloc] initWithFrame:CGRectMake(35, 1543, 100, 100) WithParentView:self.view WithObjectType:RESET WithButtonID:obj.NumberOfObject];
    [Object_Reset setBackgroundImage:[UIImage imageNamed:@"物件區&編輯區Reset.png"] forState:UIControlStateNormal];
    Object_Reset.mainView = self.view;
    Object_Reset.delegate = self;
    Object_Reset.scrollParent = self.Scroll_ChoosingItems;
    [self.Scroll_ChoosingItems addSubview:Object_Reset];
    
    //Next Step Button
    NextBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"Next Step"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(NextbtnClicked)];
    self.navigationItem.rightBarButtonItem = NextBtnItem;
    
//    dot *test = [[dot alloc] initWithPoint:self.view.center];
//    [self.view addSubview:test];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark - AlertView Controller
//- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    
//    if (buttonIndex == 1)
//        NSLog(@"TextField contents:%@",[[alertView textFieldAtIndex:0] text]);
//    self.tempName = [[alertView textFieldAtIndex:0] text];
//}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    //获得触摸在按钮的父视图中的坐标
//    if (UIControlEventTouchUpInside) {
//
//    }
//    
//}

#pragma mark - Delegate: Create 編輯區 Object 

- (void)LightButton:(CGPoint)location WithId:(int)buttonId {
    DataClass *obj = [DataClass getInstance];
    
    MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) WithParentView:self.view WithObjectType:LED WithButtonID:buttonId];
    aaa.center = location;
    [aaa setBackgroundImage:[UIImage imageNamed:@"Editor-Green.png"] forState:UIControlStateNormal];
    
    aaa.image = [UIImage imageNamed:@"Light小.png"];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    [imageview setImage:aaa.image];
    aaa.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 60, 15)];
    [aaa.label setText:@"Off"];
    [aaa.label setTextAlignment:NSTextAlignmentCenter];
    [aaa.label setFont:[UIFont systemFontOfSize:13]];
    [aaa.label setBackgroundColor:[UIColor clearColor]];
    
    [aaa addSubview:imageview];
    [aaa addSubview:aaa.label];
    
    [aaa setDelegate:self];
    //物件按鈕資訊初始化
    //    aaa.ObjectID =
    aaa.ObjectClass = LED;
    aaa.ObjectNumber = 1;
    aaa.ObjectAct = LED_OFF;
    aaa.ObjectInputParameter = -1;
    aaa.ObjectOutputParameter = -1;
    aaa.ObjectKernel = 1;
    aaa.ObjectPin = [obj setPin:aaa];
    
    //把物件放進記錄畫面上物件的array  數字直接對應(ex. ObjectOnBoard[1]表示第一個)
    [obj InsertInArray:aaa IndexOfInsert:aaa.ButtonID];
    NSLog(@"scroll is %f",self.Scroll_ChoosingItems.contentOffset.y);
    
    [self.view addSubview:aaa];
}

- (void)VibrationButton:(CGPoint)location WithId:(int)buttonId{
    DataClass *obj = [DataClass getInstance];
    
    //MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) :self.view:VIBRATION];
    MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) WithParentView:self.view WithObjectType:VIBRATION WithButtonID:buttonId];
    aaa.center = location;
    [aaa setBackgroundImage:[UIImage imageNamed:@"Editor-Green.png"] forState:UIControlStateNormal];
    
    
    aaa.image = [UIImage imageNamed:@"Vibrate小.png"];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    [imageview setImage:aaa.image];
    aaa.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 100, 15)];
    [aaa.label setText:@"Off"];
    [aaa.label setTextAlignment:NSTextAlignmentCenter];
    [aaa.label setFont:[UIFont systemFontOfSize:13]];
    [aaa.label setBackgroundColor:[UIColor clearColor]];
    
    [aaa addSubview:imageview];
    [aaa addSubview:aaa.label];
    
    [aaa setDelegate:self];
    //物件按鈕資訊初始化
    //    aaa.ObjectID =
    aaa.ObjectClass = VIBRATION;
    aaa.ObjectNumber = 1;
    aaa.ObjectAct = VIBRATION_OFF;
    aaa.ObjectInputParameter = -1;
    aaa.ObjectOutputParameter = -1;
    aaa.ObjectKernel = 1;
    aaa.ObjectPin = [obj setPin:aaa];
    
    //把物件放進記錄畫面上物件的array  數字直接對應(ex. ObjectOnBoard[1]表示第一個)
    [obj InsertInArray:aaa IndexOfInsert:aaa.ButtonID];
    
    [self.view addSubview:aaa];
}

- (void)SpeakerButton:(CGPoint)location WithId:(int)buttonId{
    DataClass *obj = [DataClass getInstance];
    
    //MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) :self.view:SPEAKER];
    MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) WithParentView:self.view WithObjectType:SPEAKER WithButtonID:buttonId];
    aaa.center = location;
    [aaa setBackgroundImage:[UIImage imageNamed:@"Editor-Green.png"] forState:UIControlStateNormal];
    
    aaa.image = [UIImage imageNamed:@"Speaker小.png"];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    [imageview setImage:aaa.image];
    aaa.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 60, 15)];
    [aaa.label setText:@"Off"];
    [aaa.label setTextAlignment:NSTextAlignmentCenter];
    [aaa.label setFont:[UIFont systemFontOfSize:13]];
    [aaa.label setBackgroundColor:[UIColor clearColor]];
    
    [aaa addSubview:imageview];
    [aaa addSubview:aaa.label];
    
    [aaa setDelegate:self];
    //物件按鈕資訊初始化
    //    aaa.ObjectID =
    aaa.ObjectClass = SPEAKER;
    aaa.ObjectNumber = 1;
    aaa.ObjectAct = SPEAKER_OFF;
    aaa.ObjectInputParameter = -1;
    aaa.ObjectOutputParameter = -1;
    aaa.ObjectKernel = 1;
    aaa.ObjectPin = [obj setPin:aaa];
    
    //把物件放進記錄畫面上物件的array  數字直接對應(ex. ObjectOnBoard[1]表示第一個)
    [obj InsertInArray:aaa IndexOfInsert:aaa.ButtonID];
    
    [self.view addSubview:aaa];
}

- (void)BButton:(CGPoint)location WithId:(int)buttonId{
    DataClass *obj = [DataClass getInstance];
    
    //MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) :self.view:BUTTON];
    MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) WithParentView:self.view WithObjectType:BUTTON WithButtonID:buttonId];
    aaa.center = location;
    [aaa setBackgroundImage:[UIImage imageNamed:@"編輯區-黃框.png"] forState:UIControlStateNormal];
    
    
    aaa.image = [UIImage imageNamed:@"Button小.png"];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    [imageview setImage:aaa.image];
    aaa.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 60, 15)];
    [aaa.label setText:@"Read"];
    [aaa.label setTextAlignment:NSTextAlignmentCenter];
    [aaa.label setFont:[UIFont systemFontOfSize:13]];
    [aaa.label setBackgroundColor:[UIColor clearColor]];
    
    [aaa addSubview:imageview];
    [aaa addSubview:aaa.label];
    
    [aaa setDelegate:self];
    
    //物件按鈕資訊初始化
    //    aaa.ObjectID =
    aaa.ObjectClass = BUTTON;
    aaa.ObjectNumber = 1;
    aaa.ObjectAct = BUTTON_READ;
    aaa.ObjectInputParameter = -1;
    aaa.ObjectOutputParameter = 0;
    aaa.ObjectKernel = 1;
    aaa.ObjectPin = [obj setPin:aaa];
    
    //把物件放進記錄畫面上物件的array  數字直接對應(ex. ObjectOnBoard[1]表示第一個)
    [obj InsertInArray:aaa IndexOfInsert:aaa.ButtonID];
    
    [self.view addSubview:aaa];
}

- (void)TiltButton:(CGPoint)location WithId:(int)buttonId{
    DataClass *obj = [DataClass getInstance];
    
    //MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) :self.view:TILT];
    MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) WithParentView:self.view WithObjectType:TILT WithButtonID:buttonId];
    aaa.center = location;
    [aaa setBackgroundImage:[UIImage imageNamed:@"編輯區-黃框.png"] forState:UIControlStateNormal];
    
    
    aaa.image = [UIImage imageNamed:@"Tilt小.png"];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    [imageview setImage:aaa.image];
    aaa.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 60, 15)];
    [aaa.label setText:@"Read"];
    [aaa.label setTextAlignment:NSTextAlignmentCenter];
    [aaa.label setFont:[UIFont systemFontOfSize:13]];
    [aaa.label setBackgroundColor:[UIColor clearColor]];
    
    [aaa addSubview:imageview];
    [aaa addSubview:aaa.label];
    
    [aaa setDelegate:self];
    
    //物件按鈕資訊初始化
    //    aaa.ObjectID =
    aaa.ObjectClass = TILT;
    aaa.ObjectNumber = 1;
    aaa.ObjectAct = TILT_READ;
    aaa.ObjectInputParameter = -1;
    aaa.ObjectOutputParameter = 0;
    aaa.ObjectKernel = 1;
    aaa.ObjectPin = [obj setPin:aaa];
    
    //把物件放進記錄畫面上物件的array  數字直接對應(ex. ObjectOnBoard[1]表示第一個)
    [obj InsertInArray:aaa IndexOfInsert:aaa.ButtonID];
    NSLog(@"scroll is %f",self.Scroll_ChoosingItems.contentOffset.y);
    [self.view addSubview:aaa];
}

- (void)LiquidButton:(CGPoint)location WithId:(int)buttonId{
    DataClass *obj = [DataClass getInstance];
    
    //MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) :self.view:LIQUID];
    MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) WithParentView:self.view WithObjectType:LIQUID WithButtonID:buttonId];
    aaa.center = location;
    [aaa setBackgroundImage:[UIImage imageNamed:@"編輯區-黃框.png"] forState:UIControlStateNormal];
    
    
    aaa.image = [UIImage imageNamed:@"Liquid小.png"];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    [imageview setImage:aaa.image];
    aaa.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 60, 15)];
    [aaa.label setText:@"Read"];
    [aaa.label setTextAlignment:NSTextAlignmentCenter];
    [aaa.label setFont:[UIFont systemFontOfSize:13]];
    [aaa.label setBackgroundColor:[UIColor clearColor]];
    
    [aaa addSubview:imageview];
    [aaa addSubview:aaa.label];
    
    [aaa setDelegate:self];
    //物件按鈕資訊初始化
    //    aaa.ObjectID =
    aaa.ObjectClass = LIQUID;
    aaa.ObjectNumber = 1;
    aaa.ObjectAct = LIQUID_READ;
    aaa.ObjectInputParameter = -1;
    aaa.ObjectOutputParameter = 0;
    aaa.ObjectKernel = 1;
    aaa.ObjectPin = [obj setPin:aaa];
    
    //把物件放進記錄畫面上物件的array  數字直接對應(ex. ObjectOnBoard[1]表示第一個)
    [obj InsertInArray:aaa IndexOfInsert:aaa.ButtonID];
    
    [self.view addSubview:aaa];
}

- (void)AngleAction :(CGPoint)location WithId:(int)buttonId{
    DataClass *obj = [DataClass getInstance];
    
    //MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) :self.view:ANGLE];
    MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) WithParentView:self.view WithObjectType:ANGLE WithButtonID:buttonId];
    aaa.center = location;
    [aaa setBackgroundImage:[UIImage imageNamed:@"編輯區-黃框.png"] forState:UIControlStateNormal];
    
    
    aaa.image = [UIImage imageNamed:@"Angle小.png"];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    [imageview setImage:aaa.image];
    aaa.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 60, 15)];
    [aaa.label setText:@"Read"];
    [aaa.label setTextAlignment:NSTextAlignmentCenter];
    [aaa.label setFont:[UIFont systemFontOfSize:13]];
    [aaa.label setBackgroundColor:[UIColor clearColor]];
    
    [aaa addSubview:imageview];
    [aaa addSubview:aaa.label];
    
    [aaa setDelegate:self];
    //物件按鈕資訊初始化
    //    aaa.ObjectID =
    aaa.ObjectClass = ANGLE;
    aaa.ObjectNumber = 1;
    aaa.ObjectAct = ANGLE_READ;
    aaa.ObjectInputParameter = -1;
    aaa.ObjectOutputParameter = 0;
    aaa.ObjectKernel = 1;
    aaa.ObjectPin = [obj setPin:aaa];
    
    //把物件放進記錄畫面上物件的array  數字直接對應(ex. ObjectOnBoard[1]表示第一個)
    [obj InsertInArray:aaa IndexOfInsert:aaa.ButtonID];
    [self.view addSubview:aaa];
}

- (void)SoundButton:(CGPoint)location WithId:(int)buttonId{
    DataClass *obj = [DataClass getInstance];
    
    //MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) :self.view:SOUNDSENSOR];
    MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) WithParentView:self.view WithObjectType:SOUNDSENSOR WithButtonID:buttonId];
    aaa.center = location;
    [aaa setBackgroundImage:[UIImage imageNamed:@"編輯區-黃框.png"] forState:UIControlStateNormal];
    
    
    aaa.image = [UIImage imageNamed:@"Sound小.png"];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    [imageview setImage:aaa.image];
    aaa.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 60, 15)];
    [aaa.label setText:@"Read"];
    [aaa.label setTextAlignment:NSTextAlignmentCenter];
    [aaa.label setFont:[UIFont systemFontOfSize:13]];
    [aaa.label setBackgroundColor:[UIColor clearColor]];
    
    [aaa addSubview:imageview];
    [aaa addSubview:aaa.label];
    
    [aaa setDelegate:self];
    
    //物件按鈕資訊初始化
    //    aaa.ObjectID =
    aaa.ObjectClass = SOUNDSENSOR;
    aaa.ObjectNumber = 1;
    aaa.ObjectAct = SOUNDSENSOR_READ;
    aaa.ObjectInputParameter = -1;
    aaa.ObjectOutputParameter = 0;
    aaa.ObjectKernel = 1;
    aaa.ObjectPin = [obj setPin:aaa];
    
    //把物件放進記錄畫面上物件的array  數字直接對應(ex. ObjectOnBoard[1]表示第一個)
    [obj InsertInArray:aaa IndexOfInsert:aaa.ButtonID];
    [self.view addSubview:aaa];
}

- (void)LightSensor:(CGPoint)location WithId:(int)buttonId{
    DataClass *obj = [DataClass getInstance];
    
    //MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) :self.view:LIGHTSENSOR];
    MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) WithParentView:self.view WithObjectType:LIGHTSENSOR WithButtonID:buttonId];
    aaa.center = location;
    [aaa setBackgroundImage:[UIImage imageNamed:@"編輯區-黃框.png"] forState:UIControlStateNormal];
    
    
    aaa.image = [UIImage imageNamed:@"LightSensor小.png"];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    [imageview setImage:aaa.image];
    aaa.label = [[UILabel alloc] initWithFrame:CGRectMake(15, 80, 70, 15)];
    [aaa.label setText:@"Read"];
    [aaa.label setTextAlignment:NSTextAlignmentCenter];
    [aaa.label setFont:[UIFont systemFontOfSize:13]];
    [aaa.label setBackgroundColor:[UIColor clearColor]];
    
    [aaa addSubview:imageview];
    [aaa addSubview:aaa.label];
    
    [aaa setDelegate:self];
    
    //物件按鈕資訊初始化
    //    aaa.ObjectID =
    aaa.ObjectClass = LIGHTSENSOR;
    aaa.ObjectNumber = 1;
    aaa.ObjectAct = LIGHTSENSOR_READ;
    aaa.ObjectInputParameter = -1;
    aaa.ObjectOutputParameter = 0;
    aaa.ObjectKernel = 1;
    aaa.ObjectPin = [obj setPin:aaa];
    
    //把物件放進記錄畫面上物件的array  數字直接對應(ex. ObjectOnBoard[1]表示第一個)
    [obj InsertInArray:aaa IndexOfInsert:aaa.ButtonID];
    
    [self.view addSubview:aaa];
}

- (void)Pressure:(CGPoint)location WithId:(int)buttonId{
    DataClass *obj = [DataClass getInstance];
    
    //MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) :self.view:PRESSURESENSOR];
    MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) WithParentView:self.view WithObjectType:PRESSURESENSOR WithButtonID:buttonId];
    aaa.center = location;
    [aaa setBackgroundImage:[UIImage imageNamed:@"編輯區-黃框.png"] forState:UIControlStateNormal];
    
    
    aaa.image = [UIImage imageNamed:@"Pressure小.png"];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    [imageview setImage:aaa.image];
    aaa.label = [[UILabel alloc] initWithFrame:CGRectMake(15, 80, 70, 15)];
    [aaa.label setText:@"Read"];
    [aaa.label setTextAlignment:NSTextAlignmentCenter];
    [aaa.label setFont:[UIFont systemFontOfSize:13]];
    [aaa.label setBackgroundColor:[UIColor clearColor]];
    
    [aaa addSubview:imageview];
    [aaa addSubview:aaa.label];
    
    [aaa setDelegate:self];
    //物件按鈕資訊初始化
    //    aaa.ObjectID =
    aaa.ObjectClass = PRESSURESENSOR;
    aaa.ObjectNumber = 1;
    aaa.ObjectAct = PRESSURESENSOR_READ;
    aaa.ObjectInputParameter = -1;
    aaa.ObjectOutputParameter = 0;
    aaa.ObjectKernel = 1;
    aaa.ObjectPin = [obj setPin:aaa];
    
    //把物件放進記錄畫面上物件的array  數字直接對應(ex. ObjectOnBoard[1]表示第一個)
    [obj InsertInArray:aaa IndexOfInsert:aaa.ButtonID];
    
    [self.view addSubview:aaa];
}

- (void)IPadButton:(CGPoint)location WithId:(int)buttonId{
    DataClass *obj = [DataClass getInstance];
    
    //MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) :self.view:IPADBUTTON];
    MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) WithParentView:self.view WithObjectType:IPADBUTTON WithButtonID:buttonId];
    aaa.center = location;
    [aaa setBackgroundImage:[UIImage imageNamed:@"編輯區-黃框.png"] forState:UIControlStateNormal];
    
    
    aaa.image = [UIImage imageNamed:@"iPadButton小.png"];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    [imageview setImage:aaa.image];
    aaa.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 60, 15)];
    [aaa.label setText:@"Read"];
    [aaa.label setTextAlignment:NSTextAlignmentCenter];
    [aaa.label setFont:[UIFont systemFontOfSize:13]];
    [aaa.label setBackgroundColor:[UIColor clearColor]];
    
    [aaa addSubview:imageview];
    [aaa addSubview:aaa.label];
    
    [aaa setDelegate:self];
    //物件按鈕資訊初始化
    //    aaa.ObjectID =
    aaa.ObjectClass = IPADBUTTON;
    aaa.ObjectNumber = 1;
    aaa.ObjectAct = IPADBUTTON_READ;
    aaa.ObjectInputParameter = -1;
    aaa.ObjectOutputParameter = 0;
    aaa.ObjectKernel = 1;
    aaa.ObjectPin = -1;
    
    //把物件放進記錄畫面上物件的array  數字直接對應(ex. ObjectOnBoard[1]表示第一個)
    [obj InsertInArray:aaa IndexOfInsert:aaa.ButtonID];
    
    [self.view addSubview:aaa];
}

- (void)IPadSound:(CGPoint)location WithId:(int)buttonId{
    DataClass *obj = [DataClass getInstance];
    
   // MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) :self.view:IPADSOUND];
    MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) WithParentView:self.view WithObjectType:IPADSOUND WithButtonID:buttonId];
    aaa.center = location;
    [aaa setBackgroundImage:[UIImage imageNamed:@"Editor-Green.png"] forState:UIControlStateNormal];
    
    
    aaa.image = [UIImage imageNamed:@"iPadSound小.png"];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    [imageview setImage:aaa.image];
    aaa.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 60, 15)];
    [aaa.label setText:@"Off"];
    [aaa.label setTextAlignment:NSTextAlignmentCenter];
    [aaa.label setFont:[UIFont systemFontOfSize:13]];
    [aaa.label setBackgroundColor:[UIColor clearColor]];
    
    [aaa addSubview:imageview];
    [aaa addSubview:aaa.label];
    
    [aaa setDelegate:self];
    //物件按鈕資訊初始化
    //    aaa.ObjectID =
    aaa.ObjectClass = IPADSOUND;
    aaa.ObjectNumber = 1;
    aaa.ObjectAct = IPADSOUND_OFF;
    aaa.ObjectInputParameter = -1;
    aaa.ObjectOutputParameter = -1;
    aaa.ObjectKernel = 1;
    aaa.ObjectPin = -1;
    
    //把物件放進記錄畫面上物件的array  數字直接對應(ex. ObjectOnBoard[1]表示第一個)
    [obj InsertInArray:aaa IndexOfInsert:aaa.ButtonID];
    
    [self.view addSubview:aaa];
}

- (void)ResetAction:(CGPoint)location WithId:(int)buttonId{
    
    DataClass *obj = [DataClass getInstance];
//    obj.NumberOfObject++;
//    NSLog(@"DataClass number is:%d\n",obj.NumberOfObject);

    //MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) :self.view:RESET];
    MoveButton *aaa = [[MoveButton alloc] initWithFrame:CGRectMake(location.x, location.y, 100, 100) WithParentView:self.view WithObjectType:RESET WithButtonID:buttonId];
    aaa.center = location;
    [aaa setBackgroundImage:[UIImage imageNamed:@"物件區&編輯區Reset.png"] forState:UIControlStateNormal];

    [aaa setDelegate:self];
    //物件按鈕資訊初始化
    //    aaa.ObjectID =
    aaa.ObjectClass = RESET;
    aaa.ObjectNumber = 1;
    aaa.ObjectAct = 1;
    aaa.ObjectInputParameter = -1;
    aaa.ObjectOutputParameter = -1;
    aaa.ObjectKernel = -1;
    aaa.ObjectPin = -1;
    [obj InsertInArray:aaa IndexOfInsert:aaa.ButtonID];
    [self.view addSubview:aaa];
}

#pragma mark - 按下Play或Stop的對應method

-(void)NextbtnClicked{
    //初始化pinsdiagram
    self.AnalogArrow0.alpha = 0;
    self.AnalogArrow1.alpha = 0;
    self.AnalogArrow2.alpha = 0;
    self.AnalogArrow3.alpha = 0;
    self.AnalogArrow4.alpha = 0;
    self.AnalogObject0.alpha = 0;
    self.AnalogObject1.alpha = 0;
    self.AnalogObject2.alpha = 0;
    self.AnalogObject3.alpha = 0;
    self.AnalogObject4.alpha = 0;
    self.DigitalArrow1.alpha = 0;
    self.DigitalArrow2.alpha = 0;
    self.DigitalArrow3.alpha = 0;
    self.DigitalArrow4.alpha = 0;
    self.DigitalArrow5.alpha = 0;
    self.DigitalArrow6.alpha = 0;
    self.DigitalArrow7.alpha = 0;
    self.DigitalObject1.alpha = 0;
    self.DigitalObject2.alpha = 0;
    self.DigitalObject3.alpha = 0;
    self.DigitalObject4.alpha = 0;
    self.DigitalObject5.alpha = 0;
    self.DigitalObject6.alpha = 0;
    self.DigitalObject7.alpha = 0;
    
    if (self.isBLEConnect) {
        //btnPlay.enabled = NO;
        NextBtnItem.enabled = false;
        [runobjectaction BlueToothDisconnect];
        self.CoverView.alpha = 0;
    }
    else {
        //btnPlay.enabled = NO;
        NextBtnItem.enabled = false;
        [UIView animateWithDuration:0.2 animations:
         ^(void){
             self.PinsDiagram.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1f, 1.1f);
             self.PinsDiagram.alpha = 0.5;
             self.ArduinoImage.alpha = 0.5;
             self.CoverView.alpha = 0.8;
         }
                         completion:^(BOOL finished){
                             [self bounceOutAnimationStoped];
                         }];
        
        //Scan編輯區上所有物件，同時依照所配pin腳完成pinsdiagram
        int analogpin[5] = {0};
        int digitalpin[8] = {0};
        DataClass *obj = [DataClass getInstance];
        for (int i=1; i<=[obj TotalButtons]; i++) {
            if ([obj ButtonOfIndex:i].ObjectClass == ANGLE || [obj ButtonOfIndex:i].ObjectClass == SOUNDSENSOR ||
                [obj ButtonOfIndex:i].ObjectClass == LIGHTSENSOR || [obj ButtonOfIndex:i].ObjectClass == PRESSURESENSOR) {
                if (analogpin[[obj ButtonOfIndex:i].ObjectPin] != 0) {
                    //略過
                }
                else {
                    [self setAnalogPinsDiagramPin:[obj ButtonOfIndex:i]];
                    analogpin[[obj ButtonOfIndex:i].ObjectPin] = 1;
                }
            }
            else if ([obj ButtonOfIndex:i].ObjectClass <= 6) {
                if (digitalpin[[obj ButtonOfIndex:i].ObjectPin] != 0) {
                    //略過
                }
                else {
                    [self setDigitalPinsDiagramPin:[obj ButtonOfIndex:i]];
                    digitalpin[[obj ButtonOfIndex:i].ObjectPin] = 1;
                }
            }
        }
        
        
        [self.view addSubview:self.PinsDiagram];
    }

}
/* 改用Next step Button
- (IBAction)btnPlayClicked:(id)sender {
    //初始化pinsdiagram
    self.AnalogArrow0.alpha = 0;
    self.AnalogArrow1.alpha = 0;
    self.AnalogArrow2.alpha = 0;
    self.AnalogArrow3.alpha = 0;
    self.AnalogArrow4.alpha = 0;
    self.AnalogObject0.alpha = 0;
    self.AnalogObject1.alpha = 0;
    self.AnalogObject2.alpha = 0;
    self.AnalogObject3.alpha = 0;
    self.AnalogObject4.alpha = 0;
    self.DigitalArrow1.alpha = 0;
    self.DigitalArrow2.alpha = 0;
    self.DigitalArrow3.alpha = 0;
    self.DigitalArrow4.alpha = 0;
    self.DigitalArrow5.alpha = 0;
    self.DigitalArrow6.alpha = 0;
    self.DigitalArrow7.alpha = 0;
    self.DigitalObject1.alpha = 0;
    self.DigitalObject2.alpha = 0;
    self.DigitalObject3.alpha = 0;
    self.DigitalObject4.alpha = 0;
    self.DigitalObject5.alpha = 0;
    self.DigitalObject6.alpha = 0;
    self.DigitalObject7.alpha = 0;
    
    if (self.isBLEConnect) {
        btnPlay.enabled = NO;
        NextBtnItem.enabled = false;
        [runobjectaction BlueToothDisconnect];
        self.CoverView.alpha = 0;
    }
    else {
        btnPlay.enabled = NO;
        NextBtnItem.enabled = false;
        [UIView animateWithDuration:0.2 animations:
         ^(void){
             self.PinsDiagram.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1f, 1.1f);
             self.PinsDiagram.alpha = 0.5;
             self.ArduinoImage.alpha = 0.5;
             self.CoverView.alpha = 0.8;
         }
                         completion:^(BOOL finished){
                             [self bounceOutAnimationStoped];
                         }];
        
        //Scan編輯區上所有物件，同時依照所配pin腳完成pinsdiagram
        int analogpin[5] = {0};
        int digitalpin[8] = {0};
        DataClass *obj = [DataClass getInstance];
        for (int i=1; i<=[obj TotalButtons]; i++) {
            if ([obj ButtonOfIndex:i].ObjectClass == ANGLE || [obj ButtonOfIndex:i].ObjectClass == SOUNDSENSOR ||
                [obj ButtonOfIndex:i].ObjectClass == LIGHTSENSOR || [obj ButtonOfIndex:i].ObjectClass == PRESSURESENSOR) {
                if (analogpin[[obj ButtonOfIndex:i].ObjectPin] != 0) {
                    //略過
                }
                else {
                    [self setAnalogPinsDiagramPin:[obj ButtonOfIndex:i]];
                    analogpin[[obj ButtonOfIndex:i].ObjectPin] = 1;
                }
            }
            else if ([obj ButtonOfIndex:i].ObjectClass <= 6) {
                if (digitalpin[[obj ButtonOfIndex:i].ObjectPin] != 0) {
                    //略過
                }
                else {
                    [self setDigitalPinsDiagramPin:[obj ButtonOfIndex:i]];
                    digitalpin[[obj ButtonOfIndex:i].ObjectPin] = 1;
                }
            }
        }
        
        
        [self.view addSubview:self.PinsDiagram];
    }
}
*/
- (void)TellNewProjectToChangeButtonImage:(BOOL)PlayorStop
{
    if (PlayorStop)
    {
        NextBtnItem.title=@"Next Step";
        //[btnPlay setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        [self playSoundWhichOne:DISCONNECT_SOUND];
    }
    else{
        NextBtnItem.title=@"Stop Connect";
        //[btnPlay setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
    }
}

- (void)TellNewProjectToChangeIndAnimation:(BOOL)StartorStop
{
    if (StartorStop)
    {
        //[indConnecting startAnimating]; 不用連線轉轉動畫
        [self playSoundWhichOne:CONNECTING_SOUND];
        NextBtnItem.title=@"Connecting...";
    }
    else{
        //[indConnecting stopAnimating];
    }
}

- (void)TellNewProjectIsBLEConnect:(BOOL)isConnect
{
    if (isConnect) 
        self.isBLEConnect = true;
    else
        self.isBLEConnect = false;
}

- (void)TellNewProjectToEnablebtnPlay:(BOOL)toEnable
{
    if (toEnable) {
        NextBtnItem.enabled =true;
        //btnPlay.enabled = YES;
    }
}

#pragma mark - Bounce Subview Animation
- (void)bounceOutAnimationStoped
{
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         self.PinsDiagram.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.9, 0.9);
         self.PinsDiagram.alpha = 0.8;
         self.ArduinoImage.alpha = 0.8;
     }
                     completion:^(BOOL finished){
                         [self bounceInAnimationStoped];
                     }];
}
- (void)bounceInAnimationStoped
{
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         self.PinsDiagram.transform = CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
         self.PinsDiagram.alpha = 1.0;
         self.ArduinoImage.alpha = 1.0;
     }
                     completion:^(BOOL finished){
                         [self animationStoped];
                     }];
    
}
- (void)animationStoped
{
    
}
- (IBAction)ConfirmButton:(id)sender {
    self.PinsDiagram.alpha = 0;
    self.ArduinoImage.alpha = 0;
    self.CoverView.alpha = 0;
    self.PinsDiagram.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.6, 0.6);

    [self.PinsDiagram removeFromSuperview];
    
    [runobjectaction BlueToothConnect];
}
#pragma mark - Play System Sound
-(void)playSoundWhichOne:(int)Song{
    //NSLog(@"###################################Song is ???%d\n",Song);
    if (Song==CONNECTING_SOUND)
		AudioServicesPlayAlertSound(connectingSound);
	else if(Song==DISCONNECT_SOUND)
		AudioServicesPlaySystemSound(disconnectSound);
    else if(Song==OBJECTPOP_SOUND)
        AudioServicesPlaySystemSound(objectpopSound);
    else if(Song==OBJECTINSERT_SOUND)
        AudioServicesPlaySystemSound(objectinsertSound);
    else if(Song==TRASH_SOUND)
        AudioServicesPlaySystemSound(trashSound);
    else if (Song==POPOVER_SOUND)
        AudioServicesPlaySystemSound(popoverSound);
    else if (Song==CLICKDONE_SOUND)
        AudioServicesPlaySystemSound(clickdoneSound);
}

#pragma mark - 設定pins diagram 的箭頭和圖片
- (UIImage*)setAnalogPinsDiagramImage:(MoveButton*) button
{
    UIImage *image;
    switch (button.ObjectClass) {
        case ANGLE:
        {
            image = [UIImage imageNamed:@"物件區-Angle.png"];
            break;
        }
        case SOUNDSENSOR:
        {
            image = [UIImage imageNamed:@"物件區-Sound.png"];
            break;
        }
        case LIGHTSENSOR:
        {
            image = [UIImage imageNamed:@"物件區LightSensor.png"];
            break;
        }
        default: //PRESSURESENSOR
        {
            image = [UIImage imageNamed:@"物件區-Pressure.png"];
            break;
        }
    }
    return image;
}

- (void)setAnalogPinsDiagramPin:(MoveButton *)button
{
    switch (button.ObjectPin) {
        case 0:
        {
            self.AnalogArrow0.alpha = 1;
            self.AnalogObject0.alpha = 1;
            self.AnalogObject0.image = [self setAnalogPinsDiagramImage:button];
            break;
        }
        case 1:
        {
            self.AnalogArrow1.alpha = 1;
            self.AnalogObject1.alpha = 1;
            self.AnalogObject1.image = [self setAnalogPinsDiagramImage:button];
            break;
        }
        case 2:
        {
            self.AnalogArrow2.alpha = 1;
            self.AnalogObject2.alpha = 1;
            self.AnalogObject2.image = [self setAnalogPinsDiagramImage:button];
            break;
        }
        case 3:
        {
            self.AnalogArrow3.alpha = 1;
            self.AnalogObject3.alpha = 1;
            self.AnalogObject3.image = [self setAnalogPinsDiagramImage:button];
            break;
        }
        default: //4
        {
            self.AnalogArrow4.alpha = 1;
            self.AnalogObject4.alpha = 1;
            self.AnalogObject4.image = [self setAnalogPinsDiagramImage:button];
            break;
        }
    }
}

- (UIImage*)setDigitalPinsDiagramImage:(MoveButton*) button
{
    UIImage *image;
    switch (button.ObjectClass) {
        case LED:
        {
            image = [UIImage imageNamed:@"物件區-Light.png"];
            break;
        }
        case VIBRATION:
        {
            image = [UIImage imageNamed:@"物件區-Vibration.png"];
            break;
        }
        case SPEAKER:
        {
            image = [UIImage imageNamed:@"物件區-Speaker.png"];
            break;
        }
        case BUTTON:
        {
            image = [UIImage imageNamed:@"物件區-Button.png"];
            break;
        }
        case TILT:
        {
            image = [UIImage imageNamed:@"物件區-Tilt.png"];
            break;
        }
        default: //LIQUID
        {
            image = [UIImage imageNamed:@"物件區-Liquid.png"];
            break;
        }
    }
    return image;
}

- (void)setDigitalPinsDiagramPin:(MoveButton*) button
{
    switch (button.ObjectPin) {
        case 1:
        {
            self.DigitalArrow1.alpha = 1;
            self.DigitalObject1.alpha = 1;
            self.DigitalObject1.image = [self setDigitalPinsDiagramImage:button];
            break;
        }
        case 2:
        {
            self.DigitalArrow2.alpha = 1;
            self.DigitalObject2.alpha = 1;
            self.DigitalObject2.image = [self setDigitalPinsDiagramImage:button];
            break;
        }
        case 3:
        {
            self.DigitalArrow3.alpha = 1;
            self.DigitalObject3.alpha = 1;
            self.DigitalObject3.image = [self setDigitalPinsDiagramImage:button];
            break;
        }
        case 4:
        {
            self.DigitalArrow4.alpha = 1;
            self.DigitalObject4.alpha = 1;
            self.DigitalObject4.image = [self setDigitalPinsDiagramImage:button];
            break;
        }
        case 5:
        {
            self.DigitalArrow5.alpha = 1;
            self.DigitalObject5.alpha = 1;
            self.DigitalObject5.image = [self setDigitalPinsDiagramImage:button];
            break;
        }
        case 6:
        {
            self.DigitalArrow6.alpha = 1;
            self.DigitalObject6.alpha = 1;
            self.DigitalObject6.image = [self setDigitalPinsDiagramImage:button];
            break;
        }
        default: //7
        {
            self.DigitalArrow7.alpha = 1;
            self.DigitalObject7.alpha = 1;
            self.DigitalObject7.image = [self setDigitalPinsDiagramImage:button];
            break;
        }
    }
}

-(void)dealloc{
    if(connectingSound)AudioServicesDisposeSystemSoundID(connectingSound);
    if(disconnectSound)AudioServicesDisposeSystemSoundID(disconnectSound);
    if(objectpopSound)AudioServicesDisposeSystemSoundID(objectpopSound);
    if(objectpopSound)AudioServicesDisposeSystemSoundID(objectinsertSound);
    if(trashSound)AudioServicesDisposeSystemSoundID(trashSound);
    if(popoverSound)AudioServicesDisposeSystemSoundID(popoverSound);
    if(clickdoneSound)AudioServicesDisposeSystemSoundID(clickdoneSound);

}

@end

