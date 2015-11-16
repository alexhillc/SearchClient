//
//  ASCDataStore.h
//  SearchClient
//
//  Created by Alex Hill on 10/28/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *ASCDataStoreOperationParamsKey;

@interface ASCDataStore : NSObject

+ (ASCDataStore *)sharedInstance;
- (void)saveObject:(NSObject *)object forKey:(NSString *)key;
- (void)deleteObject:(NSObject *)object forKey:(NSString *)key;
- (NSObject *)objectForKey:(NSString *)key;

@end
