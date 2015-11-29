//
//  ASCOperation.h
//  SearchClient
//
//  Created by Alex Hill on 10/28/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@class ASCLoader;

typedef NS_ENUM(NSInteger, ASCLoaderType) {
    ASCLoaderTypeDefault,
    ASCLoaderTypeSearch,
    ASCLoaderTypeImage,
    ASCLoaderTypeLocalSearch
};

@protocol ASCLoaderDelegate <NSObject>

- (void)loader:(ASCLoader *)loader didFinishWithFailure:(NSError *)error;
- (void)loaderDidFinishLoadWithSuccess:(ASCLoader *)loader;

@end

typedef void (^ASCLoaderCompletion)(ASCLoader *loader, NSError *error);

@interface ASCLoader : NSObject

@property (nonatomic, weak) id<ASCLoaderDelegate> delegate;
@property (nonatomic, copy) ASCLoaderCompletion completion;
@property (nonatomic, copy) NSDictionary *requestParameters;
@property (nonatomic, strong) NSURL *request;
@property (nonatomic, strong) NSObject *responseObject;
@property (nonatomic, strong) NSObject *parsedResult;
@property (nonatomic, strong) AFHTTPRequestOperation *operation;
@property (nonatomic, readonly) ASCLoaderType type;
@property (nonatomic) NSInteger *timeout;

- (instancetype)initWithDelegate:(NSObject<ASCLoaderDelegate> *)delegate;
- (instancetype)initWithCompletionBlock:(ASCLoaderCompletion)completion;

- (void)createRequest;
- (void)processResponse;
- (void)prepareForLoad;
- (void)startLoad;
- (void)cancelLoad;

- (void)informDelegateLoadingFailed:(NSError *)error;
- (void)informDelegateLoadingFinished;

@end
