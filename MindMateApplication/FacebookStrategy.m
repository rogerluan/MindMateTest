//
//  FacebookStrategy.m
//  MindMateApplication
//
//  Created by Roger Luan on 24/01/17.
//  Copyright © 2017 Roger Oba. All rights reserved.
//

#import "FacebookStrategy.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "MMErrorManager.h"

@implementation FacebookStrategy

- (void)loginWithCompletionBlock:(MMLoginCompletionBlock)completion {
    if ([FBSDKAccessToken currentAccessToken]) { //user is already logged in
        completion(nil);
    } else {
        FBSDKLoginManager *login = [FBSDKLoginManager new];
        login.loginBehavior = FBSDKLoginBehaviorSystemAccount;
        [login logInWithReadPermissions:@[@"email", @"public_profile", @"user_friends"] fromViewController:nil handler:^(FBSDKLoginManagerLoginResult *result, NSError *facebookLoginError) {
            if (facebookLoginError) {
                NSLog(@"Facebook login did error.");
                completion(facebookLoginError);
            } else if (result.isCancelled) {
                NSLog(@"Facebook login was cancelled.");
                completion([MMErrorManager errorForErrorIdentifier:MMErrorSocialLoginEventCancelled]);
            } else {
                if (result.declinedPermissions.count == 0) { //everything went well, user accepted all the permissions
                    completion(nil);
                } else { //user denied one or more permissions
                    completion([MMErrorManager errorForErrorIdentifier:MMErrorPermissionsDenied]);
                }
            }
        }];
    }
}

- (void)logoutWithCompletionBlock:(MMErrorCompletionBlock)completion {
    //apparently, facebook SDK doesn't offer a block method for logout action
    [[FBSDKLoginManager new] logOut];
    completion(nil);
}

- (BOOL)isUserAuthenticated {
    return [FBSDKAccessToken currentAccessToken] ? YES : NO;
}

@end
