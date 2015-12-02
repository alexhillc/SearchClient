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
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSAttributedString *searchDesc;
@property (nonatomic, copy) NSString *displayUrl;
@property (nonatomic, strong) NSURL *url;

+ (ASCSearchResultModel *)modelForDictionary:(NSDictionary *)dic requestParams:(NSArray *)params;

- (instancetype)initWithDictionary:(NSDictionary *)dic requestParams:(NSArray *)params;

@end
