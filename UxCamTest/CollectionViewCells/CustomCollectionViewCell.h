//
//  CustomCollectionViewCell.h
//  UxCamTest
//
//  Created by Ravi Bastola on 2/26/21.
//

#import <UIKit/UIKit.h>
#import "WeeklyWeather.h"

@interface CustomCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *weatherImage;

- (void) configureWithWeather :(WeeklyWeather *)weather;

@property (nonatomic) NSDictionary * imageMap;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@end


