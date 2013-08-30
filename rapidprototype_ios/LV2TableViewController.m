//
//  LV2TableViewController.m
//  RapidPototype
//
//  Created by yuyu on 13/5/14.
//  Copyright (c) 2013年 林震軒. All rights reserved.
//

#import "LV2TableViewController.h"

@interface LV2TableViewController ()

@end

@implementation LV2TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if ([self.act isEqualToString:@"Click"])     {[self.navigationItem setTitle:@"Click"];}
    else if ([self.act isEqualToString:@"Tile"]) {[self.navigationItem setTitle:@"Tilt"];}
    else if ([self.act isEqualToString:@"Wet"])  {[self.navigationItem setTitle:@"Wet"];}
    else /*             Melody              */   {[self.navigationItem setTitle:@"Melody"];}
}

- (void)viewWillAppear:(BOOL)animated
{
    self.contentSizeForViewInPopover = CGSizeMake(320, 200);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([self.act isEqualToString:@"Melody"]) {
        return 4;
    }
    else
        return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if ([self.act isEqualToString:@"Click"]) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"按下通過";
        }
        else {
            cell.textLabel.text = @"沒按下通過";
        }
    }
    else if ([self.act isEqualToString:@"Tilt"]) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"傾斜通過";
        }
        else {
            cell.textLabel.text = @"沒傾斜通過";
        }
    }
    else if ([self.act isEqualToString:@"Wet"]) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"有感測到液體通過";
        }
        else {
            cell.textLabel.text = @"沒感測到液體通過";
        }
    }
    else { //Moledy
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Guitar Chords";
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"Buzzer";
        }
        else if (indexPath.row == 2) {
            cell.textLabel.text = @"Clock tower";
        }
        else {
            cell.textLabel.text = @"Blues";
        }
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //回傳選擇的動作給編輯區
    [self.delegate didLv2WithAct:self.act andLv2Act:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
}


@end
