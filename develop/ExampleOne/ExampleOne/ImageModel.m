//
//  ImageModel.m
//  ExampleOne
//
//  Created by apple on 9/5/19.
//  Copyright © 2019 SMU. All rights reserved.
//

#import "ImageModel.h"

// update properties to private
@interface ImageModel()
@property (strong, nonatomic) NSArray* imageNames;
@end

@implementation ImageModel
@synthesize imageNames = _imageNames;

-(NSArray*) imageNames{
    
    if(!_imageNames)
        _imageNames = @[@"Eric1", @"Eric2", @"Eric3"];
    
    return _imageNames;
}

+(ImageModel*) sharedInstance{

    static ImageModel* _sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[ImageModel alloc] init];
    });
    
    return _sharedInstance;
}

-(UIImage*)getImageWithName:(NSString *)name{
    UIImage* image = nil;
    image = [UIImage imageNamed:name];
    return image;
}

@end
