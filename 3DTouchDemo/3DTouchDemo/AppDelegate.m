//
//  AppDelegate.m
//  3DTouchDemo
//
//  Created by 王颜华 on 16/4/15.
//  Copyright © 2016年 EmyWong. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)createShortCutItem
{
    UIApplicationShortcutIcon *loveIcon = [UIApplicationShortcutIcon iconWithType:(UIApplicationShortcutIconTypeLove)];
    UIApplicationShortcutIcon *shareIcon = [UIApplicationShortcutIcon iconWithType:(UIApplicationShortcutIconTypeShare)];
    
    UIApplicationShortcutItem *loveItem = [[UIApplicationShortcutItem alloc]initWithType:@"emywong.love" localizedTitle:@"喜欢" localizedSubtitle:@"收藏的内容尽收眼底" icon:loveIcon userInfo:nil];
    UIApplicationShortcutItem *shareItem = [[UIApplicationShortcutItem alloc]initWithType:@"emywong.share" localizedTitle:@"分享" localizedSubtitle:@"分享收获快乐" icon:shareIcon userInfo:nil];
    
    [UIApplication sharedApplication].shortcutItems = @[loveItem,shareItem];
    
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    if ([shortcutItem.type isEqualToString:@"emywong.love"]) {
        
        SecondViewController *secondVC = [SecondViewController new];
        [self.window.rootViewController showViewController:secondVC sender:nil];
        NSLog(@"喜欢");
    }
    else
    {
        ThirdViewController *thirdVC =[ThirdViewController new];
        [self.window.rootViewController showViewController:thirdVC sender:nil];
    }
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self createShortCutItem];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
