//
//  analyzerModel.h
//  AudioLab
//
//  Created by Xingming on 9/21/19.
//  Copyright © 2019 Eric Larson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Novocaine.h"
NS_ASSUME_NONNULL_BEGIN

@interface analyzerModel : NSObject
@property (strong, nonatomic) Novocaine *audioManager;
+(analyzerModel*) sharedInstance;
@property (nonatomic) int outputFrequency;
-(void)setFrequency:(int)inputFreq;
-(void)playAudio;
-(void)stopAudio;
-(float*)addZeroAtHeadAndTailForArray:(float*)originalArray;
-(float*)getPeaksFromModifiedArray:(float*)array;
@end

NS_ASSUME_NONNULL_END
