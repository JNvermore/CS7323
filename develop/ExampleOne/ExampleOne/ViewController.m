//
//  ViewController.m
//  ExampleOne
//
//  Created by apple on 9/5/19.
//  Copyright © 2019 SMU. All rights reserved.
//

#import "ViewController.h"
#import "ImageModel.h"

@interface ViewController () <UIScrollViewDelegate>


// implement the class
@property (strong, nonatomic) ImageModel* myImageModel;
//@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImageView* imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

-(ImageModel*)myImageModel{
    if(!_myImageModel)
    // class function can just be called by function, not the implementation name
        _myImageModel = [ImageModel sharedInstance];
    return _myImageModel;
}

-(NSString*)imageName{
    
    if(!_imageName)
        _imageName = @"Eric1";
    
    return _imageName;
}

-(UIImageView*)imageView{
    if(!_imageView)
        _imageView = [[UIImageView alloc] initWithImage:[[ImageModel sharedInstance] getImageWithName:self.imageName]];
    return _imageView;
}

-(void)viewDidLoad {
    [super viewDidLoad];
//    self.imageView.image = [self.myImageModel getImageWithName:self.imageName];
    [self.scrollView addSubview:self.imageView];
    self.scrollView.contentSize = self.imageView.image.size;
    self.scrollView.minimumZoomScale = 0.1;
    self.scrollView.delegate = self;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return self.imageView;
}

@end
