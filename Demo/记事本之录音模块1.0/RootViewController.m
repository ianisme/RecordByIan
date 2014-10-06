//
//  RootViewController.m
//  记事本之录音模块1.0
//
//  Created by ian on 14-4-10.
//  Copyright (c) 2014年 ian. All rights reserved.
//

#import "RootViewController.h"
#import "RecordByIan.h"
@interface RootViewController ()
{
    NSString *temp;
}
// 创建录音界面UI
- (void)creatUI;

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"录音模块Demo";
    }
    return self;
}

- (void)creatUI
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((320-45)/2-55, 400, 45, 45);
    
    UIImage *btnImg = [UIImage imageNamed:@"mic"];
    UIImage *btnHightImg = [UIImage imageNamed:@"highLightMic"];
    [btn setBackgroundImage:btnImg forState:UIControlStateNormal];
    [btn setBackgroundImage:btnHightImg forState:UIControlStateHighlighted];
    
    [self.view addSubview:btn];

    
    __block UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    playBtn.frame = CGRectMake((320-45)/2+55, 400, 45, 45);
    playBtn.selected = NO;
    
    UIImage *playBtnImg = [UIImage imageNamed:@"play"];
    UIImage *playBtnHightImg = [UIImage imageNamed:@"stop"];
    [playBtn setBackgroundImage:playBtnImg forState:UIControlStateNormal];
    [playBtn setBackgroundImage:playBtnHightImg forState:UIControlStateSelected];
    [self.view addSubview:playBtn];
    RecordByIan *ian = [[RecordByIan alloc] init];
    [ian RecordButton:btn];
    ian.nameBlock=^(NSString * name)
    {
        temp = name;
        NSLog(@"此录音的名字%@",temp);
        [ian PlayBtn:playBtn andVoiceName:temp];
    };
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self creatUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
