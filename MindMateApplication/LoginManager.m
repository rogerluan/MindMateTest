//
//  LoginManager.m
//  MindMateApplication
//
//  Created by Roger Luan on 24/01/17.
//  Copyright © 2017 Roger Oba. All rights reserved.
//

#import "LoginManager.h"
#import "FacebookStrategy.h"

@implementation LoginManager

+ (instancetype)sharedManager {
    static LoginManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [self new];
        MMLoginType strategy = (MMLoginType)[[NSUserDefaults standardUserDefaults] integerForKey:MMLoginTypeUserDefault];
        if (strategy > 0) {
            [sharedManager setStrategy:strategy];
        }
    });
    return sharedManager;
}

- (void)setStrategy:(MMLoginType)strategy {
    [[NSUserDefaults standardUserDefaults] setInteger:strategy forKey:MMLoginTypeUserDefault];
    [[NSUserDefaults standardUserDefaults] synchronize];
    switch (strategy) {
            case MMLoginTypeFacebook:
            self.delegate = [FacebookStrategy new];
            break;
    }
}

- (void)loginWithCompletionBlock:(MMLoginCompletionBlock)completion {
    [self.delegate loginWithCompletionBlock:^(NSError *loginError) {
        completion(loginError);
    }];
}

- (void)logoutWithCompletionBlock:(MMErrorCompletionBlock)completion {
    [self.delegate logoutWithCompletionBlock:^(NSError *error) {
        completion(error);
    }];
}

- (BOOL)isUserAuthenticated {
    return [self.delegate isUserAuthenticated];
}

@end
