//
//  ImageModel.h
//  Sneakers
//
//  Created by apple on 9/9/19.
//  Copyright © 2019 SMU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageModel : NSObject
@property (strong,nonatomic) NSArray* imageNames;

+(ImageModel*) sharedInstance;

-(UIImage*)getImageWithName:(NSString*)name;

@end

NS_ASSUME_NONNULL_END
