//
//  ASCOperation.h
//  SearchClient
//
//  Created by Alex Hill on 10/28/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASCLoader;

typedef NS_ENUM(NSInteger, ASCLoaderType) {
    ASCLoaderTypeDefault,
    ASCLoaderTypeSearch,
    ASCLoaderTypeWebSearch,
    ASCLoaderTypeImageSearch,
    ASCLoaderTypeNewsSearch,
    ASCLoaderTypeVideoSearch,
    ASCLoaderTypeRelatedSearch,
    ASCLoaderTypeImage
};

/**
 * @brief A delegate capable of handling loader success / failures
 */
@protocol ASCLoaderDelegate <NSObject>

- (void)loader:(ASCLoader *)loader didFinishWithFailure:(NSError *)error;
- (void)loaderDidFinishLoadWithSuccess:(ASCLoader *)loader;

@end

typedef void (^ASCLoaderCompletion)(ASCLoader *loader, NSError *error);

@interface ASCLoader : NSObject

/**
 * @brief The loader delegate
 */
@property (nonatomic, weak) id<ASCLoaderDelegate> delegate;

/**
 * @brief Block to be executed upon success / failure of the loader
 */
@property (nonatomic, readonly) ASCLoaderCompletion completion;

/**
 * @brief Request parameters used to create the requestUrl
 */
@property (nonatomic, copy) NSDictionary *requestParameters;

/**
 * @brief Url to retrieve data from
 */
@property (nonatomic, strong) NSURL *requestUrl;

/**
 * @brief The URLRequest that is constructed from the requestUrl
 */
@property (nonatomic, strong) NSURLRequest *request;

/**
 * @brief Response data received from the server
 */
@property (nonatomic, readonly) NSData *responseData;

/**
 * @brief Result that has been serialized and parsed into its final form
 */
@property (nonatomic, strong) NSObject *parsedResult;

@property (nonatomic, readonly) ASCLoaderType type;

- (instancetype)initWithDelegate:(NSObject<ASCLoaderDelegate> *)delegate;
- (instancetype)initWithCompletionBlock:(ASCLoaderCompletion)completion;

/**
 * @brief Creates the requestUrl using supplied requestParameters
 *
 * @warning Must override in subclass
 */
- (void)createRequest;

/**
 * @brief Parses the response into a system type
 *
 * @warning Must override in subclass
 */
- (void)processResponse;

/**
 * @brief Pre-loading phase in which the NSURLRequest is made
 */
- (void)prepareForLoad;

/**
 * @brief The only method that the user has to worry about calling, starts the loader
 */
- (void)startLoad;

/**
 * @brief Cancels the loader
 */
- (void)cancelLoad;

- (void)informDelegateLoadingFailed:(NSError *)error;
- (void)informDelegateLoadingFinished;

@end
