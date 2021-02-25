//
//  WeatherDetailViewController.m
//  UxCamTest
//
//  Created by Ravi Bastola on 2/24/21.
//

#import "WeatherDetailViewController.h"
#import "NetworkManager.h"

@interface WeatherDetailViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;


@end


@implementation WeatherDetailViewController

- (id)initWithCityName:(NSString *)cityName {
    if (self = [super init]) {
        _cityName = cityName;
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    [self configureBackgroundview];
    
    
}

- (void) configureBackgroundview {
    
    UIImage *parisImage = [UIImage imageNamed:@"bg-1"];
    
    self.backgroundImageView = [[UIImageView alloc] initWithImage:parisImage];
    
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addSubview: self.backgroundImageView];
    
    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_backgroundImageView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [_backgroundImageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [_backgroundImageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [_backgroundImageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
}

@end
