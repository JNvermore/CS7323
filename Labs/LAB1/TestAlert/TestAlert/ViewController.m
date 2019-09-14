//
//  ViewController.m
//  TestAlert
//
//  Created by apple on 9/11/19.
//  Copyright © 2019 SMU. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)clickShowAlert:(id)sender {
    
    UIAlertController*alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Test for alert!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction*_Nonnull action){
        NSLog(@"OK button is pressed");
    }];
    
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
