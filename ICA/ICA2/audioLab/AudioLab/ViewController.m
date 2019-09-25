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
#import "AudioFileReader.h"

#define BUFFER_SIZE 2048

@interface ViewController ()
@property (strong, nonatomic) Novocaine *audioManager;
@property (strong, nonatomic) CircularBuffer *buffer;
@property (strong, nonatomic) SMUGraphHelper *graphHelper;
@property (strong, nonatomic) FFTHelper *fftHelper;
@property (strong, nonatomic) AudioFileReader *fileReader;

@property (nonatomic) float* equalizer;
@end



@implementation ViewController


#pragma mark Lazy Instantiation

-(float*)equalizer{
    if(!_equalizer){
        _equalizer = malloc(sizeof(float)*20);
    }
    return _equalizer;
}

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
                                                       numGraphs:3
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

-(AudioFileReader*)fileReader{
    if(!_fileReader){
        NSURL *inputFileURL = [[NSBundle mainBundle] URLForResource:@"satisfaction" withExtension:@"mp3"];
        _fileReader = [[AudioFileReader alloc]
                       initWithAudioFileURL:inputFileURL
                       samplingRate:self.audioManager.samplingRate
                       numChannels:self.audioManager.numOutputChannels];
    }
    return _fileReader;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:true];
    
    [self.audioManager pause];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:true];
    
    [self.audioManager play];
}
#pragma mark VC Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   
    [self.graphHelper setFullScreenBounds];
    
//    [self.fileReader play];
//    self.fileReader.currentTime = 0.0;
//
    __block ViewController * __weak  weakSelf = self;
    [self.audioManager setInputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels){
        [weakSelf.fileReader retrieveFreshAudio:data numFrames:numFrames numChannels:numChannels];
        [weakSelf.buffer addNewFloatData:data withNumSamples:numFrames];
        NSLog(@"Time: %f", weakSelf.fileReader.currentTime);

    }];
    
//    __block ViewController * __weak  weakSelf = self;
//    [self.audioManager setInputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels){
//        [weakSelf.buffer addNewFloatData:data withNumSamples:numFrames];
//    }];
    
    [self.audioManager play];
}

#pragma mark GLK Inherited Functions
//  override the GLKViewController update function, from OpenGLES
- (void)update{
    // just plot the audio stream
    
    // set the windows size = 20
    int windowsSize = (BUFFER_SIZE/2)/20;
    
    // get audio stream data
    float* arrayData = malloc(sizeof(float)*BUFFER_SIZE);
    float* fftMagnitude = malloc(sizeof(float)*BUFFER_SIZE/2);
    
    // get those 20 windows and find peak
    for(int i=0; i<20; i++){
        float currentMax = -1000.0;
        for(int j=i*windowsSize; j<(i+1)*windowsSize; j++){
            if(fftMagnitude[j]>currentMax){
                currentMax = fftMagnitude[j];
            }
        }
        micData[i] = currentMax;
    }
    NSLog(@" mic data %f", micData[0]);
    
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
    
    // graph the 3rd graph
    [self.graphHelper setGraphData:micData
                    withDataLength:BUFFER_SIZE/2
                     forGraphIndex:2
                 withNormalization:64.0
                     withZeroValue:-60];
    
    [self.graphHelper update]; // update the graph
    free(arrayData);
    free(fftMagnitude);
}

//  override the GLKView draw function, from OpenGLES
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [self.graphHelper draw]; // draw the graph
}


@end
