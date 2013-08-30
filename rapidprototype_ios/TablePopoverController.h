//
//  TablePopoverController.h
//  PopoverView
//
//  Created by Andreas Katzian on 04.10.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectClassDefine.h"
#import "LV2TableViewController.h"
#import "LV2SliderViewController.h"

@protocol TablePopoverViewControllerDelegate <NSObject>

- (void)didSelectRowWithAct:(NSString*)act;

@end

@interface TablePopoverController : UITableViewController {

}
@property (strong, nonatomic) id<TablePopoverViewControllerDelegate> delegate;


@end
