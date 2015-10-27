//
//  ASCNetworkManager.m
//  SearchClient
//
//  Created by Alex Hill on 10/26/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCNetworkManager.h"
#import "AFNetworking.h"

@implementation ASCNetworkManager

+ (ASCNetworkManager *)sharedInstance {
    static ASCNetworkManager *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[ASCNetworkManager alloc] init];
    });
    
    return sharedInstance;
}

@end

