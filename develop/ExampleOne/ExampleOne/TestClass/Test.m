//
//  Test.m
//  ExampleOne
//
//  Created by apple on 9/5/19.
//  Copyright © 2019 SMU. All rights reserved.
//

#import "Test.h"

@implementation Test

@synthesize height;

-(id)init {
    self = [super init];
    length = 1.0;
    breadth = 1.0;
    return self;
}

-(double) volumn {
    return length * breadth * height;
}
@end
