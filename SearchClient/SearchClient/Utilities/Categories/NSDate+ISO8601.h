//
//  NSDate+ISO8601.h
//  SearchClient
//
//  Created by Alex Hill on 12/5/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ISO8601)

/**
 Taken from https://github.com/soffes/SAMCategories/tree/master/SAMCategories
 
 @brief Returns a new date represented by an ISO8601 string.
 
 @param iso8601String An ISO8601 string
 
 @return Date represented by the ISO8601 string
 */
+ (NSDate *)asc_dateFromISO8601String:(NSString *)iso8601String;


/**
 Taken from https://github.com/soffes/SAMCategories/tree/master/SAMCategories
 
 @brief Returns a string representing the time interval from now in words (including seconds). 
 The strings produced by this method will be similar to produced by Twitter for iPhone or Tweetbot in the top right of the tweet cells.
 Internally, this does not use `timeInWordsFromTimeInterval:includingSeconds:`.
 @return A string representing the time interval from now in words
 */
- (NSString *)asc_briefTimeInWords;

@end
