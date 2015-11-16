//
//  ASCOperation.m
//  SearchClient
//
//  Created by Alex Hill on 10/28/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCLoader.h"
#import "AFNetworking.h"

@interface ASCLoader ()

@property (nonatomic, strong) ASCLoader *strongSelf;
    
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

+ (NSString *)baseSearchUrl {
    return @"https://ajax.googleapis.com/ajax/services/search";
}

- (ASCLoaderType)type {
    return ASCLoaderTypeDefault;
}

- (NSString *)createRequest {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    
    return nil;
}

- (void)processResponse {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (void)startLoad {
    if (self.requestParameters) {
        self.request = [self createRequest];
    }
    
    if (!self.strongSelf) {
        self.strongSelf = self;
    }
    
    __weak ASCLoader *weakSelf = self;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    self.operation = [manager GET:self.request parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        weakSelf.responseObject = responseObject;
        [weakSelf processResponse];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if ([weakSelf.delegate respondsToSelector:@selector(loader:didFinishWithFailure:)]) {
            [weakSelf informDelegateLoadingFailed:error];
        }
    }];
}

- (void)cancelLoad {
    __weak ASCLoader *weakSelf = self;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.operationQueue.operations enumerateObjectsUsingBlock:^(__kindof NSOperation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:weakSelf.operation]) {
            [obj cancel];
        }
    }];
    
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
