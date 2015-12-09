//
//  NSAttributedString+Replacement.h
//  SearchClient
//
//  Created by Alex Hill on 11/23/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Replacement)

/**
 * @brief Replaces the range of characters between the beginning and ending tag with the supplied attributes
 */
- (void)replaceOccurancesOfBeginningTag:(NSString *)beginningTag endingTag:(NSString *)endingTag withAttributes:(NSDictionary*)attributes;

@end
