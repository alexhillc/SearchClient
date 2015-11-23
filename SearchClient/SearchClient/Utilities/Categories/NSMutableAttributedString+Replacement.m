//
//  NSAttributedString+Replacement.m
//  SearchClient
//
//  Created by Alex Hill on 11/23/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "NSMutableAttributedString+Replacement.h"

@implementation NSMutableAttributedString (Replacement)

- (void)replaceOccurancesOfHtmlTag:(NSString*)tagName withAttributes:(NSDictionary*)attributes {
    NSString *openTag = [NSString stringWithFormat:@"<%@>", tagName];
    NSString *closeTag = [NSString stringWithFormat:@"</%@>", tagName];
    
    while (YES)   {
        NSString *plainString = [self string];
        NSRange openTagRange = [plainString rangeOfString:openTag];
        if (openTagRange.length == 0) {
            break;
        }
        
        NSRange searchRange;
        searchRange.location = openTagRange.location + openTagRange.length;
        searchRange.length = [plainString length] - searchRange.location;
        NSRange closeTagRange = [plainString rangeOfString:closeTag options:0 range:searchRange];
        
        NSRange effectedRange;
        effectedRange.location = openTagRange.location + openTagRange.length;
        effectedRange.length = closeTagRange.location - effectedRange.location;
        
        [self setAttributes:attributes range:effectedRange];
        [self deleteCharactersInRange:closeTagRange];
        [self deleteCharactersInRange:openTagRange];
    }    
}


@end
