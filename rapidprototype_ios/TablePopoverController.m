//
//  TablePopoverController.m
//  PopoverView
//
//  Created by Andreas Katzian on 04.10.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import "TablePopoverController.h"


@implementation TablePopoverController

- (void)viewDidLoad
{
    switch (((MoveButton*)self.delegate).ObjectClass) {
        case LED:           { [self.navigationItem setTitle:@"Light"]; break; }
        case VIBRATION:     { [self.navigationItem setTitle:@"Vibration"]; break; }
        case SPEAKER:       { [self.navigationItem setTitle:@"Speaker"]; break; }
        case BUTTON:        { [self.navigationItem setTitle:@"Button"]; break; }
        case TILT:          { [self.navigationItem setTitle:@"Tilt"]; break; }
        case LIQUID:        { [self.navigationItem setTitle:@"Liquid"]; break; }
        case ANGLE:         { [self.navigationItem setTitle:@"Angle"]; break; }
        case SOUNDSENSOR:   { [self.navigationItem setTitle:@"SoundSensor"]; break; }
        case LIGHTSENSOR:   { [self.navigationItem setTitle:@"LightSensor"]; break; }
        case PRESSURESENSOR:{ [self.navigationItem setTitle:@"PressureSensor"]; break; }
        case IPADBUTTON:    { [self.navigationItem setTitle:@"iPadButton"]; break; }
        default:            { [self.navigationItem setTitle:@"iPadSound"]; break; } //IPADSOUND
    }
    UIBarButtonItem *BackBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                    style:UIBarButtonItemStyleBordered
                                                                   target:self
                                                                   action:@selector(pop)];
    self.navigationItem.backBarButtonItem = BackBtnItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.contentSizeForViewInPopover = CGSizeMake(320, 200);
}

#pragma mark -
#pragma mark Table view data source

// Return the number of sections.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Return the number of rows in the section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (((MoveButton*)self.delegate).ObjectClass == BUTTON || ((MoveButton*)self.delegate).ObjectClass == TILT ||
        ((MoveButton*)self.delegate).ObjectClass == LIQUID || ((MoveButton*)self.delegate).ObjectClass == ANGLE ||
        ((MoveButton*)self.delegate).ObjectClass == SOUNDSENSOR || ((MoveButton*)self.delegate).ObjectClass == IPADBUTTON) {
        return 2;
    }
    else if (((MoveButton*)self.delegate).ObjectClass == VIBRATION || ((MoveButton*)self.delegate).ObjectClass == SPEAKER ||
             ((MoveButton*)self.delegate).ObjectClass == IPADSOUND) {
        return 3;
    }
    else {
        return 4;
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    switch (((MoveButton*)self.delegate).ObjectClass) {
        case LED:
        {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Off";
            }
            else if (indexPath.row == 1) {
                cell.textLabel.text = @"Light";
            }
            else if (indexPath.row == 2) {
                cell.textLabel.text = @"Blink";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            else {
                cell.textLabel.text = @"Fade";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            break;
        }
        case VIBRATION:
        {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Off";
            }
            else if (indexPath.row == 1) {
                cell.textLabel.text = @"Vibrate";
            }
            else {
                cell.textLabel.text = @"Interval Vibrate";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            break;
        }
        case SPEAKER:
        {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Off";
            }
            else if (indexPath.row == 1) {
                cell.textLabel.text = @"On";
            }
            else {
                cell.textLabel.text = @"Alarm";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            break;
        }
        case BUTTON:
        {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Read";
            }
            else {
                cell.textLabel.text = @"Click";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            break;
        }
        case TILT:
        {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Read";
            }
            else {
                cell.textLabel.text = @"Tilt";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            break;
        }
        case LIQUID:
        {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Read";
            }
            else {
                cell.textLabel.text = @"Wet";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            break;
        }
        case ANGLE:
        case SOUNDSENSOR:
        {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Read";
            }
            else {
                cell.textLabel.text = @"Threshold";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            break;
        }
        case LIGHTSENSOR:
        case PRESSURESENSOR:
        {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Read";
            }
            else if (indexPath.row == 1) {
                cell.textLabel.text = @"Remember";
            }
            else if (indexPath.row == 2) {
                cell.textLabel.text = @"Threshold";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            else {
                cell.textLabel.text = @"Change";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            break;
        }
        case IPADBUTTON:
        {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Read";
            }
            else {
                cell.textLabel.text = @"Click";
            }
            break;
        }
        default: {  //IPADSOUND
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Off";
            }
            else if (indexPath.row == 1) {
                cell.textLabel.text = @"Alarm";
            }
            else {
                cell.textLabel.text = @"Melody";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            break;
        }
    }

    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //如果選擇的cell有下一層, push到對應的第二層
    if ([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"Threshold"] ||
            [[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"Change"]   ||
            [[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"Blink"]    ||
            [[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"Fade"]     ||
            [[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"Alarm"]    ||
            [[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"Interval Vibrate"])
        {       //LV2 use slider
            LV2SliderViewController *lv2SliderViewController = [[LV2SliderViewController alloc] initWithNibName:@"LV2SliderView" bundle:[NSBundle mainBundle]];
            lv2SliderViewController.delegate = self.delegate;
            lv2SliderViewController.act = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        
            [self.navigationController pushViewController:lv2SliderViewController animated:YES];
        }
        else {  //LV2 use table
            LV2TableViewController *lv2TableViewController = [[LV2TableViewController alloc] initWithNibName:@"LV2TableView" bundle:[NSBundle mainBundle]];
            lv2TableViewController.delegate = self.delegate;
            lv2TableViewController.act = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
            [self.navigationController pushViewController:lv2TableViewController animated:YES];
        }
    }
    //否則將選擇的內容回傳給delegate
    else
        [self.delegate didSelectRowWithAct:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
}


#pragma mark -
#pragma mark Memory management


- (void)dealloc {
   
}

@end

