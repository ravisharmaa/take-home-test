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
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
            
            NSLog(@"%@", self.foreCast.weather);
            
            [hud dismiss];
        });
        
    }];
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
    
    self.searchView = [[TextFieldAndButtonView alloc] init];
    
    [self.view addSubview:self.searchView];
    
    [self.searchView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20].active = YES;
    [self.searchView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:20].active = YES;
    [self.searchView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-20].active = YES;
    
}

- (void) configureViews {
    
    NSCollectionLayoutDimension *itemWidth = [NSCollectionLayoutDimension fractionalWidthDimension:1];
    
    NSCollectionLayoutDimension *itemHeight = [NSCollectionLayoutDimension fractionalHeightDimension:1];
    
    NSCollectionLayoutSize *itemSize = [NSCollectionLayoutSize sizeWithWidthDimension:itemWidth heightDimension:itemHeight];
    
    NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
    
    item.contentInsets = NSDirectionalEdgeInsetsMake(5, 5, 0, 2);
    
    NSCollectionLayoutDimension *widthDimension = [NSCollectionLayoutDimension fractionalWidthDimension:0.2];
    
    NSCollectionLayoutDimension *heightDimension = [NSCollectionLayoutDimension absoluteDimension:80];
    
    NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:widthDimension heightDimension:heightDimension];
    
    
    NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:groupSize subitems:@[item]];
    
    NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];
    
    section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehaviorContinuous;
    
    section.contentInsets = NSDirectionalEdgeInsetsMake(0, 20, 0, 0);
    
    UICollectionViewCompositionalLayout *layout = [[UICollectionViewCompositionalLayout alloc] initWithSection:section];
    
    
    self.weeklyForecastView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    [_weeklyForecastView registerClass: CustomCollectionViewCell.class forCellWithReuseIdentifier:@"reuseMe"];
    
    [self.view addSubview:_weeklyForecastView];
    
    self.weeklyForecastView.backgroundColor = UIColor.clearColor;
    
    _weeklyForecastView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.weeklyForecastView.heightAnchor constraintEqualToConstant:100].active = YES;
    [self.weeklyForecastView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-60].active = YES;
    [self.weeklyForecastView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor].active = YES;
    [self.weeklyForecastView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor].active = YES;
    
}

- (void) configureDataSource {
    
    self.dataSource = [[UICollectionViewDiffableDataSource alloc] initWithCollectionView:_weeklyForecastView cellProvider:^UICollectionViewCell * _Nullable(UICollectionView * collectionView, NSIndexPath * indexPath, id identifier) {
        
        CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseMe" forIndexPath:indexPath];
        
        WeeklyWeather *weather = self.weatherDataArray[indexPath.item];
        
        NSLog(@"%@", [[@(weather.temp) stringValue] stringByAppendingString:@" C"]);
        
        [cell configureWithWeather:weather];
        
        cell.layer.cornerRadius = 8;
        
        return cell;
    }];
    
    NSDiffableDataSourceSnapshot *snapshot = [[NSDiffableDataSourceSnapshot alloc] init];
    
    _sectionArray = [[NSMutableArray alloc] init];
    
    Section *section = [[Section alloc] init];
    
    section.name = @"main";
    
    [self.sectionArray addObject:section];
    
    [snapshot appendSectionsWithIdentifiers: _sectionArray];
    
    [snapshot appendItemsWithIdentifiers:self.weatherDataArray];
    
    [_dataSource applySnapshot:snapshot animatingDifferences:YES];
    
}

@end
