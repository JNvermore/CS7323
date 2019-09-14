//
//  Products.m
//  Sneakers
//
//  Created by apple on 9/9/19.
//  Copyright © 2019 SMU. All rights reserved.
//

#import "Products.h"



@implementation Products

@synthesize productsNames = _productsNames;
@synthesize colorsOfYz350 = _colorsOfYz350;
@synthesize colorsOfYz500 = _colorsOfYz500;
@synthesize colorsOfYz700 = _colorsOfYz700;

-(NSArray*)productsNames{
    //   return array of products names
    if(!_productsNames){
        _productsNames = @[@"YEEZY 350V2",@"YEEZY 500",@"YEEZY 700"];
    }
    return _productsNames;
}

-(NSArray*)colorsOfYz350{
    if(!_colorsOfYz350){
        _colorsOfYz350 = @[@"Crame White",@"Black Non-Reflective",@"Clay",@"Zebra"];
    }
    return _colorsOfYz350;
}

-(NSArray*)colorsOfYz500{
    if(!_colorsOfYz500){
        _colorsOfYz500 = @[@"Uriliry Black",@"Salt",@"Blush",@"Moon Yellow"];
    }
    return _colorsOfYz500;
}

-(NSArray*)colorsOfYz700{
    if(!_colorsOfYz700){
        _colorsOfYz700 = @[@"Wave Runner",@"Inertia",@"Vanta",@"Mauve"];
    }
    return _colorsOfYz700;
}

-(NSString*)getProductNameWithIndex:(NSInteger)index{
    //    get a product name with a index
    NSString* productName = [self.productsNames objectAtIndex:index];
    return productName;
}

-(NSArray*)getColorsWithName:(NSString*)name{
    if([name rangeOfString:@"350"].location != NSNotFound){
        return self.colorsOfYz350;
    }
    else if ([name rangeOfString:@"500"].location != NSNotFound){
        return self.colorsOfYz500;
    }
    else if([name rangeOfString:@"700"].location != NSNotFound){
        return self.colorsOfYz700;
    }else{
        return @[@""];
    }
    
}

-(NSInteger)getPriceWithName:(NSString*)name{
    if([name rangeOfString:@"350"].location != NSNotFound){
        return 220;
    }
    else if ([name rangeOfString:@"500"].location != NSNotFound){
        return 200;
    }
    else if([name rangeOfString:@"700"].location != NSNotFound){
        return 320;
    }else{
        return 0;
    }
}

+(Products*)sharedInstance{
    static Products * _sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate,^{
        _sharedInstance = [[Products alloc] init];
    });
    
    return _sharedInstance;
}
@end
