//
//  EmailViewController.h
//  Sneakers
//
//  Created by apple on 9/12/19.
//  Copyright © 2019 SMU. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// protocol to for pop up page
@protocol sendEmailAddressProtocol <NSObject>
-(void) sendEmail:(NSString*)email;
@end

@interface EmailViewController : UIViewController

@property(weak,nonatomic) id <sendEmailAddressProtocol> delegate;
@property NSString* email;
+(EmailViewController*) sharedInstance;

@end

NS_ASSUME_NONNULL_END
