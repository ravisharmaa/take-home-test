//
//  CustomCollectionViewCell.m
//  UxCamTest
//
//  Created by Ravi Bastola on 2/26/21.
//

#import "CustomCollectionViewCell.h"
#import "ImageMapper.h"
#import "DateFormatter.h"

#pragma mark - CollectionViewCell and its properties

@implementation CustomCollectionViewCell

-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViews];
    }
    return self;
}

// preparigng views

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
    self.weatherImage.image = [UIImage imageNamed: [ImageMapper getImageOfName:weather.icon]];
    self.weatherImage.contentMode = UIViewContentModeScaleAspectFill;
    self.dateLabel.text = [@(weather.temp).stringValue stringByAppendingString:@"°"];
    self.timeLabel.text = [DateFormatter getHourFromString:weather.time];
}

@end
