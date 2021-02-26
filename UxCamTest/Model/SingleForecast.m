//
//  SingleForecast.m
//  UxCamTest
//
//  Created by Javra Software on 2/26/21.
//

#import "SingleForecast.h"

@implementation SingleForecast

- (instancetype)initWithTemp:(int)maxTemp minTem:(int)minimumTemp currentTemp:(int)currentTemp weather:(NSString *)weather icon:(NSString *)icon {
    self = [super init];
    
    if (self) {
        _maximumTemp = maxTemp;
        _minimumTemp = minimumTemp;
        _currentTemp = currentTemp;
        _weather = weather;
        _weatherIcon = icon;
    }
    
    return self;
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    int maxTemp = [dict[@"main"][@"temp_max"]  integerValue] - 273.15;
    int minimumtemp = [dict[@"main"][@"temp_min"]  integerValue] - 273.15;
    int currentTemp = [dict[@"main"][@"temp"]  integerValue] - 273.15;
    NSString *weather = dict[@"weather"][0][@"main"];
    NSString *icon = dict[@"weather"][0][@"icon"];
    
    return [ self initWithTemp:maxTemp minTem:minimumtemp currentTemp:currentTemp weather:weather icon:icon];
}

@end
