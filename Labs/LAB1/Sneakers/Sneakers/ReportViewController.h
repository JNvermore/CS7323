//
//  ReportViewController.h
//  Sneakers
//
//  Created by apple on 9/11/19.
//  Copyright © 2019 SMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmailViewController.h"

NS_ASSUME_NONNULL_BEGIN

// define a protocol to send email address filled in the report page to a pop up page.

@interface ReportViewController : UIViewController <UITextViewDelegate, sendEmailAddressProtocol>

@property (weak, nonatomic) IBOutlet UITextField *emailTextLabel;

@end

NS_ASSUME_NONNULL_END
