//
//  Voice.h
//  记事本之录音模块1.0
//
//  Created by ian on 14-4-10.
//  Copyright (c) 2014年 ian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@class VoiceHud;
@interface Voice : NSObject<AVAudioRecorderDelegate>
{
    NSTimer *_timer;
    VoiceHud *_voiceHud;
    
}
@property (nonatomic, retain)NSString *recordPath;
@property (nonatomic) float recordTime;
@property (nonatomic,retain) AVAudioRecorder * recorder;

- (void)startRecordWithPath:(NSString *)path;
- (void)stopRecordWithCompletionBlock:(void (^)())completion;
- (void)cancelled;
@end
