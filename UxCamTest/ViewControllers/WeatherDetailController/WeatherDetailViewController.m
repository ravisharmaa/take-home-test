//
//  WeatherDetailViewController.m
//  UxCamTest
//
//  Created by Ravi Bastola on 2/24/21.
//

#import "WeatherDetailViewController.h"
#import "NetworkManager.h"
#import "TextFieldAndButtonView.h"
#import "Section.h"
#import "CustomCollectionViewCell.h"
#import "Constants.h"
#import "WeeklyWeather.h"
#import "SingleForecast.h"
#import "CompositionalLayoutsHelper.h"
#import "UIViewController+AlertExtension.h"

@import JGProgressHUD;

@interface WeatherDetailViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UILabel *cityLabel;

@property (nonatomic, strong) UICollectionView *weeklyForecastView;

@property (nonatomic, strong) UILabel *feelsLikeLabel;

@property (nonatomic, strong) UILabel *highLabel;

@property (nonatomic, strong) UILabel *lowLabel;

@property (nonatomic, strong) UILabel *tempratureLabel;

@property (nonatomic, strong) TextFieldAndButtonView *searchView;

@property (nonatomic, strong) UICollectionViewDiffableDataSource  *dataSource;

@property (nonatomic, strong) NSMutableArray<Section *> *sectionArray;

@property (nonatomic, strong) UIImageView *highImageView;

@property (nonatomic, strong) UIImageView *lowImageView;

@property (nonatomic, strong) UIImageView *iconImageView;

@property SingleForecast *foreCast;

@property NSMutableArray * weatherDataArray;
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
    
    self.searchView.searchTextField.text = self.cityName;
    
    [self configureBackgroundview];
    
    [self configureViews];
    
    [self getData];
    
    [self configureLabels];
    
    [self.searchView.goButton addTarget:self action:@selector(handleTap) forControlEvents:UIControlEventTouchUpInside];
}

-(void) handleTap {
    if (self.searchView.searchTextField.text.length > 3) {
        self.cityName = self.searchView.searchTextField.text;
        [self getData];
    }
}

- (void) configureLabels {
    
    self.cityLabel = [[UILabel alloc] init];
    self.cityLabel.text = @"__";
    [self.cityLabel setFont:[UIFont systemFontOfSize:45]];
    [self.cityLabel setTextColor:UIColor.systemBackgroundColor];
    
    
    self.feelsLikeLabel = [[UILabel alloc] init];
    self.feelsLikeLabel.text = @"__";
    [self.feelsLikeLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [self.feelsLikeLabel setTextColor:UIColor.systemBackgroundColor];
    
    UIImage *image = [UIImage imageNamed:@"weather-moon"];
    self.iconImageView = [[UIImageView alloc] initWithImage:image];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.iconImageView.heightAnchor constraintEqualToConstant:40].active = YES;
    [self.iconImageView.widthAnchor constraintEqualToConstant:40].active = YES;
    
    UIImage *highImage = [[UIImage systemImageNamed:@"arrow.up"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.highImageView = [[UIImageView alloc] initWithImage:highImage];
    [self.highImageView setTintColor:UIColor.whiteColor];
    self.highImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.highImageView.heightAnchor constraintEqualToConstant:15].active = YES;
    [self.highImageView.widthAnchor constraintEqualToConstant:15].active = YES;
    
    UIImage *lowImage = [[UIImage systemImageNamed:@"arrow.down"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.lowImageView = [[UIImageView alloc] initWithImage:lowImage];
    [self.lowImageView setTintColor:UIColor.whiteColor];
    self.lowImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.lowImageView.heightAnchor constraintEqualToConstant:15].active = YES;
    [self.lowImageView.widthAnchor constraintEqualToConstant:15].active = YES;
    
    self.highLabel = [[UILabel alloc] init];
    self.highLabel.text = @"__";
    [self.highLabel setFont:[UIFont systemFontOfSize:18]];
    [self.highLabel setTextColor:UIColor.systemBackgroundColor];
    
    self.lowLabel = [[UILabel alloc] init];
    self.lowLabel.text = @"__";
    [self.lowLabel setFont:[UIFont systemFontOfSize:18]];
    [self.lowLabel setTextColor:UIColor.systemBackgroundColor];
    
    self.tempratureLabel = [[UILabel alloc] init];
    self.tempratureLabel.text = @"__";
    [self.tempratureLabel setFont:[UIFont systemFontOfSize:100]];
    [self.tempratureLabel setTextColor:UIColor.systemBackgroundColor];
    
    
#pragma mark: - Embed labels in stack view
    
    
    UIView *dummyView = [[UIView alloc] init];
    
    UIStackView *feelsLikeAndWeatherStack = [[UIStackView alloc] initWithArrangedSubviews:@[self.iconImageView, self.feelsLikeLabel, dummyView]];
    feelsLikeAndWeatherStack.axis = UILayoutConstraintAxisHorizontal;
    
    UIStackView *highLowStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.highImageView, self.highLabel, self.lowImageView, self.lowLabel, dummyView]];
    highLowStackView.axis = UILayoutConstraintAxisHorizontal;
    
    UIStackView *feelsLikeAndHighLowStack = [[UIStackView alloc] initWithArrangedSubviews:@[feelsLikeAndWeatherStack, highLowStackView]];
    feelsLikeAndHighLowStack.axis = UILayoutConstraintAxisVertical;
    
    UIStackView *overAllStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.cityLabel, feelsLikeAndHighLowStack, self.tempratureLabel]];
    overAllStackView.axis = UILayoutConstraintAxisVertical;
    overAllStackView.alignment = UIStackViewAlignmentLeading;
    overAllStackView.distribution = UIStackViewDistributionFillProportionally;
    
    [self.view addSubview:overAllStackView];
    
    overAllStackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [overAllStackView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:200].active = YES;
    [overAllStackView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:40].active = YES;
    [overAllStackView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-80].active = YES;
    [overAllStackView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-330].active = YES;
    
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void) getData {
    
    NetworkManager *manager = [[NetworkManager alloc] init];
    
    self.weatherDataArray = [[NSMutableArray alloc] init];
    
    JGProgressHUD *hud = [[JGProgressHUD alloc] init];
    hud.textLabel.text = @"Loading...";
    [hud showInView:self.view];
    
    
    [manager getData:self.cityName needsHost:YES forURL:WEATHER_URL completion:^(NSDictionary * _Nonnull data, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"%@", error);
        }
        
        if ([data[@"message"] isEqualToString:@"city not found"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showAlertWith:@"Error" andMessage:@"City Not Found"];
                [hud dismiss];
            });
           
        }
        
        self.foreCast = [[SingleForecast alloc] initWithDict:data];
        
    }];
    
    
    [manager getData:self.cityName needsHost:YES forURL:FORECAST_URL completion:^(NSDictionary * _Nonnull data, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"%@", error);
        }
        
        for (NSDictionary *dict in data[@"list"]) {
            WeeklyWeather *weather = [[WeeklyWeather alloc] initWithDict:dict];
            [self.weatherDataArray addObject:weather];
        }
        
        __weak typeof(self) weakSelf = self;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf configureDataSource];
            [strongSelf updateLabelsWith:self.foreCast];
            [hud dismiss];
        });
        
    }];
}

