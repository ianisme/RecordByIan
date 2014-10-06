//
//  Voice.m
//  记事本之录音模块1.0
//
//  Created by ian on 14-4-10.
//  Copyright (c) 2014年 ian. All rights reserved.
//

#import "Voice.h"
#import "VoiceHud.h"

#define WAVE_UPDATE_FREQUENCY   0.05

@implementation Voice

- (void)dealloc
{
    if (self.recorder.isRecording)
    {
        [self.recorder stop];
    }
    self.recorder = nil;
    self.recorder = nil;
    
    [super dealloc];
}

-(void)startRecordWithPath:(NSString *)path
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
	[audioSession setCategory :AVAudioSessionCategoryPlayAndRecord error:nil];
    
    [audioSession setActive:YES error:nil];
    
    NSMutableDictionary * recordSetting = [NSMutableDictionary dictionary];
	
	[recordSetting setValue :[NSNumber numberWithInt:kAudioFormatAppleIMA4] forKey:AVFormatIDKey];
	[recordSetting setValue:[NSNumber numberWithFloat:16000.0] forKey:AVSampleRateKey];
	[recordSetting setValue:[NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];

    self.recordPath = path;
	NSURL * url = [NSURL fileURLWithPath:self.recordPath];
    NSData * audioData = [NSData dataWithContentsOfFile:[url path] options: 0 error:nil];
    
	if(audioData)
	{
		NSFileManager *fm = [NSFileManager defaultManager];
		[fm removeItemAtPath:[url path] error:nil];
	}

    if(self.recorder){[self.recorder stop];self.recorder = nil;}
    
	self.recorder = [[[AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:nil] autorelease];
    
    // 设置代理
    _recorder.delegate = self;
    
    [_recorder prepareToRecord];
    _recorder.meteringEnabled = YES;
    
	
	[_recorder recordForDuration:(NSTimeInterval) 60];
    
    self.recordTime = 0;
    [self resetTimer];
    
	_timer = [NSTimer scheduledTimerWithTimeInterval:WAVE_UPDATE_FREQUENCY target:self selector:@selector(updateMeters) userInfo:nil repeats:YES];
    
    [self showVoiceHudOrHide:YES];

}

-(void) stopRecordWithCompletionBlock:(void (^)())completion
{
    dispatch_async(dispatch_get_main_queue(),completion);
    
    [self resetTimer];
    [self showVoiceHudOrHide:NO];
}

#pragma mark - Timer Update

- (void)updateMeters {
    
    self.recordTime += WAVE_UPDATE_FREQUENCY;
    
    if (_voiceHud)
    {
        /*  发送updateMeters消息来刷新平均和峰值功率。
         *  此计数是以对数刻度计量的，-160表示完全安静，
         *  0表示最大输入值
         */
        
        if (_recorder) {
            [_recorder updateMeters];
        }
        
        float peakPower = [_recorder averagePowerForChannel:0];
        double ALPHA = 0.05;
        double peakPowerForChannel = pow(10, (ALPHA * peakPower));
        
        [_voiceHud setProgress:peakPowerForChannel];
    }
}

#pragma mark - Helper Function

-(void) showVoiceHudOrHide:(BOOL)yesOrNo{
    
    if (_voiceHud) {
        [_voiceHud hide];
        _voiceHud = nil;
    }
    
    if (yesOrNo) {
        
        _voiceHud = [[VoiceHud alloc] init];
        [_voiceHud show];
        [_voiceHud release];
        
    }else{
        
    }
}

-(void) resetTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

-(void) cancelRecording
{
    if (self.recorder.isRecording) {
        [self.recorder stop];
    }
    
    self.recorder = nil;
}

- (void)cancelled {
    
    [self showVoiceHudOrHide:NO];
    [self resetTimer];
    [self cancelRecording];
}

#pragma mark - LCVoiceHud Delegate

-(void) LCVoiceHudCancelAction
{
    [self cancelled];
}


@end
