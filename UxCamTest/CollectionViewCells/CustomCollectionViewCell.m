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
    
    [self.weatherImage.topAnchor constraintEqualToAnchor:self.topAnchor constant:8].active = YES;
    [self.weatherImage.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    
    [self.weatherImage.heightAnchor constraintEqualToConstant:35].active = YES;
    [self.weatherImage.widthAnchor constraintEqualToConstant:35].active = YES;
    
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.text = @"__";
    [self.dateLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.dateLabel setTextColor:UIColor.systemBackgroundColor];
    
    [self addSubview:self.dateLabel];
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.dateLabel.topAnchor constraintEqualToAnchor:self.weatherImage.bottomAnchor constant:1].active = YES;
    [self.dateLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.text = @"__";
    [self.timeLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.timeLabel setTextColor:UIColor.systemBackgroundColor];
    
    [self addSubview:self.timeLabel];
    self.timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.timeLabel.topAnchor constraintEqualToAnchor:self.dateLabel.bottomAnchor constant:5].active = YES;
    [self.timeLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    
    
}

- (void) configureWithWeather:(WeeklyWeather *)weather {
    self.weatherImage.image = [UIImage imageNamed:self.imageMap[weather.icon]];
    self.weatherImage.contentMode = UIViewContentModeScaleAspectFill;
    self.dateLabel.text = [@(weather.temp).stringValue stringByAppendingString:@"°"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
     NSDate *date = [dateFormatter dateFromString:weather.time];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
    NSInteger hour = [components hour];
    self.timeLabel.text = [@(hour).stringValue stringByAppendingString:@":00"];
}

@end
