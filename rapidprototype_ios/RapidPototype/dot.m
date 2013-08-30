//
//  dot.m
//  RapidPototype
//
//  Created by 林震軒 on 13/5/4.
//  Copyright (c) 2013年 林震軒. All rights reserved.
//

#import "dot.h"

@implementation dot

@synthesize xLabel, yLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (dot *)initWithPoint:(CGPoint)point {
    self = [super init];
       
    if (self) {
        UIImageView *dotImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Angle大.png"]];
        CGSize imageSize = dotImageView.frame.size;
        
        //將畫面大小設成與圖片大小相同
        [self setFrame:CGRectMake(point.x, point.y, imageSize.width, imageSize.height)];
        [self addSubview:dotImageView];
        
        //設定UILabel
        xLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageSize.width +1, 0.0, 20.0, 15.0)];
        yLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageSize.width +1, 16.0, 20.0, 15.0)];
        
        UIFont *font = [UIFont fontWithName:@"Arial" size:10.0];
        [xLabel setFont:font];
        [yLabel setFont:font];
        
        xLabel.text = [NSString stringWithFormat:@"%.f", point.x];
        yLabel.text = [NSString stringWithFormat:@"%.f", point.y];
        
        [xLabel setBackgroundColor:[UIColor clearColor]];
        [yLabel setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:xLabel];
        [self addSubview:yLabel];
        
        //不切除超過邊界的畫面
        [self setClipsToBounds:NO];
    }
    
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //將被觸碰到鍵移動到所有畫面的最上層
    [[self superview] bringSubviewToFront:self];
    
    CGPoint point = [[touches anyObject] locationInView:self];
    location = point;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    
    CGRect frame = self.frame;
    
    frame.origin.x += point.x - location.x;
    frame.origin.y += point.y - location.y;
    [self setFrame:frame];
    
    xLabel.text = [NSString stringWithFormat:@"%.f", frame.origin.x];
    yLabel.text = [NSString stringWithFormat:@"%.f", frame.origin.y];
}
@end
