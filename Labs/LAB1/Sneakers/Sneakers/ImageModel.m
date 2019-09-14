//
//  ImageModel.m
//  Sneakers
//
//  Created by apple on 9/9/19.
//  Copyright © 2019 SMU. All rights reserved.
//

#import "ImageModel.h"

@interface ImageModel()
@end

@implementation ImageModel

@synthesize imageNames = _imageNames;

-(NSArray*)imageNames{
//    return array pf image names
    if(!_imageNames)
        _imageNames = @[@"Black Non-Reflective",@"Blush",@"Clay",@"Crame White", @"Inertia",@"Mauve",@"Moon Yellow",@"Salt",@"Uriliry Black",@"Vanta",@"Wave Runner",@"Zebra"];
    
    return _imageNames;
}

-(UIImage*)getImageWithName:(NSString *)name{
    UIImage* image = [UIImage imageNamed:name];
    return image;
}



+(ImageModel*)sharedInstance{
    static ImageModel * _sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate,^{
        _sharedInstance = [[ImageModel alloc] init];
    });
    
    return _sharedInstance;
}



@end
