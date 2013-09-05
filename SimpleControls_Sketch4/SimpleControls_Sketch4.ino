#include <SPI.h>
#include <ble.h>

//Read Analog & Digital Pin
int isUsingAnalogPinArray[5]={0,0,0,0,0};//是否Read AnalogPin
int isUsingDigitalInPinArray[7]={0,0,0,0,0,0,0};//是否Read DigitalPin
int DigitalInputOldStateArray[7]={0,0,0,0,0,0,0};//儲存Digital Pin上一次Read的狀態

//Blink
int isUsingDigitalBlinkArray[7]={0,0,0,0,0,0,0};//是否讓Digital Blink
int DigitalBlinkIntervalArray[7]={0,0,0,0,0,0,0};//Digital Blink的間隔
int DigitalBlinkStateArray[7]={LOW,LOW,LOW,LOW,LOW,LOW,LOW};//Digital Blink上一次呈現的狀態
unsigned long DigitalBlinkPreviousMillisArray[7]={0,0,0,0,0,0,0};//Digital Blink上一次執行的時間

//Fade only can use Pin 3,5,6
int isUsingDigitalFadeArray[3]={0,0,0};//這個PWM digital pin腳是否使用Fade行為
int DigitalFadeAmountArray[3] ={5,5,5};//Fade每次累加的數值，固定用5，會因到達255，而改改變為-5
int DigitalFadeBrightnessArray[3]={0,0,0};//儲存PWM pin腳目前的亮度
int DigitalFadeIntervalArray[3]={0,0,0};//儲存Fade每次+_5的間隔，由IOS傳來的數值決定
unsigned long DigitalFadePreviousMillisArray[3]={0,0,0};//Digital Fade上一次執行的時間

//因為這只會執行一次，setup也是，所以如果要重新Run一次新專案，而Arduino沒有電源重開的話，就要再寫一個function把這些狀態參數設為0
  
void setup()
{
  SPI.setDataMode(SPI_MODE0);
  SPI.setBitOrder(LSBFIRST);
  SPI.setClockDivider(SPI_CLOCK_DIV16);
  SPI.begin();

  ble_begin();
  //Serial.begin(9600);

  pinMode(1, INPUT);

}

