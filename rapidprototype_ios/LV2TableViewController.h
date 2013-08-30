//
//  LV2TableViewController.h
//  RapidPototype
//
//  Created by yuyu on 13/5/14.
//  Copyright (c) 2013年 林震軒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TablePopoverController.h"
#import "MoveButton.h"

@protocol LV2TableViewControllerDelegate <NSObject>

- (void)didLv2WithAct:(NSString* ) act andLv2Act:(NSString* ) act2;

@end

@interface LV2TableViewController : UITableViewController

@property (strong, nonatomic) id<LV2TableViewControllerDelegate> delegate;
@property (strong, nonatomic) NSString *act;

@end
