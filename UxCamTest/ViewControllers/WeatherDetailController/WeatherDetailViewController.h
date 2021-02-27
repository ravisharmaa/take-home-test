//
//  WeatherDetailViewController.h
//  UxCamTest
//
//  Created by Ravi Bastola on 2/24/21.
//

#import <UIKit/UIKit.h>
#import "NetworkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherDetailViewController : UIViewController

@property (nonatomic, assign) NSString * cityName;

-(id) initWithCityName: (NSString *) cityName;

@property (nonatomic, strong) NetworkManager *manager;

@end

NS_ASSUME_NONNULL_END
