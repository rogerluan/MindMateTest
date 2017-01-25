//
//  CompletionBlocks.h
//  MindMateApplication
//
//  Created by Roger Luan on 24/01/17.
//  Copyright © 2017 Roger Oba. All rights reserved.
//

#ifndef CompletionBlocks_h
#define CompletionBlocks_h

typedef void (^MMErrorCompletionBlock)(NSError * _Nullable error);
typedef void (^MMPersonalInfoCompletionBlock)(NSDictionary * _Nullable info, NSError * _Nullable error);
typedef void (^MMLoginCompletionBlock)(NSError * _Nullable error);

#endif /* CompletionBlocks_h */
