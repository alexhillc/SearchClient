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

- (void)fetchDataWithUrlRequest:(NSURLRequest *)request completion:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completion;
- (void)cancelFetchWithUrlRequest:(NSURLRequest *)request;

@end
