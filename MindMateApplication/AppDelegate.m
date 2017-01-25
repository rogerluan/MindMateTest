//
//  AppDelegate.m
//  MindMateApplication
//
//  Created by Roger Luan on 23/01/17.
//  Copyright © 2017 Roger Oba. All rights reserved.
//

#import "AppDelegate.h"
#import "FacebookManager.h"
#import "LoginManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FacebookManager application:application didFinishLaunchingWithOptions:launchOptions];
    
    if ([[LoginManager sharedManager] isUserAuthenticated]) {
        self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MainNavigationController"];
    }// else it'll just follow the login process normally.

    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [FacebookManager application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

@end
