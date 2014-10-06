//
//  RecordByIan.h
//  记事本之录音模块1.0
//
//  Created by ian on 14-4-12.
//  Copyright (c) 2014年 ian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Voice.h"
typedef void (^blackName)(NSString *);
@interface RecordByIan : NSObject

{
    // 定义一个临时变量给播放器提供文件名字
    NSString *_tempName;
    NSURL *url;
    AVAudioPlayer *player;
}

@property (nonatomic, retain) Voice * voice;
@property (nonatomic, copy) blackName nameBlock;
- (void)RecordButton:(UIButton *)RecordBtn;
- (void)PlayBtn:(UIButton *)PlayBtn andVoiceName:(NSString *)voiceName;
@end
