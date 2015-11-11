//
//  ASCOperation.h
//  SearchClient
//
//  Created by Alex Hill on 10/28/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASCLoader, AFHTTPRequestOperation;

typedef NS_ENUM(NSInteger, ASCLoaderType) {
    ASCLoaderTypeDefault,
    ASCLoaderTypeWebSearch,
    ASCLoaderTypeImageSearch,
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
@property (nonatomic, copy) NSString *requestParameters;
@property (nonatomic, copy) NSString *request;
@property (nonatomic, strong) NSObject *result;
@property (nonatomic, strong) AFHTTPRequestOperation *operation;
@property (nonatomic, readonly) ASCLoaderType type;
@property (nonatomic) NSInteger *timeout;

+ (NSString *)baseSearchUrl;

- (instancetype)initWithDelegate:(NSObject<ASCLoaderDelegate> *)delegate;
- (instancetype)initWithCompletionBlock:(ASCLoaderCompletion)completion;

- (NSString *)createRequest;
- (void)processResponse;
- (void)startLoad;
- (void)cancelLoad;

@end
