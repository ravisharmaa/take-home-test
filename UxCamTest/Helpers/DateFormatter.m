//
//  DateFormatter.m
//  UxCamTest
//
//  Created by Javra Software on 2/26/21.
//

#import "DateFormatter.h"
#import "Constants.h"

@implementation DateFormatter

#pragma mark - Formats the date accordingly.

+ (NSString *)getHourFromString:(NSString *)stringDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [dateFormatter dateFromString:stringDate];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
    NSInteger hour = [components hour];
    return [@(hour).stringValue stringByAppendingString:@":00"];
}

@end
