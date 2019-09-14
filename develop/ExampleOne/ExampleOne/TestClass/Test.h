//
//  Test.h
//  ExampleOne
//
//  Created by apple on 9/5/19.
//  Copyright © 2019 SMU. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Test : NSObject {
    double length;
    double breadth;
}

@property(nonatomic, readwrite) double height;
-(double)volumn;
@end

NS_ASSUME_NONNULL_END
