RecordByIan
===========

一款实现录音以及播放的框架

<p>
0.此库采取手动内存管理（MRC）
</p>
<p>
1.此库可以录音保存到沙盒中,名字是当前系统时间
</p>
<p>
2.可以返回录音的文件名字3.可以播放录音
</p>
<p>
3.此库需要导入的框架有:
</p>
<p>
AVFoundation.framework
</p>
<p>
4.通过调用以下方法可以获得不同的信息:<br />
<br />
// 传入录音的按钮,松开按钮,录音保存成功<br />
- (void)RecordButton:(UIButton *)RecordBtn;<br />
<br />
// 传入播放按钮,以及音频文件的地址<br />
- (void)PlayBtn:(UIButton *)PlayBtn andVoiceName:(NSString *)voiceName;<br />
<br />
对象.nameBlock=^(NSString * name)<br />
{<br />
&nbsp; &nbsp; 保存录音文件路径的变量 = name;<br />
};
</p>