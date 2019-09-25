//
//  analyzerModel.m
//  AudioLab
//
//  Created by Xingming on 9/21/19.
//  Copyright © 2019 Eric Larson. All rights reserved.
//

#import "analyzerModel.h"


@implementation analyzerModel

#pragma mark Lazy Instantiation

-(void)setFrequency:(int)inputFreq{
    self.outputFrequency = inputFreq;
}


+(analyzerModel*)sharedInstance{
    static analyzerModel * _sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate,^{
        _sharedInstance = [[analyzerModel alloc] init];
    });
    
    return _sharedInstance;
}

-(Novocaine*)audioManager{
    if(!_audioManager){
        _audioManager = [Novocaine audioManager];
        NSLog(@"Finish init Novocaine audioManager");
    }
    return _audioManager;
}

-(void)playAudio {

    double frequency = self.outputFrequency * 1000;     //starting frequency
    __block float phase = 0.0;
    __block float samplingRate = self.audioManager.samplingRate;
    
    double phaseIncrement = 2*M_PI*frequency/samplingRate;
    double sineWaveRepeatMax = 2*M_PI;
    
    [self.audioManager setOutputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels)
     {
         for (int i=0; i < numFrames; ++i)
         {
             data[i] = sin(phase);
//             NSLog(@"%.f",sin(phase));
             phase += phaseIncrement;
             if (phase >= sineWaveRepeatMax) phase -= sineWaveRepeatMax;
         }
     }];
    
    [self.audioManager play];
    
}

-(void)stopAudio {
    [self.audioManager setOutputBlock:nil];
}

@end
