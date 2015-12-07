//
//  NSAttributedString+Replacement.h
//  SearchClient
//
//  Created by Alex Hill on 11/23/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Replacement)

- (void)replaceOccurancesOfBeginningTag:(NSString *)beginningTag endingTag:(NSString *)endingTag withAttributes:(NSDictionary*)attributes;

@end
