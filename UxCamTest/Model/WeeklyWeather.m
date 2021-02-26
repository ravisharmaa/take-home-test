//
//  WeeklyWeather.m
//  UxCamTest
//
//  Created by Ravi Bastola on 2/26/21.
//

#import "WeeklyWeather.h"

@implementation WeeklyWeather

- (instancetype)initWithTemp:(int)temp time:(NSString *)time andIcon:(NSString *)icon {
    
    if (self = [super init]) {
        self.time = time;
        self.icon = icon;
        self.temp = temp;
    }
    
    return  self;
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    int temp = [dict[@"main"][@"temp"]  integerValue] - 273.15;
    
    NSString *icon = dict[@"weather"][0][@"icon"];
    
    NSString *time = dict[@"dt_text"];
    
    return [self initWithTemp:temp time:time andIcon:icon];
}


@end
