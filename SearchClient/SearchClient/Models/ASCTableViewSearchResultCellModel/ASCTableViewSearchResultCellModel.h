//
//  ASCTableViewSearchResultCellModel.h
//  SearchClient
//
//  Created by Alex Hill on 12/3/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASCSearchResultModel;

@interface ASCTableViewSearchResultCellModel : NSObject

+ (NSArray *)cellModelsForResultModels:(NSArray *)models;

- (instancetype)initWithModel:(ASCSearchResultModel *)model;
- (instancetype)initWithModels:(NSArray *)models;

@property (nonatomic, copy) NSAttributedString *titleLabelText;
@property (nonatomic, copy) NSAttributedString *contentLabelText;
@property (nonatomic, copy) NSString *urlLabelText;
@property (nonatomic, strong) NSURL *url;

@end
