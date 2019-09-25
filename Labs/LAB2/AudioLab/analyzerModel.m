//
//  analyzerModel.m
//  AudioLab
//
//  Created by Xingming on 9/21/19.
//  Copyright © 2019 Eric Larson. All rights reserved.
//

#import "analyzerModel.h"


#define BUFFER_SIZE 2048*4
#define ORIGINAL_ARRAY_SIZE BUFFER_SIZE*2
#define WINDOW_SIZE 3

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

-(float*)addZeroAtHeadAndTailForArray:(float*)originalArray{
    // create a array with size 2 more than fftMagnitude, and add 0 to both head and tail
    
    float* modifiedArray = malloc(ORIGINAL_ARRAY_SIZE+2);
    
    modifiedArray[0] = 0;   // head
    for(int i=0; i<ORIGINAL_ARRAY_SIZE; i++){   // body
        modifiedArray[i+1] = originalArray[i];
    }
    modifiedArray[ORIGINAL_ARRAY_SIZE+1] = 0;   // tail
    
    return modifiedArray;
}


-(float*)getPeaksFromModifiedArray:(float*)array{
    
    // array for store peak values in a window
    float* peaksArray = malloc(ORIGINAL_ARRAY_SIZE+2);
    
    // find peak in a window
    for(int i=0; i<ORIGINAL_ARRAY_SIZE; i++){
        NSLog(@"i: %d", i);
//        float max = -10000000;
//        for(int j=i; j<j+WINDOW_SIZE; j++){
//            NSLog(@"j: %d", j);
//            if(array[j]>max){
//                max = array[j];
//                NSLog(@"j: %d", j);
//            }
//        }
        
//        peaksArray[i] = max;
    }
    return peaksArray;
}
@end
