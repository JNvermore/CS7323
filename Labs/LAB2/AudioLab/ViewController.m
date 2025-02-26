//
//  ViewController.m
//  AudioLab
//
//  Created by Eric Larson
//  Copyright © 2016 Eric Larson. All rights reserved.
//

#import "ViewController.h"
#import "Novocaine.h"
#import "CircularBuffer.h"
#import "SMUGraphHelper.h"
#import "FFTHelper.h"
#import "analyzerModel.h"

#define BUFFER_SIZE 2048*4

@interface ViewController ()
@property (strong, nonatomic) Novocaine *audioManager;
@property (strong, nonatomic) CircularBuffer *buffer;
@property (weak, nonatomic) IBOutlet UISwitch *lockInSwitch;
@property (strong, nonatomic) SMUGraphHelper *graphHelper;
@property (strong, nonatomic) FFTHelper *fftHelper;
@property (strong, nonatomic) analyzerModel *analyzerModel;

@property float* arrayLocked;
@property float* addedZeroArray;
@end



@implementation ViewController

#pragma mark Lazy Instantiation
-(Novocaine*)audioManager{
    if(!_audioManager){
        _audioManager = [Novocaine audioManager];
    }
    return _audioManager;
}

-(CircularBuffer*)buffer{
    if(!_buffer){
        _buffer = [[CircularBuffer alloc]initWithNumChannels:1 andBufferSize:BUFFER_SIZE];
    }
    return _buffer;
}

-(SMUGraphHelper*)graphHelper{
    if(!_graphHelper){
        _graphHelper = [[SMUGraphHelper alloc]initWithController:self
                                        preferredFramesPerSecond:15
                                                       numGraphs:2
                                                       plotStyle:PlotStyleSeparated
                                               maxPointsPerGraph:BUFFER_SIZE];
    }
    return _graphHelper;
}

-(FFTHelper*)fftHelper{
    if(!_fftHelper){
        _fftHelper = [[FFTHelper alloc]initWithFFTSize:BUFFER_SIZE];
    }
    
    return _fftHelper;
}

- (analyzerModel *)analyzerModel{
    if(!_analyzerModel){
        _analyzerModel = [analyzerModel sharedInstance];
    }
    return _analyzerModel;
}



#pragma mark VC Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   
    [self.graphHelper setFullScreenBounds];
    
    __block ViewController * __weak  weakSelf = self;
    [self.audioManager setInputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels){
        [weakSelf.buffer addNewFloatData:data withNumSamples:numFrames];
    }];
    
    [self.audioManager play];
}

#pragma mark GLK Inherited Functions
//  override the GLKViewController update function, from OpenGLES
- (void)update{
    // just plot the audio stream
    
    if (self.lockInSwitch.isOn == false){
        // get audio stream data
        float* arrayData = malloc(sizeof(float)*BUFFER_SIZE);
        float* fftMagnitude = malloc(sizeof(float)*BUFFER_SIZE/2);
        
        [self.buffer fetchFreshData:arrayData withNumSamples:BUFFER_SIZE];
    
        //send off for graphing
        [self.graphHelper setGraphData:arrayData
                        withDataLength:BUFFER_SIZE
                         forGraphIndex:0];
    
        // take forward FFT
        [self.fftHelper performForwardFFTWithData:arrayData
                       andCopydBMagnitudeToBuffer:fftMagnitude];
    
        // graph the FFT Data
        [self.graphHelper setGraphData:fftMagnitude
                        withDataLength:BUFFER_SIZE/2
                         forGraphIndex:1
                     withNormalization:64.0
                        withZeroValue:-60];
    
        [self.graphHelper update]; // update the graph
    
        self.arrayLocked = fftMagnitude;
        free(arrayData);
        free(fftMagnitude);
    }else{
        // ------------ ERROR HAPPENED -------------------
        // malloc: Incorrect checksum for freed object 0x7fa8068eb800: probably modified after being freed.
        float* fftMagnitudeAddZero = [self.analyzerModel addZeroAtHeadAndTailForArray:self.arrayLocked];
        
        //    float *peaksArray = [self.analyzerModel getPeaksFromModifiedArray:fftMagnitudeAddZero];
    }
}

//  override the GLKView draw function, from OpenGLES
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [self.graphHelper draw]; // draw the graph
}


@end
