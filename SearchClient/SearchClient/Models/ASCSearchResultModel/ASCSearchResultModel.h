//
//  ASCWebSearchResultModel.h
//  SearchClient
//
//  Created by Alex Hill on 11/10/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASCSearchResultModel : NSObject

@property (nonatomic, copy) NSString *bingSearchResultClass;
@property (nonatomic, copy) NSString *searchId;
@property (nonatomic, copy) NSAttributedString *title;
@property (nonatomic, copy) NSAttributedString *searchDesc;
@property (nonatomic, copy) NSString *displayUrl;
@property (nonatomic, strong) NSURL *url;

/**
 * @brief Gives an abstract model given a valid dictionary
 */
+ (ASCSearchResultModel *)modelForDictionary:(NSDictionary *)dic;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
