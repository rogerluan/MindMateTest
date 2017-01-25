//
//  MMErrorManager.h
//  MindMateApplication
//
//  Created by Roger Luan on 24/01/17.
//  Copyright © 2017 Roger Oba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MMErrorIdentifier) {
    MMErrorSocialLoginEventCancelled = 1001,
    MMErrorPermissionsDenied
};

@interface MMErrorManager : NSObject

+ (NSError *)errorForErrorIdentifier:(MMErrorIdentifier)errorIdentifier;
+ (UIAlertController *)alertFromError:(NSError *)error;
+ (UIAlertController *)alertFromErrorIdentifier:(NSInteger)errorIdentifier;

@end
