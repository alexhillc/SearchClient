//
//  ASCWebSearchResultModel.h
//  SearchClient
//
//  Created by Alex Hill on 11/10/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASCSearchResultModel : NSObject

@property (nonatomic, copy) NSString *googleSearchResultClass;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleNoFormatting;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSURL *visibleUrl;

+ (ASCSearchResultModel *)modelForDictionary:(NSDictionary *)dic;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