void loop()
{
  
  unsigned long currentMillis = millis();
  
  // If data is ready
  while(ble_available())//一個命令一個動作，放這
  {
    // read out command and data
    
    byte data0_function = ble_read();//是哪種任務（功能）
                                     //0X0A(Arduino傳digital數值給IOS)
                                     //0X0B(Arduino傳Analog數值給IOS)
                                     //0X01(IOS傳Digital訊息給Arduino)
                                     //0X02(IOS傳PWM訊息給Arduino)
                                     //0X03(IOS叫Arduino的某一個digital腳位Blink)  new change
                                     //0X04(IOS叫Arduino的某一個digital腳位Fade)   new
                                     //0XA0(IOS叫Arduino"開始"監聽digital腳位，有改變就傳訊息給IOS) new change
                                     //0XB0(IOS叫Arduino"開始"傳送Analog訊息過來) change
                                         //0X03(IOS傳Servo訊息給Arduino)  --Kill!!
                                   
    byte data1_Pin = ble_read();     //是哪一個port要做事
                                     //Digital:0X01  0X02 0X03 0X04 0X05 0X06 0X07  (digital1~7)
                                     //AnalogIn:0X00 0X01 0X02 0X03 0X04 (Analog 0~4)
    byte data2_Value = ble_read();   //Value，任務要用的數值。除了Arduino傳Analog值給IOS會超過1byte，會將值延伸到MoreValue，其餘不會。
    byte data3_MoreValue = ble_read(); //MoreValue，任務要用的其他數值。
    
    
    if (data0_function == 0x01)  // IOS傳Digital訊息給Arduino Command is to control digital out pin //
    {
      //Serial.println("Light");
      pinMode(data1_Pin, OUTPUT);
     
      //先把之前在此腳位，Blink&Fade的行為關掉
      //Blink Off
      isUsingDigitalBlinkArray[data1_Pin-1] = 0;
      DigitalBlinkStateArray[data1_Pin-1]=LOW;
      //Fade Off  
      if(data1_Pin == 0X03||data1_Pin == 0X05||data1_Pin == 0X06){
          int PWM_Pin_Index = 0;  
          switch(data1_Pin)
          {
            case 0X03:
             PWM_Pin_Index=0;  
             break; 
            case 0X05:
             PWM_Pin_Index=1;
            break; 
            case 0X06:
            PWM_Pin_Index=2;
            break;
          }
          isUsingDigitalFadeArray[PWM_Pin_Index] = 0;
      }
      if (data2_Value == 0x01)
        digitalWrite(data1_Pin, HIGH);
      else
        digitalWrite(data1_Pin, LOW);
    }
    else if (data0_function == 0x02) // IOS傳PWM訊息給Arduino //
    {
      analogWrite(data1_Pin, data2_Value);
    }
    else if(data0_function == 0x03)  // IOS叫Arduino的某一個digital腳位Blink //
    {
      //要先Fade Off  
      if(data1_Pin == 0X03||data1_Pin == 0X05||data1_Pin == 0X06){
          int PWM_Pin_Index = 0;  
          switch(data1_Pin)
          {
            case 0X03:
             PWM_Pin_Index=0;  
             break; 
            case 0X05:
             PWM_Pin_Index=1;
            break; 
            case 0X06:
            PWM_Pin_Index=2;
            break;
          }
          isUsingDigitalFadeArray[PWM_Pin_Index] = 0;
      }
      
      if (data2_Value == 0x01)
      {   
        isUsingDigitalBlinkArray[data1_Pin-1] = 1;
        DigitalBlinkIntervalArray[data1_Pin-1] = data3_MoreValue;
      }
      else
      {
        isUsingDigitalBlinkArray[data1_Pin-1] = 0;
        DigitalBlinkStateArray[data1_Pin-1]=LOW;
        digitalWrite(data1_Pin,LOW);
        
      }
    }
    else if(data0_function==0X04) // IOS叫Arduino的某一個digital腳位Fade //
    {
      //要先Blink Off
      isUsingDigitalBlinkArray[data1_Pin-1] = 0;
      DigitalBlinkStateArray[data1_Pin-1]=LOW;
      
      int PWM_Pin_Index = 0;
      switch(data1_Pin)
      {
         case 0X03:
          PWM_Pin_Index=0;  
          break; 
         case 0X05:
          PWM_Pin_Index=1;
          break; 
         case 0X06:
          PWM_Pin_Index=2;
          break;
        
      }
      if(data2_Value==0X01)
      {
         isUsingDigitalFadeArray[PWM_Pin_Index] = 1; 
         DigitalFadeIntervalArray[PWM_Pin_Index] = data3_MoreValue;
      }
      else
      {
        //Serial.println("close 0x04");
        isUsingDigitalFadeArray[PWM_Pin_Index] = 0; 
        analogWrite(data1_Pin, 0);
      }
    }
    else if(data0_function == 0xA0) //IOS叫Arduino"開始"監聽digital腳位//
    {
      if (data2_Value == 0x01)
      {
        isUsingDigitalInPinArray[data1_Pin-1] = 1;
        if (digitalRead(data1_Pin) != HIGH)//設定開始讀取，若原本是0，要先傳送目前狀態。1則不用，因為通常在進入到這個狀態前不應該是按著的，要重新click一下
          {
            ble_write(0x0A);
            ble_write(data1_Pin);
            ble_write(0x00);
            ble_write(0x00);  
          }
      }
      else
      {
        isUsingDigitalInPinArray[data1_Pin-1] = 0;
      }  
    }
    else if (data0_function == 0xB0) //IOS叫Arduino"開始"傳送Analog訊息過來//
    {  
      if (data2_Value == 0x01)
      {   
        isUsingAnalogPinArray[data1_Pin] = 1;
      }
      else
      {
        isUsingAnalogPinArray[data1_Pin] = 0;
      }
    }
    
    
    
  }
  
  //會執行很多次的放後面，利用原本的loop即可
  
  for(byte i=0 ; i<5 ; i++){         //Arduino傳Analog數值給IOS//
     if(isUsingAnalogPinArray[i]==1)
     {
       uint16_t value = analogRead(i);
       ble_write(0x0B);
       ble_write(i);
       ble_write(value >> 8);
       ble_write(value);
     }
  }
  
  for(byte i=1 ; i<8 ;i++){         // 監聽digital腳位，有改變就傳訊息給IOS//
    
    if(isUsingDigitalInPinArray[i-1]==1){
  
        pinMode(i, INPUT);
        
        if (digitalRead(i) != DigitalInputOldStateArray[i-1])
        {
          DigitalInputOldStateArray[i-1] = digitalRead(i);
          
          if (digitalRead(i) == HIGH)
          {
            ble_write(0x0A);
            ble_write(i);
            ble_write(0x01);
            ble_write(0x00);    
          }
          else
          {
            ble_write(0x0A);
            ble_write(i);
            ble_write(0x00);
            ble_write(0x00);
          }
        } 
    }  
    
  }
  
  
   for(byte i=1 ; i<8 ;i++){
     if(isUsingDigitalBlinkArray[i-1]==1){  // 0X03 某一個digital腳位Blink//
         pinMode(i, OUTPUT);
         
         if(currentMillis - DigitalBlinkPreviousMillisArray[i-1] >DigitalBlinkIntervalArray[i-1]*3){//IOS傳來數值要大於200ms，太小會爆掉
            DigitalBlinkPreviousMillisArray[i-1] = currentMillis;
            
            if(DigitalBlinkStateArray[i-1]==LOW)
            { 
              DigitalBlinkStateArray[i-1]=HIGH;
            }
            else
            {
              DigitalBlinkStateArray[i-1]=LOW;
            }
            digitalWrite(i,DigitalBlinkStateArray[i-1]);
         }
      }
   }
   
   
  for(byte i=0; i<3; i++){  //0X04 IOS叫Arduino的某一個digital腳位Fade//
    if(isUsingDigitalFadeArray[i]==1){
      //Serial.print("Whcih PWM index On");
      //Serial.println(i);
      int PWM_Pin=0;
       
      //Serial.print(currentMillis);
      //Serial.print("-");
      //Serial.print(DigitalFadePreviousMillisArray[i]);
      //Serial.println("");
      //Serial.print(currentMillis - DigitalFadePreviousMillisArray[i]);
      //Serial.print(">");
      //Serial.print(DigitalFadeIntervalArray[i]);
      //Serial.println(".");
     
      if(currentMillis - DigitalFadePreviousMillisArray[i] > DigitalFadeIntervalArray[i]){
          DigitalFadePreviousMillisArray[i]=currentMillis;
          switch(i)
          {
             case 0:
              PWM_Pin=3;
              break; 
             case 1:
              PWM_Pin=5;
              break;
             case 2:
              PWM_Pin=6;
              break;
          }
          //Serial.println("******");
          //Serial.print(i);
          //Serial.print(":");
          //Serial.println(DigitalFadeBrightnessArray[i]);
          //Serial.println("******");
          
          analogWrite(PWM_Pin, DigitalFadeBrightnessArray[i]);
         
          DigitalFadeBrightnessArray[i] = DigitalFadeBrightnessArray[i] + DigitalFadeAmountArray[i];
         
          if(DigitalFadeBrightnessArray[i]==0||DigitalFadeBrightnessArray[i]==255)
          {
            DigitalFadeAmountArray[i]= - DigitalFadeAmountArray[i];
          }      
      }
    }
  }

  if (!ble_connected())
  {
    //全部的digital pin設為input，並且isUsing設0，就全部關掉了。
    //Serial.println("Not Connected!!");
    
    //把Read AnalogIuput關掉
    for(int i=0; i<5 ;i++){
       isUsingAnalogPinArray[i]=0;
    }
    
    //把Fade事件關掉
    for(int i=0; i<3 ;i++){
       isUsingDigitalFadeArray[i]=0;
    }
    
    //把Read Digital Pin關掉、把Blink事件關掉，digital全部改為Input(這樣Output就會被暫停)
    for(byte i=1 ; i<8 ;i++){
      isUsingDigitalInPinArray[i-1] = 0;
      isUsingDigitalBlinkArray[i-1] = 0;
      pinMode(i, INPUT);
    }
    
  }
  
  // Allow BLE Shield to send/receive data
  ble_do_events();  
}

