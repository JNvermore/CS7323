//
//  Products.h
//  Sneakers
//
//  Created by apple on 9/9/19.
//  Copyright © 2019 SMU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Products : NSObject

@property(strong,nonatomic) NSArray* productsNames;
@property(strong,nonatomic) NSArray* colorsOfYz350;
@property(strong,nonatomic) NSArray* colorsOfYz500;
@property(strong,nonatomic) NSArray* colorsOfYz700;

-(NSString*)getProductNameWithIndex:(NSInteger)index;
-(NSArray*)getColorsWithName:(NSString*)name;
-(NSInteger)getPriceWithName:(NSString*)name;

+(Products*)sharedInstance;

@end

NS_ASSUME_NONNULL_END
