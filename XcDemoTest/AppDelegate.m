//
//  AppDelegate.m
//  XcDemoTest
//
//  Created by shiran on 2020/9/14.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:tabBar];
    ViewController *mainVC = [[ViewController alloc] init];
    mainVC.tabBarItem.title = @"Main";
    mainVC.tabBarItem.badgeValue = @"3";
    [tabBar addChildViewController:mainVC];
    tabBar.tabBar.tintColor = [UIColor orangeColor];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}




@end
