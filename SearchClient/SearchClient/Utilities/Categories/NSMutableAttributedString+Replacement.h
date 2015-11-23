//
//  NSAttributedString+Replacement.h
//  SearchClient
//
//  Created by Alex Hill on 11/23/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Replacement)

- (void)replaceOccurancesOfHtmlTag:(NSString*)tagName withAttributes:(NSDictionary*)attributes;

@end
