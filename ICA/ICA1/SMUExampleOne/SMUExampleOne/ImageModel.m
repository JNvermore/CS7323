//
//  ImageModel.m
//  SMUExampleOne
//
//  Created by Eric Larson on 1/21/15.
//  Copyright (c) 2015 Eric Larson. All rights reserved.
//

#import "ImageModel.h"

@interface ImageModel()

@property (strong,nonatomic) NSArray* imageNames;

@end

@implementation ImageModel
@synthesize imageNames = _imageNames;

-(NSArray*)imageNames{
    
    if(!_imageNames)
        _imageNames = @[@"Eric1", @"Eric2", @"Eric3", @"OBJC1", @"OBJC2", @"OBJC3"];
    
    return _imageNames;
}

-(NSArray*)preLoadImageToArray{
    //    NSMutableArray* imageMutableArray = [NSMutableArray array];
    //    NSArray* nameArray = [self imageNames];
    //    int count = (int)[nameArray count];
    //
    //    for(int i = 0; i<count; i++){
    //        UIImage* image = nil;
    //        image = nameArray[i];
    //        [imageMutableArray addObject:image];
    //    }
    
    //    NSArray* imageArray = [imageMutableArray copy];
    NSArray* imageArray = @[[self readImage:@"Eric1"] ,[self readImage:@"Eric2"],[self readImage:@"Eric3"], [self readImage:@"OBJC1"],[self readImage:@"OBJC2"],[self readImage:@"OBJC3"]];
    //    NSLog(@"num of pics: %d", imageArray.count);
    return imageArray;
    
}

-(UIImage*)readImage:(NSString*)name{
    UIImage* loadedImage = [UIImage imageNamed:name];
    return loadedImage;
}

-(NSUInteger)numOfPictures{
    return [self preLoadImageToArray].count;
}

-(NSString*)getImageNameByNSInteger:(NSInteger)index{
    //    NSString* name = self.imageNames[index];
    NSString* name = [[self imageNames] objectAtIndex:index];
    //    NSLog(@"image name: %@", _imageNames);
    return name;
}

-(UIImage*)getImageByNSInteger:(NSInteger)index{
    //    UIImage* image = [self preLoadImageToArray][index];
    UIImage* image = [[self preLoadImageToArray] objectAtIndex:index];
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

-(UIImage*)getImageWithName:(NSString *)name{
    UIImage* image = nil;
    image = [UIImage imageNamed:name];
    return image;
}

@end
