//
//  ASCNetwork.m
//  SearchClient
//
//  Created by Alex Hill on 12/2/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCNetwork.h"

@interface ASCNetwork () <NSURLSessionDelegate, NSURLSessionTaskDelegate>

@property (strong) NSURLSession *urlSession;

@end

@implementation ASCNetwork

+ (instancetype)sharedInstance {
    static ASCNetwork *sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.urlSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    }
    
    return self;
}

- (void)fetchDataWithUrlRequest:(NSURLRequest *)request completion:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completion {
    NSURLSessionDataTask *task = [self.urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion(data, response, error);
    }];
    
    [task resume];
}

- (void)cancelFetchWithUrlRequest:(NSURLRequest *)request {
    [self.urlSession getAllTasksWithCompletionHandler:^(NSArray<__kindof NSURLSessionTask *> * _Nonnull tasks) {
        [tasks enumerateObjectsUsingBlock:^(__kindof NSURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.originalRequest isEqual:request]) {
                [obj cancel];
                *stop = YES;
            }
        }];
    }];
}

@end
