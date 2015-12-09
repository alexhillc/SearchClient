//
//  ASCNetwork.h
//  SearchClient
//
//  Created by Alex Hill on 12/2/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASCNetwork : NSObject

@property (readonly) NSURLSession *urlSession;

+ (instancetype)sharedInstance;

/**
 * @brief Submits an NSURLRequest to the network singleton's NSURLSession
 */
- (void)fetchDataWithUrlRequest:(NSURLRequest *)request completion:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completion;

/**
 * @brief Cancels the dataTask with the specified NSURLRequest
 */
- (void)cancelFetchWithUrlRequest:(NSURLRequest *)request;

@end
