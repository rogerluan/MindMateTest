//
//  LoginManager.h
//  MindMateApplication
//
//  Created by Roger Luan on 24/01/17.
//  Copyright © 2017 Roger Oba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompletionBlocks.h"

static NSString * const MMLoginTypeUserDefault = @"MMLoginTypeUserDefault";

typedef NS_ENUM(NSUInteger, MMLoginType) {
    MMLoginTypeFacebook = 1,
};

@protocol MMLoginManagerProtocol;

@interface LoginManager : NSObject

@property (nonatomic) MMLoginType strategy;

// Just in this case the delegate property type is strong, because the strategies will be instantiated on this class
@property (strong, nonatomic) id<MMLoginManagerProtocol> delegate;

+ (instancetype)sharedManager;

// The signature of the methods must be the same that the protocol because the handler is just a bridge for the real handler
- (void)loginWithCompletionBlock:(MMLoginCompletionBlock)completion;
- (void)logoutWithCompletionBlock:(MMErrorCompletionBlock)completion;
- (BOOL)isUserAuthenticated;

@end

@protocol MMLoginManagerProtocol <NSObject>

- (void)loginWithCompletionBlock:(MMLoginCompletionBlock)completion;
- (void)logoutWithCompletionBlock:(MMErrorCompletionBlock)completion;
- (BOOL)isUserAuthenticated;

@end
