//
//  ASCWebSearchResultModel.h
//  SearchClient
//
//  Created by Alex Hill on 11/10/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASCSearchResultModel : NSObject

@property (nonatomic, strong) NSString *googleSearchResultClass;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *titleNoFormatting;
@property (nonatomic, strong) NSString *content;

@property (nonatomic) CGSize thumbSize;
@property (nonatomic) CGSize size;
@property (nonatomic, strong) NSURL *thumbUrl;
@property (nonatomic, strong) NSURL *url;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
