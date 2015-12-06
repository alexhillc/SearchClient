//
//  NSDate+ISO8601.m
//  SearchClient
//
//  Created by Alex Hill on 12/5/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "NSDate+ISO8601.h"

@implementation NSDate (ISO8601)

+ (NSDate *)asc_dateFromISO8601String:(NSString *)iso8601 {
    // Return nil if nil is given
    if (!iso8601 || [iso8601 isEqual:[NSNull null]]) {
        return nil;
    }
    
    // Parse number
    if ([iso8601 isKindOfClass:[NSNumber class]]) {
        return [NSDate dateWithTimeIntervalSince1970:[(NSNumber *)iso8601 doubleValue]];
    }
    
    // Parse string
    else if ([iso8601 isKindOfClass:[NSString class]]) {
        const char *str = [iso8601 cStringUsingEncoding:NSUTF8StringEncoding];
        size_t len = strlen(str);
        if (len == 0) {
            return nil;
        }
        
        struct tm tm;
        char newStr[25] = "";
        BOOL hasTimezone = NO;
        
        // 2014-03-30T09:13:00Z
        if (len == 20 && str[len - 1] == 'Z') {
            strncpy(newStr, str, len - 1);
        }
        
        // 2014-03-30T09:13:00-07:00
        else if (len == 25 && str[22] == ':') {
            strncpy(newStr, str, 19);
            hasTimezone = YES;
        }
        
        // 2014-03-30T09:13:00.000Z
        else if (len == 24 && str[len - 1] == 'Z') {
            strncpy(newStr, str, 19);
        }
        
        // 2014-03-30T09:13:00.000-07:00
        else if (len == 29 && str[26] == ':') {
            strncpy(newStr, str, 19);
            hasTimezone = YES;
        }
        
        // Poorly formatted timezone
        else {
            strncpy(newStr, str, len > 24 ? 24 : len);
        }
        
        // Timezone
        size_t l = strlen(newStr);
        if (hasTimezone) {
            strncpy(newStr + l, str + len - 6, 3);
            strncpy(newStr + l + 3, str + len - 2, 2);
        } else {
            strncpy(newStr + l, "+0000", 5);
        }
        
        // Add null terminator
        newStr[sizeof(newStr) - 1] = 0;
        
        if (strptime(newStr, "%FT%T%z", &tm) == NULL) {
            return nil;
        }
        
        time_t t;
        t = mktime(&tm);
        
        return [NSDate dateWithTimeIntervalSince1970:t];
    }
    
    NSAssert1(NO, @"Failed to parse date: %@", iso8601);
    return nil;
}

- (NSString *)asc_briefTimeInWords {
    NSTimeInterval seconds = fabs([self timeIntervalSinceNow]);
    
    static NSNumberFormatter *numberFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
        numberFormatter.currencySymbol = @"";
        numberFormatter.maximumFractionDigits = 0;
    });
    
    // Seconds
    if (seconds < 60.0) {
        if (seconds < 2.0) {
            return @"1s";
        }
        return [NSString stringWithFormat:@"%lds", (long)seconds];
    }
    
    NSTimeInterval minutes = round(seconds / 60.0);
    
    // Minutes
    if (minutes >= 0.0 && minutes < 60.0) {
        if (minutes < 2.0) {
            return @"1m";
        }
        return [NSString stringWithFormat:@"%ldm", (long)minutes];
    }
    
    // Hours
    else if (minutes >= 60.0 && minutes < 1440.0) {
        NSInteger hours = (NSInteger)((double)minutes / 60.0);
        if (hours < 2) {
            return @"1h";
        }
        return [NSString stringWithFormat:@"%ldh", (long)hours];
    }
    
    // Days
    else if (minutes >= 1440.0 && minutes < 525600.0) {
        NSInteger days = (NSInteger)((double)minutes / 1440.0);
        if (days < 2) {
            return @"1d";
        }
        return [NSString stringWithFormat:@"%@d",
                [numberFormatter stringFromNumber:[NSNumber numberWithInteger:days]]];
    }
    
    // Years
    else if (minutes >= 525600.0) {
        NSInteger years = (NSInteger)((double)minutes / 525600.0);
        if (years < 2) {
            return @"1y";
        }
        return [NSString stringWithFormat:@"%@y",
                [numberFormatter stringFromNumber:[NSNumber numberWithInteger:years]]];
    }
    
    return nil;
}

@end
