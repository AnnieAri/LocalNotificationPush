//
//  ViewController.m
//  推送
//
//  Created by Ari on 16/10/9.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (IBAction)sendLocalNotifacationClick:(id)sender {
    //0.授权(启动时询问  一般写在appDelegate中)
    
    //1.创建本地通知
    UILocalNotification *ln = [[UILocalNotification alloc] init];
    //2.设置相关属性
    //必选的4个参数!
    //2.1触发时间 --> 方便演示 设置5秒后触发
    ln.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    
    //2.2 推送内容
    ln.alertBody = @"无边落木萧萧下,不尽长江滚滚来";
    
    //2.3 声音 --> 可以自定义声音  必须放到bundle目录下
    ln.soundName = UILocalNotificationDefaultSoundName;
    //2.4 数字角标
    ln.applicationIconBadgeNumber = 1;
    
//    //2.5 其他属性 - 设置重复  0是默认不重复 - 最小单位为1分钟
//    ln.repeatInterval = NSCalendarUnitMinute;
//    
//    //2.6 设置锁屏的底部字样/提醒样式的按钮文字;
//    ln.alertAction = @"庄生晓梦迷蝴蝶,望帝春心托杜鹃.";
//    //2.7 用户信息 -->为了处理通知,可以通过这个属性判断 -->当点击了通知的时候,可以根据UserInfo解析来处理 / 为了删除指定通知,也可以通过userinfo进行判断.
    ln.userInfo = @{@"name" : @"Ari"};
    //2.8 设置分类 -->其实就是分类的标识符
    ln.category = @"Mr.Ari";
    //3.调度通知 -->将本地通知添加到调度池中
    [[UIApplication sharedApplication] scheduleLocalNotification:ln];
}
#pragma mark - 删除指定通知
- (IBAction)cancelLoctionNotification:(id)sender {
    //1. 获取所有的通知
    NSLog(@"删除前: local:%@",[[UIApplication sharedApplication] scheduledLocalNotifications]);
    //2. 遍历查找指定的通知 -->通过userInfo
    for (UILocalNotification *ln in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        if ([ln.userInfo[@"name"] isEqualToString:@"Ari"]) {
            [[UIApplication sharedApplication] cancelLocalNotification:ln];
        }
    }
    NSLog(@"删除后: local:%@",[[UIApplication sharedApplication] scheduledLocalNotifications]);
}
#pragma mark - 删除全部通知
- (IBAction)cancelAllNotifications:(id)sender {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
