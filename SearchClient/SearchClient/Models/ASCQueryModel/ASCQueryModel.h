//
//  ASCQueryModel.h
//  SearchClient
//
//  Created by Alex Hill on 11/14/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASCQueryModel : NSObject

@property (nonatomic, strong) NSDate *queryDate;
@property (nonatomic, copy) NSString *queryString;

@end
