//
//  ViewController.h
//  Sneakers
//
//  Created by apple on 9/8/19.
//  Copyright © 2019 SMU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSString*imageName;
@property (strong, nonatomic) NSString*productName;


@end

