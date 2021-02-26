//
//  WeeklyWeather.h
//  UxCamTest
//
//  Created by Ravi Bastola on 2/26/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeeklyWeather : NSObject

@property int temp;
@property NSString *time;

@property NSString *icon;


- (instancetype) initWithTemp :(int) temp time: (NSString *)time andIcon: (NSString *)icon;

- (instancetype) initWithDict :(NSDictionary *) dict;



@end

NS_ASSUME_NONNULL_END
