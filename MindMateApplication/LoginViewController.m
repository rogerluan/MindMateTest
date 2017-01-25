//
//  LoginViewController.m
//  MindMateApplication
//
//  Created by Roger Luan on 24/01/17.
//  Copyright © 2017 Roger Oba. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginManager.h"

static NSString * const LoginSegueIdentifier = @"loginSegueIdentifier";

@implementation LoginViewController

- (IBAction)didPressSocialLoginButton:(UIButton *)sender {
    MMLoginType loginStrategy = (MMLoginType)sender.tag;
    [[LoginManager sharedManager] setStrategy:loginStrategy];
    [[LoginManager sharedManager] loginWithCompletionBlock:^(NSError * _Nullable error) {
        if (!error) {
            [self performSegueWithIdentifier:LoginSegueIdentifier sender:self];
        } else {
            if ([error.domain isEqualToString:[NSBundle mainBundle].bundleIdentifier] && error.code == MMErrorSocialLoginEventCancelled) {
                NSLog(@"User cancelled the login. The app shouldn't do anything.");
            } else {
                [self presentViewController:[MMErrorManager alertFromError:error] animated:YES completion:nil];
            }
        }
    }];
}
@end
