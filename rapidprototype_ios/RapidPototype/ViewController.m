//
//  ViewController.m
//  RapidPototype
//
//  Created by 林震軒 on 13/4/27.
//  Copyright (c) 2013年 林震軒. All rights reserved.
//

#import "ViewController.h"
#import "ProjectName.h"
#import "NewProjectViewController_1.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [self.Scroll_Example setScrollEnabled:YES];
    [self.Scroll_Example setContentSize:CGSizeMake(1200, 142)];
    
    [self.Scroll_Open setScrollEnabled:YES];
    [self.Scroll_Open setContentSize:CGSizeMake(1000, 143)];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //
}
- (IBAction)Open1:(UIButton *)sender {
    NewProjectViewController_1 *newProViewController = [[NewProjectViewController_1 alloc] initWithNibName:@"NewProjectViewController_1" title:@"Open1" bundle:nil];

    
    [self.navigationController pushViewController:newProViewController animated:YES];
}

- (IBAction)Open2:(UIButton *)sender {
    NewProjectViewController_1 *newProViewController = [[NewProjectViewController_1 alloc] initWithNibName:@"NewProjectViewController_1" title:@"Open2" bundle:nil];
    [self.navigationController pushViewController:newProViewController animated:YES];
}

- (IBAction)Open3:(UIButton *)sender {
    NewProjectViewController_1 *newProViewController = [[NewProjectViewController_1 alloc] initWithNibName:@"NewProjectViewController_1" title:@"Open3" bundle:nil];
    [self.navigationController pushViewController:newProViewController animated:YES];
}

- (IBAction)Open4:(UIButton *)sender {
    NewProjectViewController_1 *newProViewController = [[NewProjectViewController_1 alloc] initWithNibName:@"NewProjectViewController_1" title:@"Open4" bundle:nil];
    [self.navigationController pushViewController:newProViewController animated:YES];
}

- (IBAction)Open5:(UIButton *)sender {
    NewProjectViewController_1 *newProViewController = [[NewProjectViewController_1 alloc] initWithNibName:@"NewProjectViewController_1" title:@"Open5" bundle:nil];
    [self.navigationController pushViewController:newProViewController animated:YES];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex

{
    
    if (buttonIndex == 1){
        NSLog(@"TextField contents:%@",[[alertView textFieldAtIndex:0] text]);
    ;
        NewProjectViewController_1 *newProViewController = [[NewProjectViewController_1 alloc] initWithNibName:@"NewProjectViewController_1" title:[NSString stringWithFormat:@"%@",[[alertView textFieldAtIndex:0] text]] bundle:nil];
        
        
    [self.navigationController pushViewController:newProViewController animated:YES];
    }
    
}
-(IBAction)createNew:(UIButton *)sender{

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New Project"
                                                    message:@"輸入專案名稱"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Ok", nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
    
    _ProjectState = 1;

}

#pragma mark - Storyboard

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//    
//    if ([segue.identifier isEqualToString:@"NewProject"]) {
//        // Fetch data by index path from data source
//         
//        // Feed data to the destination of the segue
//        NewProjectViewController_1 *detailPage = segue.destinationViewController;
//        
//        detailPage.receiveID = _ProjectState;
//        NSLog(@"ID is %ld",(long)detailPage.receiveID);
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
