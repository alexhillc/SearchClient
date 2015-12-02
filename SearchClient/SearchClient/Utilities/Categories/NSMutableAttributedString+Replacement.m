//
//  NSAttributedString+Replacement.m
//  SearchClient
//
//  Created by Alex Hill on 11/23/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "NSMutableAttributedString+Replacement.h"

@implementation NSMutableAttributedString (Replacement)

- (void)replaceOccurancesOfStrings:(NSArray *)strings withAttributes:(NSDictionary *)attributes {
    [strings enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *plainString = self.string;
        NSRange effectedRange = [plainString rangeOfString:obj options:NSCaseInsensitiveSearch];
        
        [self setAttributes:attributes range:effectedRange];
    }];

}

@end
