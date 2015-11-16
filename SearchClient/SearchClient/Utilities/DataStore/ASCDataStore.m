//
//  ASCDataStore.m
//  SearchClient
//
//  Created by Alex Hill on 10/28/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCDataStore.h"

NSString *ASCDataStoreOperationParamsKey = @"ASCDataStoreOperationParamsKey";

@implementation ASCDataStore

+ (ASCDataStore *)sharedInstance {
    static ASCDataStore *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[ASCDataStore alloc] init];
    });
    
    return sharedInstance;
}

- (void)saveObject:(NSObject *)object forKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:object forKey:key];
}

- (void)deleteObject:(NSObject *)object forKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSAssert([defaults objectForKey:key], @"Object does not exist in store");
    if ([defaults objectForKey:key]) {
        [defaults removeObjectForKey:key];
    }
}

- (NSObject *)objectForKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults objectForKey:key];
}

@end
