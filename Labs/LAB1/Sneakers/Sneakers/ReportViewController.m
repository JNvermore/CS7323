//
//  ReportViewController.m
//  Sneakers
//
//  Created by apple on 9/11/19.
//  Copyright © 2019 SMU. All rights reserved.
//

#import "ReportViewController.h"
#import "EmailViewController.h"

@interface ReportViewController ()

@property (weak, nonatomic) IBOutlet UITextView *reportTextView;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UISwitch *fontColorSwitch;

@property (strong, nonatomic) EmailViewController* myEmailViewController;

@end

@implementation ReportViewController

-(EmailViewController*)myEmailViewController{
    if(!_myEmailViewController){
        _myEmailViewController = [EmailViewController sharedInstance];
    }
    return _myEmailViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


// -------------------- Submit Button ----------------------------
- (IBAction)clickToSubmit:(id)sender {
//    pop up a alert when some of text field is empty.
    if([self.firstNameTextField.text  isEqual: @""] || [self.lastNameTextField.text  isEqual: @""] || [self.phoneTextField.text  isEqual: @""] || [self.emailTextField isEqual:@""]){
        UIAlertController*amountAlert = [UIAlertController alertControllerWithTitle:@"Check Your Information!" message:@"Check Your information Filled In These Blank." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction*_Nonnull action){
        }];
        
        [amountAlert addAction:okAction];
        [self presentViewController:amountAlert animated:YES completion:nil];
    }else{
        UIAlertController*amountAlert = [UIAlertController alertControllerWithTitle:@"Success!" message:@"Information Submit Successfully!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction*_Nonnull action){
        }];
        
        [amountAlert addAction:okAction];
        [self presentViewController:amountAlert animated:YES completion:nil];
    }
    
}
// -------------------- Cancel Button -----------------------------
- (IBAction)clickToCancel:(id)sender {
//    clear content of all text field when click this button
    self.firstNameTextField.text = @"";
    self.lastNameTextField.text = @"";
    self.phoneTextField.text = @"";
    self.emailTextField.text = @"";
}

// --------------------- Switch ------------------------------
- (IBAction)fontColorSelection:(id)sender {
//    hidde or show the content in the text view.
    if(self.fontColorSwitch.isOn){
        self.reportTextView.text = @"This app is designed for CS7323 Lab 1.";
        self.reportTextView.textColor = [UIColor whiteColor];
    }else{
        self.reportTextView.text = @"This app is designed for CS7323 Lab 1.";
        self.reportTextView.textColor = [UIColor blackColor];
    }
}


- (IBAction)clickToReport:(id)sender {
//    jump to the report view
    EmailViewController *evc = [self.storyboard instantiateViewControllerWithIdentifier:@"EmailViewController"];
    evc.delegate = self;
    [self presentViewController:evc animated:YES completion:nil];
}

// --------------------- Proctocol Function ---------------------
- (void)sendEmail:(NSString *)email{
    self.reportTextView.textColor = [UIColor blackColor];
    NSLog(@"email: %@", email);
    self.reportTextView.text = email;
}


//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//
//    BOOL isEVC = [[segue destinationViewController] isKindOfClass:[EmailViewController class]];
//
//    if(isEVC){
//        EmailViewController *evc = [segue destinationViewController];
////        evc.email = self.emailTextLabel.text;
//    }
//
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