- (void) configureBackgroundview {
    
    UIImage *parisImage = [UIImage imageNamed:@"bg-1"];
    
    self.backgroundImageView = [[UIImageView alloc] initWithImage:parisImage];
    
    CAGradientLayer *gradientMask = [CAGradientLayer layer];
    gradientMask.frame = self.backgroundImageView.bounds;
    gradientMask.colors = @[(id)[UIColor blackColor].CGColor,
                            (id)[UIColor whiteColor].CGColor];
    
    self.backgroundImageView.layer.mask = gradientMask;
    
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addSubview: self.backgroundImageView];
    
    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_backgroundImageView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [_backgroundImageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [_backgroundImageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [_backgroundImageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    
    self.searchView = [[TextFieldAndButtonView alloc] init];
    
    [self.view addSubview:self.searchView];
    
    [self.searchView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20].active = YES;
    [self.searchView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:5].active = YES;
    [self.searchView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-5].active = YES;
    
}

- (void) configureViews {
    
    self.weeklyForecastView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[CompositionalLayoutsHelper weatherDetailLayout]];
    
    [_weeklyForecastView registerClass: CustomCollectionViewCell.class forCellWithReuseIdentifier:@"reuseMe"];
    
    [self.view addSubview:_weeklyForecastView];
    
    self.weeklyForecastView.backgroundColor = [UIColor.systemGrayColor  colorWithAlphaComponent:0.2];
    
    self.weeklyForecastView.layer.cornerRadius = 8;
    
    
    _weeklyForecastView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.weeklyForecastView.heightAnchor constraintEqualToConstant:100].active = YES;
    [self.weeklyForecastView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-100].active = YES;
    [self.weeklyForecastView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:8].active = YES;
    [self.weeklyForecastView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor].active = YES;
    
}

- (void) configureDataSource {
    
    self.dataSource = [[UICollectionViewDiffableDataSource alloc] initWithCollectionView:_weeklyForecastView cellProvider:^UICollectionViewCell * _Nullable(UICollectionView * collectionView, NSIndexPath * indexPath, id identifier) {
        
        CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseMe" forIndexPath:indexPath];
        
        WeeklyWeather *weather = self.weatherDataArray[indexPath.item];
        [cell configureWithWeather:weather];
        
        cell.layer.cornerRadius = 8;
        
        return cell;
    }];
    
    NSDiffableDataSourceSnapshot *snapshot = [[NSDiffableDataSourceSnapshot alloc] init];
    
    _sectionArray = [[NSMutableArray alloc] init];
    
    Section *section = [[Section alloc] init];
    
    
    [self.sectionArray addObject:section];
    
    [snapshot appendSectionsWithIdentifiers: _sectionArray];
    
    [snapshot appendItemsWithIdentifiers:self.weatherDataArray];
    
    [_dataSource applySnapshot:snapshot animatingDifferences:YES];
    
}

-(void) updateLabelsWith :(SingleForecast *)foreCast {
    self.cityLabel.text = self.cityName;
    self.highLabel.text = [@(foreCast.maximumTemp).stringValue stringByAppendingString:@"°"];
    self.lowLabel.text = [@(foreCast.minimumTemp).stringValue stringByAppendingString:@"°"];
    self.tempratureLabel.text = [@(foreCast.currentTemp).stringValue stringByAppendingString:@"°"];
    self.feelsLikeLabel.text = foreCast.weather;
    self.searchView.searchTextField.text = self.cityName;
}
@end
