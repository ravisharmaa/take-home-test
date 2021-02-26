//
//  CustomCollectionViewCell.m
//  UxCamTest
//
//  Created by Ravi Bastola on 2/26/21.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.weatherImage = [[UIImageView alloc] init];
    }
    return self;
}

- (void) configureWithWeather:(WeeklyWeather *)weather {
    
}

@end
