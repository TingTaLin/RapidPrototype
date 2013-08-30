//
//  dot.h
//  RapidPototype
//
//  Created by 林震軒 on 13/5/4.
//  Copyright (c) 2013年 林震軒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dot : UIView{
    CGPoint location;
}


@property (strong ,nonatomic)UILabel *xLabel;
@property (strong , nonatomic)UILabel *yLabel;

- (dot *)initWithPoint:(CGPoint)point;

@end
