//
//  Constants.h
//  UxCamTest
//
//  Created by Ravi Bastola on 2/23/21.
//

#ifndef Constants_h
#define Constants_h
#import "Reachability.h"

#define SCHEME @"https"
#define BASE_URL @"api.openweathermap.org"
#define APP_ID @"appid"
#define API_KEY @"cd1eb04f6c3bdec3ac45dbf825541080"
#define WEATHER_URL @"/data/2.5/weather"
#define FORECAST_URL @"/data/2.5/forecast"
#define QUERY_STRING_FOR_LOCATION @"q"
#define MAGNIFYING_GLASS @"magnifyingglass"
#define CITY_API @"https://uxcam-api.herokuapp.com"
#define DATE_FORMAT @"yyyy-MM-dd HH:mm:ss"
#define HAS_INTERNET [[Reachability reachabilityForInternetConnection] isReachable]

#endif /* Constants_h */
