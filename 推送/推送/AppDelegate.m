//
//  AppDelegate.m
//  推送
//
//  Created by Ari on 16/10/9.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /**
     实现分类(快捷回复)的思路
     1. 在授权设置时, 设置分类信息;
        *1. 创建分类
        *2. 创建分类的按钮
        *3. 创建分类的无序集合
     
     2. 在发送通知的时候,设置category分类信息
     */
    
    //1. 创建分类 --> 需要使用子类可变子类 才能设置参数信息
    UIMutableUserNotificationCategory *ariCategory = [UIMutableUserNotificationCategory new];
    //1.1 标识符 --> 为了确保响应正确的按钮方法
    ariCategory.identifier = @"Mr.Ari";
    
    //2.设置按钮 --> 需要使用子类可变子类 才能设置参数信息
    UIMutableUserNotificationAction *action1 = [UIMutableUserNotificationAction new];
    //2.1标识符 -->为了确保能相应正确的通知
    action1.identifier = @"action1";
    //2.2运行模式 -->后台运行/后台运行
    action1.activationMode = UIUserNotificationActivationModeBackground;
    //2.3文字
    action1.title = @"确定";
    //2.4设置按钮行为  -->前台运行方式不要弄输入框形式,没必要,前台会打开app
    /**
     typedef NS_ENUM(NSUInteger, UIUserNotificationActionBehavior) {
     UIUserNotificationActionBehaviorDefault,        // the default action behavior
     UIUserNotificationActionBehaviorTextInput       // system provided action behavior, allows text input from the user
     }
     */
    action1.behavior = UIUserNotificationActionBehaviorTextInput;
    UIMutableUserNotificationAction *action2 = [UIMutableUserNotificationAction new];
    //2.1标识符 -->为了确保能相应正确的通知
    action2.identifier = @"action2";
    //2.2运行模式 -->后台运行/后台运行
    action2.activationMode = UIUserNotificationActivationModeForeground;
    //2.3文字
    action2.title = @"取消";

    [ariCategory setActions:@[action1,action2] forContext:UIUserNotificationActionContextDefault];
    //创建无序集合
    NSSet *categorySet = [NSSet setWithObjects:ariCategory, nil];
    
    
    //0.授权(启动时询问  一般写在appDelegate中,也可以放在首次加载的控制器中)
    //这个类在iOS8出现  推送通知发生过两次大的改动,一次是iOS8:8开始才需要授权.(而且通知的类型也发生了更改).
    //第二次大改变实在iOS 10 :将本地通知和远程推送抽取出来了.放到了UNUSerNotifications
    /**
     typedef NS_OPTIONS(NSUInteger, UIUserNotificationType) {
     UIUserNotificationTypeNone    = 0,      // the application may not present any UI upon a notification being received
     UIUserNotificationTypeBadge   = 1 << 0, // the application may badge its icon upon a notification being received 接受通知修改角标
     UIUserNotificationTypeSound   = 1 << 1, // the application may play a sound upon a notification being received  接受通知有声音
     UIUserNotificationTypeAlert   = 1 << 2, // the application may display an alert upon a notification being received  接受通知可弹出 alert
     }
     */
    UIUserNotificationSettings * settings = [UIUserNotificationSettings  settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:categorySet];
    /**
     注册用户通知设置
     
     @param UIUserNotificationSettings 用户通知设置
     */
    [application registerUserNotificationSettings:settings];
    
    return YES;
}

#pragma mark - 点击本地通知 进行接收处理
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    //这里可以解析userInfo,然后开发者自行处理
    //跳转控制器.. 弹出某个弹框....
    NSString *name = notification.userInfo[@"name"];
    NSLog(@"%@",name);
}
#pragma mark - 分类按钮点击的方法
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler{
    //区分两个分类按钮的点击 - 点击按钮后的逻辑代码 看程序需求
    if ([identifier isEqualToString:@"action1"]) {
        NSLog(@"后台按钮点击了");
    }else if ([identifier isEqualToString:@"action2"]){
        NSLog(@"前台按钮点击了");
    }
    //苹果会根据你写的这个回调的时间,来自动优化系统内部的调用
    completionHandler();
}
#pragma mark - iOS9 处理文本框通知的方法 - 这个方法实现了,上面的方法就不管用了 - iOS9以前会调用上面的方法
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)())completionHandler {
    //区分两个分类按钮的点击 - 点击按钮后的逻辑代码 看程序需求
    if ([identifier isEqualToString:@"action1"]) {
        NSLog(@"后台按钮点击了");
        //内容这样取
        NSLog(@"%@",responseInfo[UIUserNotificationActionResponseTypedTextKey]);
    }else if ([identifier isEqualToString:@"action2"]){
        NSLog(@"前台按钮点击了");
    }
    //苹果会根据你写的这个回调的时间,来自动优化系统内部的调用
    completionHandler();
}
@end
