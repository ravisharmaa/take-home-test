//
//  CustomCollectionViewCell.m
//  UxCamTest
//
//  Created by Ravi Bastola on 2/26/21.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

- (NSDictionary *)imageMap {
    static NSDictionary *_imageMap = nil;
    if (! _imageMap) {
        _imageMap = @{
            @"01d" : @"weather-clear",
            @"02d" : @"weather-few",
            @"03d" : @"weather-few",
            @"04d" : @"weather-broken",
            @"09d" : @"weather-shower",
            @"10d" : @"weather-rain",
            @"11d" : @"weather-tstorm",
            @"13d" : @"weather-snow",
            @"50d" : @"weather-mist",
            @"01n" : @"weather-moon",
            @"02n" : @"weather-few-night",
            @"03n" : @"weather-few-night",
            @"04n" : @"weather-broken",
            @"09n" : @"weather-shower",
            @"10n" : @"weather-rain-night",
            @"11n" : @"weather-tstorm",
            @"13n" : @"weather-snow",
            @"50n" : @"weather-mist",
        };
    }
    return _imageMap;
}


-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViews];
    }
    return self;
}


- (void) configureViews {
    self.weatherImage = [[UIImageView alloc] init];
    
    
    [self addSubview:_weatherImage];
    
    self.weatherImage.translatesAutoresizingMaskIntoConstraints = false;
    
    [self.weatherImage.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    [self.weatherImage.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    
    [self.weatherImage.heightAnchor constraintEqualToConstant:45].active = YES;
    [self.weatherImage.widthAnchor constraintEqualToConstant:45].active = YES;
    
    
}

- (void) configureWithWeather:(WeeklyWeather *)weather {
    //NSLog(@"%@", self.imageMap[weather.icon]);
     self.weatherImage.image = [UIImage imageNamed:self.imageMap[weather.icon]];
    self.weatherImage.contentMode = UIViewContentModeScaleAspectFill;
}

@end
