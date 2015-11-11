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
@property (nonatomic, strong) NSString *unescapedUrl;
@property (nonatomic, strong) NSString *visibleUrl;
@property (nonatomic, strong) NSString *cacheUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *titleNoFormatting;
@property (nonatomic, strong) NSString *content;

@end
