//
//  SingleForecast.h
//  UxCamTest
//
//  Created by Ravi Bastola on 2/26/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingleForecast : NSObject

@property int maximumTemp;
@property int minimumTemp;
@property int currentTemp;
@property NSString *weather;
@property NSString *weatherIcon;

- (instancetype) initWithTemp: (int) maxTemp minTem: (int) minimumTemp currentTemp: (int) currentTemp weather: (NSString *)weather icon: (NSString *)icon;

- (instancetype) initWithDict: (NSDictionary *) dict;

@end

NS_ASSUME_NONNULL_END
