//
//  ASCLocalLoader.h
//  SearchClient
//
//  Created by Alex Hill on 12/9/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCLoader.h"

@interface ASCLocalLoader : ASCLoader

- (void)saveToCache:(NSString *)query;

@end
