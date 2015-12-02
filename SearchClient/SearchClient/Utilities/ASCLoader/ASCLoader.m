//
//  ASCOperation.m
//  SearchClient
//
//  Created by Alex Hill on 10/28/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCLoader.h"

@interface ASCLoader ()

@property (strong) ASCLoader *strongSelf;
@property (nonatomic) ASCLoaderCompletion completion;
@property (nonatomic) NSData *responseData;

@end

@implementation ASCLoader

- (instancetype)initWithDelegate:(NSObject<ASCLoaderDelegate> *)delegate {
    self = [super init];
    
    if (self) {
        self.delegate = delegate;
    }
    
    return self;
}

- (instancetype)initWithCompletionBlock:(ASCLoaderCompletion)completion {
    self = [super init];
    
    if (self) {
        self.completion = completion;
    }
    
    return self;
}

- (ASCLoaderType)type {
    return ASCLoaderTypeDefault;
}

- (void)createRequest {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];    
}

- (void)processResponse {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (void)prepareForLoad {
    if (self.requestParameters) {
        [self createRequest];
    }
    
    if (!self.strongSelf) {
        self.strongSelf = self;
    }
    
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:self.requestUrl];
    self.request = [request copy];
}

- (void)startLoad {
    [self prepareForLoad];
    
    __weak ASCLoader *weakSelf = self;
    [[ASCNetwork sharedInstance] fetchDataWithUrlRequest:self.request completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            if ([weakSelf.delegate respondsToSelector:@selector(loader:didFinishWithFailure:)]) {
                [weakSelf informDelegateLoadingFailed:error];
            }
            
            return;
        }
        
        weakSelf.responseData = data;
        [weakSelf processResponse];
    }];    
}

- (void)cancelLoad {
    [[ASCNetwork sharedInstance] cancelFetchWithUrlRequest:self.request];
    
    self.strongSelf = nil;
}

- (void)informDelegateLoadingFailed:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(loader:didFinishWithFailure:)]) {
        [self.delegate loader:self didFinishWithFailure:error];
    }
    
    if (self.completion) {
        self.completion(self, error);
    }
    
    self.strongSelf = nil;
}

- (void)informDelegateLoadingFinished {
    if ([self.delegate respondsToSelector:@selector(loaderDidFinishLoadWithSuccess:)]) {
        [self.delegate loaderDidFinishLoadWithSuccess:self];
    }
    
    if (self.completion) {
        self.completion(self, nil);
    }
    
    self.strongSelf = nil;
}

@end
