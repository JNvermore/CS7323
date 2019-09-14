//
//  EmailViewController.m
//  Sneakers
//
//  Created by apple on 9/12/19.
//  Copyright © 2019 SMU. All rights reserved.
//

#import "EmailViewController.h"
#import "ReportViewController.h"

@interface EmailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextView *reportContentTextView;
@end

@implementation EmailViewController

+(EmailViewController*)sharedInstance{
    static EmailViewController * _sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate,^{
        _sharedInstance = [[EmailViewController alloc] init];
    });
    return _sharedInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(!_reportContentTextView){
        _reportContentTextView.text = @"Empty";
    }
}

// cilick this button to send the info in the text view to its super page, and show the content on text view
- (IBAction)touchToSend:(id)sender {
    [self.delegate sendEmail:self.reportContentTextView.text];
    NSLog(@"%@", self.reportContentTextView.text);
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
