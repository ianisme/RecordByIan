//
//  RecordByIan.m
//  记事本之录音模块1.0
//
//  Created by ian on 14-4-12.
//  Copyright (c) 2014年 ian. All rights reserved.
//

#import "RecordByIan.h"
@implementation RecordByIan

- (void)dealloc
{
    [_voice release];
    [_tempName release];
    [super dealloc];
}
// 修改初始化方法
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.voice = [[[Voice alloc] init] autorelease];
    }
    return self;
}

- (void)RecordButton:(UIButton *)RecordBtn
{
    [RecordBtn addTarget:self action:@selector(recordStart) forControlEvents:UIControlEventTouchDown];
    [RecordBtn addTarget:self action:@selector(recordEnd) forControlEvents:UIControlEventTouchUpInside];
}

- (void)PlayBtn:(UIButton *)PlayBtn andVoiceName:(NSString *)voicePath
{
    [PlayBtn addTarget:self action:@selector(playVoice:) forControlEvents:UIControlEventTouchUpInside];
     url = [[NSURL alloc] initFileURLWithPath:voicePath];
}




- (void)recordStart
{
    
    // 获取系统当前时间给声音文件命名
    NSDate *senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMddhhmmss"];
    NSString *locationString=[dateformatter stringFromDate:senddate];
    NSLog(@"locationString:%@.caf",locationString);
    [dateformatter release];
    
    [self.voice startRecordWithPath:[NSString stringWithFormat:@"%@/Documents/voice%@.caf", NSHomeDirectory(),locationString]];
    _tempName = [[NSString stringWithFormat:@"/voice%@.caf",locationString] retain];
    NSLog(@"阿克苏的徕卡收到了卡机%@",_tempName);
    
}

- (void)recordEnd
{
    [self.voice stopRecordWithCompletionBlock:^{
        
        if (self.voice.recordTime > 0.0f) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"\n录音成功! \n路径:%@ \n时长:%f",self.voice.recordPath,self.voice.recordTime] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            [self.voice cancelled];
        }
        
    }];
    self.nameBlock(self.voice.recordPath);
}


- (void)playVoice:(UIButton *)btn
{
    
    if (btn.selected)
    {
        btn.selected = NO;
        [player stop];
        NSLog(@"播放停止");
    }
    else
    {
        btn.selected = YES;
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [url release];
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategorySoloAmbient error:nil];
        player.volume = 1.0;
        [player prepareToPlay];
        if ([player play]) {
            NSLog(@"正在播放");
        }
    }

    //NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
   // NSLog(@"看看沙盒的路径%@",path);
    
  //  NSString *voicePath = [path stringByAppendingString:_tempName];
   // NSLog(@"测试一下:%@",_tempName);
    
    

}


@end
