//
//  VoiceHud.h
//  记事本之录音模块1.0
//
//  Created by ian on 14-4-10.
//  Copyright (c) 2014年 ian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VoiceHud : UIView

@property(nonatomic) float progress;

-(void) show;
-(void) hide;

@end
