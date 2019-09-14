//
//  ScrollViewController.m
//  Sneakers
//
//  Created by apple on 9/10/19.
//  Copyright © 2019 SMU. All rights reserved.
//

#import "ScrollViewController.h"
#import "ImageModel.h"

@interface ScrollViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollerImageView;
@property (strong, nonatomic) UIImageView* imageView;


@end

@implementation ScrollViewController

@synthesize scrollableImageName = _scrollableImageName;

-(NSString*)scrollableImageName{
    if(!_scrollableImageName){
        _scrollableImageName = @"Blush";
    }
    return _scrollableImageName;
}

-(UIImageView*)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] initWithImage:[[ImageModel sharedInstance] getImageWithName:self.scrollableImageName]];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.scrollerImageView addSubview:self.imageView];
    self.scrollerImageView.contentSize = self.imageView.image.size;
    self.scrollerImageView.minimumZoomScale = 0.3;
    self.scrollerImageView.delegate = self;
    
}

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
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
